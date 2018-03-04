From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 10/22] ASoC: Intel: bytcr_rt5651: Not being
	able to find the codec ACPI-dev is an error
Date: Sun,  4 Mar 2018 15:35:58 +0100
Message-ID: <20180304143610.21125-11-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8537326738C
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:27 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

If we cannot find the codec ACPI-dev, then the snd-soc-core will not be
able to find the codec either and snd_soc_register_card() will just keep
exiting with -EPROBE_DEFER, filling the log with errors each time the
probe gets retried.

Instead simply log an error from the machine driver and exit with -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-This is a new patch in v3 of this patch-set
---
 sound/soc/intel/boards/bytcr_rt5651.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8008a027cc93..6d8555e0359e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -537,12 +537,13 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-	if (i2c_name) {
-		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
-			"%s%s", "i2c-", i2c_name);
-
-		byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
+	if (!i2c_name) {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENODEV;
 	}
+	snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
+		"%s%s", "i2c-", i2c_name);
+	byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
-- 
2.14.3
