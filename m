From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2] ASoC: cht_bsw_rt5645: Fix writing to string
	literal
Date: Tue, 23 Feb 2016 09:50:20 +0100
Message-ID: <1456217420-9327-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3698F2605B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 09:50:28 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id a4so198309702wme.1
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 00:50:28 -0800 (PST)
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
 sound/soc/intel/boards/cht_bsw_rt5645.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 2d3afdd..a7b96a9 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -367,8 +367,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 	card->dev = &pdev->dev;
 	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
+
 	/* set correct codec name */
-	strcpy((char *)card->dai_link[2].codec_name, codec_name);
+	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++)
+		if (!strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00"))
+			card->dai_link[i].codec_name = kstrdup(codec_name, GFP_KERNEL);
+
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
-- 
2.5.0
