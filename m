From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: boards: use strcmp with
 constant literals
Date: Mon, 9 Oct 2017 15:04:37 +0530
Message-ID: <20171009093437.GW30097@localhost>
References: <20171005185243.4174-1-pierre-louis.bossart@linux.intel.com>
 <20171005185243.4174-7-pierre-louis.bossart@linux.intel.com>
 <s5hfuaw7j0a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6EC2671A9
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 11:30:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfuaw7j0a.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2017 at 10:55:33AM +0200, Takashi Iwai wrote:
> On Thu, 05 Oct 2017 20:52:43 +0200,
> Pierre-Louis Bossart wrote:
> > 
> > we used strncmp in all audio machine drivers, this is not needed
> > when comparing against constant literals.
> > General replace of strncmp(a, b, strlen(b)) to strcmp(a,b)
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  sound/soc/intel/boards/bxt_da7219_max98357a.c   | 3 +--
> >  sound/soc/intel/boards/bytcht_es8316.c          | 3 +--
> >  sound/soc/intel/boards/bytcr_rt5640.c           | 6 ++----
> >  sound/soc/intel/boards/bytcr_rt5651.c           | 3 +--
> >  sound/soc/intel/boards/cht_bsw_max98090_ti.c    | 3 +--
> >  sound/soc/intel/boards/cht_bsw_rt5645.c         | 6 ++----
> >  sound/soc/intel/boards/cht_bsw_rt5672.c         | 3 +--
> >  sound/soc/intel/boards/skl_nau88l25_max98357a.c | 3 +--
> >  sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 3 +--
> >  9 files changed, 11 insertions(+), 22 deletions(-)
> 
> While we're at it: since all these do mostly same: wouldn't it make
> more sense to create a helper to scan over the rtd_list?
> 
> static inline snd_soc_intel_get_codec_dai(struct snd_soc_card *card,
> 					  const char *dai_name)
> {
> 	struct snd_soc_pcm_runtime *rtd;
> 
> 	list_for_each_entry(rtd, &card->rtd_list, list) {
> 		if (!strcmp(rtd->codec_dai->name, dai_name))
> 			return rtd->codec_dai;
> 	}
> 	
> 	return NULL;
> }
> 
> Some drivers require to check two names, but it can call this function
> twice.

yeah this was in my todo :( would be gald if its done now :)

> > diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > index ce35ec7884d1..dc47c3f0b621 100644
> > --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > @@ -61,8 +61,7 @@ static inline struct snd_soc_dai *bxt_get_codec_dai(struct snd_soc_card *card)
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> >  
> > -		if (!strncmp(rtd->codec_dai->name, BXT_DIALOG_CODEC_DAI,
> > -			     strlen(BXT_DIALOG_CODEC_DAI)))
> > +		if (!strcmp(rtd->codec_dai->name, BXT_DIALOG_CODEC_DAI))
> >  			return rtd->codec_dai;
> >  	}
> >  
> > diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> > index 52635462dac6..9b42dc924cd3 100644
> > --- a/sound/soc/intel/boards/bytcht_es8316.c
> > +++ b/sound/soc/intel/boards/bytcht_es8316.c
> > @@ -44,8 +44,7 @@ static inline struct snd_soc_dai *get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, CODEC_DAI1,
> > -			     strlen(CODEC_DAI1)))
> > +		if (!strcmp(rtd->codec_dai->name, CODEC_DAI1))
> >  			return rtd->codec_dai;
> >  	}
> >  	return NULL;
> > diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> > index ffb3ca971df4..24c7f861f1e1 100644
> > --- a/sound/soc/intel/boards/bytcr_rt5640.c
> > +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> > @@ -150,11 +150,9 @@ static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI1,
> > -			     strlen(BYT_CODEC_DAI1)))
> > +		if (!strcmp(rtd->codec_dai->name, BYT_CODEC_DAI1))
> >  			return rtd->codec_dai;
> > -		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI2,
> > -				strlen(BYT_CODEC_DAI2)))
> > +		if (!strcmp(rtd->codec_dai->name, BYT_CODEC_DAI2))
> >  			return rtd->codec_dai;
> >  
> >  	}
> > diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> > index 1b97aa735747..0443d2e7e8a1 100644
> > --- a/sound/soc/intel/boards/bytcr_rt5651.c
> > +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> > @@ -73,8 +73,7 @@ static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI1,
> > -			     strlen(BYT_CODEC_DAI1)))
> > +		if (!strcmp(rtd->codec_dai->name, BYT_CODEC_DAI1))
> >  			return rtd->codec_dai;
> >  	}
> >  	return NULL;
> > diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> > index 74c047a4b05c..98d58d389b04 100644
> > --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> > +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> > @@ -46,8 +46,7 @@ static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> > -			     strlen(CHT_CODEC_DAI)))
> > +		if (!strcmp(rtd->codec_dai->name, CHT_CODEC_DAI))
> >  			return rtd->codec_dai;
> >  	}
> >  	return NULL;
> > diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
> > index 6ccb599c1082..e9a3121ecad7 100644
> > --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
> > +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
> > @@ -75,11 +75,9 @@ static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI1,
> > -			     strlen(CHT_CODEC_DAI1)))
> > +		if (!strcmp(rtd->codec_dai->name, CHT_CODEC_DAI1))
> >  			return rtd->codec_dai;
> > -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI2,
> > -			     strlen(CHT_CODEC_DAI2)))
> > +		if (!strcmp(rtd->codec_dai->name, CHT_CODEC_DAI2))
> >  			return rtd->codec_dai;
> >  	}
> >  	return NULL;
> > diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
> > index f799b76fdedf..78798c600c16 100644
> > --- a/sound/soc/intel/boards/cht_bsw_rt5672.c
> > +++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
> > @@ -55,8 +55,7 @@ static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> >  	struct snd_soc_pcm_runtime *rtd;
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> > -			     strlen(CHT_CODEC_DAI)))
> > +		if (!strcmp(rtd->codec_dai->name, CHT_CODEC_DAI))
> >  			return rtd->codec_dai;
> >  	}
> >  	return NULL;
> > diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> > index 5ed0aa27b467..95c017f7315e 100644
> > --- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> > +++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
> > @@ -60,8 +60,7 @@ static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> >  
> > -		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
> > -			     strlen(SKL_NUVOTON_CODEC_DAI)))
> > +		if (!strcmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI))
> >  			return rtd->codec_dai;
> >  	}
> >  
> > diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > index 01b8b140bb08..57f1e5b8408f 100644
> > --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > @@ -63,8 +63,7 @@ static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> >  
> > -		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
> > -			     strlen(SKL_NUVOTON_CODEC_DAI)))
> > +		if (!strcmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI))
> >  			return rtd->codec_dai;
> >  	}
> >  
> > -- 
> > 2.11.0
> > 

-- 
~Vinod
