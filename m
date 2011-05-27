From: Caleb Crome <caleb@crome.org>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Fri, 27 May 2011 14:36:58 -0700
Message-ID: <BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
	<20110527012756.GA26768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id B012C24466
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 23:37:02 +0200 (CEST)
Received: by pvf33 with SMTP id 33so978163pvf.38
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2011 14:36:59 -0700 (PDT)
In-Reply-To: <20110527012756.GA26768@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,
   Thanks, for the pointers.  I now have a gazillion controls in my
alsamixer :-)  The snd_soc_codec_conf works like a charm.

However, I'm still having problems getting the system set up with more than
2 channels.  the rx51 and speyside don't quite do the same thing as far as I
can tell:  the rx51 is close -- it very nearly brings up the 'b' codec in
the aic34, but I don't see how the TDM is set -- it appears to still be a
stereo configuration.

Do I need multiple snd_soc_dai_links when configuring?  In hw_params, I only
seem to get 1 codec dai_link, so I can't set the TDM slots there.

Or are the extra codecs in the daisy chain considered 'aux' devices?  I
guess I could set up the tdm slots in each of the snd_soc_aux_dev.init
functions.  But that callback init function has a snd_soc_dapm_context a
parameter, which doesn't seem to be the right place for setting tdm slots
and pin directions.

My 'machine_hw_params' function allows for 1 through 16 channels, and my
machine_startup function  calls snd_pcm_hw_contraint_minmax(runtime,
SNDRV_PCM_HW_PARAM_CHANNELS, 1, 16) to allow for 16 channels.   But still
the only way I can get more than 2 channels from any user program (using
jackd), is to change the tlv320aic3x.c driver to set channels_max to 16,
which I'm pretty sure is not right.

It seems like I might need to do something like this in the hw_params
function:

int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
for (codec_dai = 0; codec_dai < 8; codec_dai++) {
    snd_soc_dai_set_tdm_slot(codec_dai_list[codec_dai], 0x3<<codec_dai*2,
0x3<<codec_dai*2, 2, 16);
    snd_soc_dai_set_channel_map(codec_dai_list[codec_dai], 2,
&(channel_map[codec_dai*2]), 2, &(channel_map[codec_dai*2]));
}

but, I don't see any place where I have access to all 8 codec_dai's.

Any thoughts, suggestions?

Thanks again,
 -Caleb



On Thu, May 26, 2011 at 6:27 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, May 26, 2011 at 02:23:03PM -0700, Caleb Crome wrote:
>
> >    You previously indicated that I can instantiate multiple tlv320aic33
> > drivers.  Can you please give me a clue how to do that?  I've been
> staring
> > at this for days, and I still don't really get how it's supposed to be
> done.
>
> With things like this it's always useful to look for other examples of
> whatever it is you're doing - there's systems like speyside and rx51 in
> mainline.
>
>
> fails because there are already controls with those names, like "Right PGA
> > Mixer" etc.  The alsa layer doesn't seem to allow multiple registrations
> of
> > the same control.  How do I give each instantiation a unique identifier?
>
> Set up a snd_soc_codec_conf for each CODEC and assign a name_prefix to
> it.
>
> >  Since the tlv320aic33 has about 80 controls, I'm going to end up with
> over
> > 600 controls in alsamixer.
>
> Yes.
>
