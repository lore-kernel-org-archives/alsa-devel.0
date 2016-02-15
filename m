From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] SoC: cht_bsw_rt5645: Fix writing to string
	literal
Date: Mon, 15 Feb 2016 22:36:29 +0100
Message-ID: <1455572189-11724-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FEC7260695
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 22:36:45 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id c200so132206306wme.0
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:36:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, vinod.koul@intel.com, yang.a.fang@intel.com, linux@endlessm.com, alsa-devel@alsa-project.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

We cannot use strcpy() to write to a const char * location. This is
causing a 'BUG: unable to handle kernel paging request' error at boot
when using the cht-bsw-rt5645 driver.

With this patch we also fix a wrong indexing in the driver where the
codec_name of the wrong dai_link is being overwritten.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/atom/sst-atom-controls.h | 1 +
 sound/soc/intel/boards/cht_bsw_rt5645.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index e011311..6f88d1c 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -30,6 +30,7 @@ enum {
 	MERR_DPCM_AUDIO = 0,
 	MERR_DPCM_DEEP_BUFFER,
 	MERR_DPCM_COMPR,
+	MERR_DPCM_BE,
 };
 
 /* define a bit for each mixer input */
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index e6cf800..89b4c032 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -282,7 +282,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	},
 	/* CODEC<->CODEC link */
 	/* back ends */
-	{
+	[MERR_DPCM_BE] = {
 		.name = "SSP2-Codec",
 		.be_id = 1,
 		.cpu_dai_name = "ssp2-port",
@@ -357,7 +357,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 	/* set correct codec name */
-	strcpy((char *)card->dai_link[2].codec_name, codec_name);
+	card->dai_link[MERR_DPCM_BE].codec_name = kstrdup(codec_name, GFP_KERNEL);
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
-- 
1.9.1
