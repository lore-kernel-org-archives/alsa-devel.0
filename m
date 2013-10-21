From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
Date: Mon, 21 Oct 2013 04:07:06 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866732@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017095619.GA27044@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20131017095619.GA27044@MrMyself>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Chen Guangyu-B42378 <B42378@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


> > When the CONFIG_REGULATOR is disabled there will be some warnings
> > printed out.
> 
> A little confused by the title. But after looking at the comments, is the
> patch just gonna add some debug info for the case when the
> CONFIG_REGULATOR's been un-selected?
> 
> Well first, I think at least the title should be more explicit.
> And second, the necessity of this patch might just a little...
> if CONFIG_REGULATOR is required to power it up, why not turn it on.
> 

Sorry, I will add some more detail and explicit description about this patch.

In VF610 board there has not Power Manager module. So if the CONFIG_REGULATOR is
turned on the SGTL5000 cannot be brought up correctly.
If it's turned off there will also some other errors for the SGTL5000 codec driver 
using the CONFIG_REGULATOR mirco not very correctly.

> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  sound/soc/codecs/sgtl5000.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > index 1f4093f..4e2e4c9 100644
> > --- a/sound/soc/codecs/sgtl5000.c
> > +++ b/sound/soc/codecs/sgtl5000.c
> > @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct
> snd_soc_codec *codec,
> >  				struct regulator_init_data *init_data,
> >  				int voltage)
> >  {
> > +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> 
> Why there's FSL_SGTL5000 here? Not supposed to be CONFIG_REGULATOR?
> 

I will enhance this patch later.
Using CONFIG_SND_SOC_FSL_SGTL5000 instead of CONFIG_REGULATOR here just for not affecting other boards.

> >  static int ldo_regulator_remove(struct snd_soc_codec *codec)  {
> >  	return 0;
> >  }
> > +
> 
> I don't think it's fair to add a meaningless line. It doesn't make any
> sense according to the title and comments.
> 

I will drop it later.

> >  #endif
> >
> >  /*
> > @@ -1137,6 +1142,7 @@ static int sgtl5000_resume(struct snd_soc_codec
> > *codec)  #define sgtl5000_resume  NULL
> >  #endif	/* CONFIG_SUSPEND */
> >
> > +#ifdef CONFIG_REGULATOR
> 
> The inline regulator-related functions are already have REGULATOR
> dependency.
> Is that necessary to put an additional one here?
> 

If not, the " warning: 'XXXXX' defined but not used [-Wunused-function] " log will print out.


This patch will be enhanced later.
