From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/10] ASoC: Intel: bytcr_rt5640: Add
	default jack-detect settings
Date: Fri, 11 May 2018 15:29:24 +0200
Message-ID: <20180511132928.7669-7-hdegoede@redhat.com>
References: <20180511132928.7669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D9FDD2677CF
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 15:29:40 +0200 (CEST)
In-Reply-To: <20180511132928.7669-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Out of the 11 BYTCR devices which I have access to for testing, 6 use
JD1IN4P for jack-detect, 2 use JD1IN4P non-inverted and the other 3 use
JD2IN4N, the ones not using JD1IN4P are all also special in other ways and
need a DMI quirk regardless.

All 5 BYT (non CR) devices which I have access to use JD2IN4N.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index cc111bf30935..77a059553596 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -84,6 +84,9 @@ enum {
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
+	 BYT_RT5640_JD_SRC_JD1_IN4P |			\
+	 BYT_RT5640_OVCD_TH_2000UA |			\
+	 BYT_RT5640_OVCD_SF_0P75 |			\
 	 BYT_RT5640_DIFF_MIC)
 
 /* in-diff or dmic-pin + jdsrc + ovcd-th + -sf + jd-inv + terminating entry */
@@ -981,7 +984,10 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		/* change defaults for Baytrail-CR capture */
 		byt_rt5640_quirk |= BYTCR_INPUT_DEFAULTS;
 	} else {
-		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP |
+				    BYT_RT5640_JD_SRC_JD2_IN4N |
+				    BYT_RT5640_OVCD_TH_2000UA |
+				    BYT_RT5640_OVCD_SF_0P75;
 	}
 
 	/* check quirks before creating card */
-- 
2.17.0
