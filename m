From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH V2] [SCSI] async: Fixup arguments of async_synchronize_full_domain in alsa-soc
Date: Tue, 17 Jul 2012 09:50:34 +0200
Message-ID: <201207170950.34351.marex@denx.de>
References: <1342477026-8376-1-git-send-email-marex@denx.de> <CAA9_cmcWaj_KWLz1m0sxCJNihVuGMQsbP53=1cPiEBBWiei7bg@mail.gmail.com> <1342510116.3039.5.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342510116.3039.5.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <jbottomley@parallels.com>
Cc: Dan Williams <dan.j.williams@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dear James Bottomley,

> On Mon, 2012-07-16 at 15:56 -0700, Dan Williams wrote:
> > On Mon, Jul 16, 2012 at 3:17 PM, Marek Vasut <marex@denx.de> wrote:
> > [..]
> > 
> > >  sound/soc/soc-dapm.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > V2: CC proper people, hopefully proper mailing list
> > > 
> > >     Adjust the patch subject with proper tags
> > > 
> > > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > > index eded657..e491eb0 100644
> > > --- a/sound/soc/soc-dapm.c
> > > +++ b/sound/soc/soc-dapm.c
> > > @@ -1572,7 +1572,7 @@ static int dapm_power_widgets(struct
> > > snd_soc_dapm_context *dapm, int event)
> > > 
> > >         struct snd_soc_dapm_context *d;
> > >         LIST_HEAD(up_list);
> > >         LIST_HEAD(down_list);
> > > 
> > > -       LIST_HEAD(async_domain);
> > > +       ASYNC_DOMAIN_EXCLUSIVE(async_domain);
> > > 
> > >         enum snd_soc_bias_level bias;
> > 
> > Thanks.  This was folded into the resend that was submitted week [1]
> 
> OK, I missed that with the cockup in the cover letters.

Well, the main point is it's now fixed. Thanks guys! :-)

> James

Best regards,
Marek Vasut
