From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 sample
 rate ranges correctly
Date: Fri, 11 Jun 2010 17:04:35 +0200
Message-ID: <20100611150435.GS2698@buzzloop.caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
	<1276263191-8652-4-git-send-email-daniel@caiaq.de>
	<AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 44EF1244DE
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 17:04:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <alexlee188@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 10:59:44PM +0800, Alex Lee wrote:
> If the device has a variable clock, it may report a RES of only 1.  So you
> may end up with thousands (and even millions) of sample rates.  It might be
> better to have separate code to cater to discrete clocks vs variable clocks.

AFAIK, ALSA cannot cope with that yet. Am I right?

Daniel



> On Fri, Jun 11, 2010 at 9:33 PM, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > A device may report its supported sample rates in ranges rather than in
> > discrete triplets. The code used to only parse the MIN field instead of
> > properly paying attention to the MAX and RES values.
> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Reported-by: Alex Lee <alexlee188@gmail.com>
> > ---
> >  sound/usb/format.c |   80
> > ++++++++++++++++++++++++++++++++++++++++-----------
> >  1 files changed, 62 insertions(+), 18 deletions(-)
> >
> > diff --git a/sound/usb/format.c b/sound/usb/format.c
> > index 8eccf17..e946db7 100644
> > --- a/sound/usb/format.c
> > +++ b/sound/usb/format.c
> > @@ -206,6 +206,47 @@ static int parse_audio_format_rates_v1(struct
> > snd_usb_audio *chip, struct audiof
> >  }
> >
> >  /*
> > + * Helper function to walk the array of sample rate triplets reported by
> > + * the device. The problem is that we need to parse whole array first to
> > + * get to know how many sample rates we have to expect.
> > + * Then fp->rate_table can be allocated and filled.
> > + */
> > +static int parse_uac2_sample_rate_range(struct audioformat *fp, int
> > nr_triplets,
> > +                                       const unsigned char *data)
> > +{
> > +       int i, nr_rates = 0;
> > +
> > +       fp->rates = fp->rate_min = fp->rate_max = 0;
> > +
> > +       for (i = 0; i < nr_triplets; i++) {
> > +               int min = combine_quad(&data[2 + 12 * i]);
> > +               int max = combine_quad(&data[6 + 12 * i]);
> > +               int res = combine_quad(&data[10 + 12 * i]);
> > +               int rate;
> > +
> > +               if ((max < 0) || (min < 0) || (res < 0) || (max < min))
> > +                       continue;
> > +
> > +               for (rate = min; rate <= max; rate += res) {
> > +                       if (fp->rate_table)
> > +                               fp->rate_table[nr_rates] = rate;
> > +                       if (!fp->rate_min || rate < fp->rate_min)
> > +                               fp->rate_min = rate;
> > +                       if (!fp->rate_max || rate > fp->rate_max)
> > +                               fp->rate_max = rate;
> > +                       fp->rates |= snd_pcm_rate_to_rate_bit(rate);
> > +                       nr_rates++;
> > +
> > +                       /* avoid endless loop */
> > +                       if (res == 0)
> > +                               break;
> > +               }
> > +       }
> > +
> > +       return nr_rates;
> > +}
> > +
> > +/*
> >  * parse the format descriptor and stores the possible sample rates
> >  * on the audioformat table (audio class v2).
> >  */
> > @@ -215,7 +256,7 @@ static int parse_audio_format_rates_v2(struct
> > snd_usb_audio *chip,
> >  {
> >        struct usb_device *dev = chip->dev;
> >        unsigned char tmp[2], *data;
> > -       int i, nr_rates, data_size, ret = 0;
> > +       int nr_triplets, data_size, ret = 0;
> >        int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf,
> > fp->clock);
> >
> >        if (clock < 0) {
> > @@ -237,8 +278,8 @@ static int parse_audio_format_rates_v2(struct
> > snd_usb_audio *chip,
> >                goto err;
> >        }
> >
> > -       nr_rates = (tmp[1] << 8) | tmp[0];
> > -       data_size = 2 + 12 * nr_rates;
> > +       nr_triplets = (tmp[1] << 8) | tmp[0];
> > +       data_size = 2 + 12 * nr_triplets;
> >        data = kzalloc(data_size, GFP_KERNEL);
> >        if (!data) {
> >                ret = -ENOMEM;
> > @@ -259,26 +300,29 @@ static int parse_audio_format_rates_v2(struct
> > snd_usb_audio *chip,
> >                goto err_free;
> >        }
> >
> > -       fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
> > +       /* Call the triplet parser, and make sure fp->rate_table is NULL.
> > +        * We just use the return value to know how many sample rates we
> > +        * will have to deal with. */
> > +       kfree(fp->rate_table);
> > +       fp->rate_table = NULL;
> > +       fp->nr_rates = parse_uac2_sample_rate_range(fp, nr_triplets, data);
> > +
> > +       if (fp->nr_rates == 0) {
> > +               snd_printk(KERN_ERR "%s(): unable to parse sample rate
> > triplets\n",
> > +                               __func__);
> > +               ret = -EINVAL;
> > +               goto err_free;
> > +       }
> > +
> > +       fp->rate_table = kmalloc(sizeof(int) * fp->nr_rates, GFP_KERNEL);
> >        if (!fp->rate_table) {
> >                ret = -ENOMEM;
> >                goto err_free;
> >        }
> >
> > -       fp->nr_rates = 0;
> > -       fp->rate_min = fp->rate_max = 0;
> > -
> > -       for (i = 0; i < nr_rates; i++) {
> > -               int rate = combine_quad(&data[2 + 12 * i]);
> > -
> > -               fp->rate_table[fp->nr_rates] = rate;
> > -               if (!fp->rate_min || rate < fp->rate_min)
> > -                       fp->rate_min = rate;
> > -               if (!fp->rate_max || rate > fp->rate_max)
> > -                       fp->rate_max = rate;
> > -               fp->rates |= snd_pcm_rate_to_rate_bit(rate);
> > -               fp->nr_rates++;
> > -       }
> > +       /* Call the triplet parser again, but this time, fp->rate_table is
> > +        * allocated, so the rates will be stored */
> > +       parse_uac2_sample_rate_range(fp, nr_triplets, data);
> >
> >  err_free:
> >        kfree(data);
> > --
> > 1.7.1
> >
> >
