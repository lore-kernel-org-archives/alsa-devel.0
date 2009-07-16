From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re:[PATCH 01/06] Fix compilation warning for sound/soc/codecs/wm8400.c
Date: Thu, 16 Jul 2009 18:40:01 +0530
Message-ID: <20090716130958.28045.71072.sendpatchset@subratamodak.linux.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756315AbZGPNKc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>, Jaroslav Kysela <erex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Subrata Modak <subrata@linux.vnet.ibm.com>, Balbir Singh <balbir@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hey,

>On Wed, 2009-07-15 at 10:13 +0530, Jaswinder Singh Rajput wrote:
>Hello Subrata,
> 
> On Wed, 2009-07-15 at 07:48 +0530, Subrata Modak wrote:
> > Following fix is inspired by David Howells fix few days back:
> > http://lkml.org/lkml/2009/7/9/109,
> > 
> 
> Please check further of this thread :
> 
> http://marc.info/?l=linux-kernel&m=124756210124518&w=2

Does the above really apply here ?

> 
> 
> > Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>,
> > ---
> > 
> > --- a/sound/soc/codecs/wm8400.c	2009-06-15 07:52:31.000000000 +0530
> > +++ b/sound/soc/codecs/wm8400.c	2009-07-15 05:35:00.000000000 +0530
> > @@ -1015,7 +1015,7 @@ static int wm8400_set_dai_pll(struct snd
> >  {
> >  	struct snd_soc_codec *codec = codec_dai->codec;
> >  	struct wm8400_priv *wm8400 = codec->private_data;
> > -	struct fll_factors factors;
> > +	struct fll_factors uninitialized_var(factors);
> >  	int ret;
> >  	u16 reg;
> >  
> > 
> 
> This kind of warnings born due to not handling the variables properly.
> Please try to understand the root cause of this warning, just shutting
> this warning is of no use.
> 
> Please revise your patches, If you face any problems let me know.
> 

How about the following brutal shutdown ?
---

--- a/sound/soc/codecs/wm8400.c	2009-07-16 16:21:37.000000000 +0530
+++ b/sound/soc/codecs/wm8400.c	2009-07-16 18:28:48.000000000 +0530
@@ -1015,7 +1015,7 @@ static int wm8400_set_dai_pll(struct snd
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8400_priv *wm8400 = codec->private_data;
-	struct fll_factors factors;
+	struct fll_factors factors = {};
 	int ret;
 	u16 reg;
 
---

As i found that:

1024 
1025         if (freq_out != 0) {
1026                 ret = fll_factors(wm8400, &factors, freq_in, freq_out);
1027                 if (ret != 0)
1028                         return ret;
1029         }
1030 

'factors' will get initialized here, as, 'freq_out' will probably never have
a '0' value. So, 'fll_factors()' will actually overwrite values in 'factors'
even after the initial brutal assignment:
	"struct fll_factors factors = {}"

Regards--
Subrata
