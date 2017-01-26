From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/17] ASoC: Intel: cht_bsw_rt5645: harden ACPI
	device detection
Date: Thu, 26 Jan 2017 14:09:41 -0600
Message-ID: <1485461385-14544-14-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D40372677A5
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:28 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fix classic issue of having multiple codecs listed in DSDT
but a single one actually enabled. The previous code did
not handle such errors and could also lead to uninitalized
configurations

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index d208a48..ca1222c 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -408,22 +408,32 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
+	bool found = false;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
 		return -ENOMEM;
 
+	mach = (&pdev->dev)->platform_data;
+
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (acpi_dev_found(snd_soc_cards[i].codec_id)) {
+		if (acpi_dev_found(snd_soc_cards[i].codec_id) &&
+			(!strncmp(snd_soc_cards[i].codec_id, mach->id, 8))) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card = snd_soc_cards[i].soc_card;
 			drv->acpi_card = &snd_soc_cards[i];
+			found = true;
 			break;
 		}
 	}
+
+	if (!found) {
+		dev_err(&pdev->dev, "No matching HID found in supported list\n");
+		return -ENODEV;
+	}
+
 	card->dev = &pdev->dev;
-	mach = card->dev->platform_data;
 	sprintf(drv->codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 
 	/* set correct codec name */
-- 
2.7.4
