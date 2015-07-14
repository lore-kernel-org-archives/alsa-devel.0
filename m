From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH] cht_bsw_rt5645: Fix Kernel crash with strcpy
Date: Tue, 14 Jul 2015 22:06:51 +0530
Message-ID: <1436891811-24759-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F7826530C
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:36:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, yang.a.fang@intel.com
Cc: vinod.koul@intel.com, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Kernel crash is observed when strcpy is used with  const char*.
The crash is reported only if driver is loaded as a module or the probe
is called in the late stage of  Kernel boot (EPROBE_DEFER). This is because
Kernel enables read only protection near the end. Issue is addressed
by replacing the strcpy with pointer assignment

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index bdcaf46..3665d6c 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -367,7 +367,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 	/* set correct codec name */
-	strcpy((char *)card->dai_link[2].codec_name, codec_name);
+	card->dai_link[2].codec_name = codec_name;
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
-- 
1.7.9.5
