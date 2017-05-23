From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ASoC: cht_bsw_max98090_ti: Remove unused
 function cht_get_codec_dai()
Date: Tue, 23 May 2017 12:32:39 -0700
Message-ID: <20170523193239.GP141096@google.com>
References: <20170523190509.59212-1-mka@chromium.org>
 <6f941eb4-04b9-89ea-a791-c65c939581cf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id CC0E0267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 21:32:41 +0200 (CEST)
Received: by mail-pf0-f177.google.com with SMTP id n23so123801047pfb.2
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 12:32:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6f941eb4-04b9-89ea-a791-c65c939581cf@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, Yang A Fang <yang.a.fang@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

El Tue, May 23, 2017 at 12:25:17PM -0700 Pierre-Louis Bossart ha dit:

> On 5/23/17 12:05 PM, Matthias Kaehlcke wrote:
> >Looks like the function has never been used since it was added by commit
> >17119a465706 ("ASoC: Intel: Add Cherrytrail & Braswell machine driver
> >cht_bsw_max98090_ti"). Removing it fixes the following warning when
> >building with clang:
> >
> >sound/soc/intel/boards/cht_bsw_max98090_ti.c:42:35: error: unused
> >    function 'cht_get_codec_dai' [-Werror,-Wunused-function]
> 
> Fine but it'll have to be re-added when I finally find the time to
> support Baytrail with this driver.

If you have plans to add the code in a nearish future it is probably
not worth to do the removal, unless the maintainers think otherwise.

> >Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >---
> > sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ------------
> > 1 file changed, 12 deletions(-)
> >
> >diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> >index 742bc0d4e681..20755ecc7f9e 100644
> >--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> >+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> >@@ -39,18 +39,6 @@ struct cht_mc_private {
> > 	bool ts3a227e_present;
> > };
> >
> >-static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> >-{
> >-	struct snd_soc_pcm_runtime *rtd;
> >-
> >-	list_for_each_entry(rtd, &card->rtd_list, list) {
> >-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> >-			     strlen(CHT_CODEC_DAI)))
> >-			return rtd->codec_dai;
> >-	}
> >-	return NULL;
> >-}
> >-
> > static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
> > 	SND_SOC_DAPM_HP("Headphone", NULL),
> > 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> >
> 
