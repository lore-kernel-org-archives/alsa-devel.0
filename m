From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/3] ASoC: rt5660: Add a new ACPI match ID
Date: Thu,  6 Dec 2018 22:52:05 +0800
Message-ID: <20181206145207.4477-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 07793267C6F
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 15:52:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

The Realtek codec ALC3277 is 100% compatible with the codec RT5660
in I2S mode. And on the Dell IoT platform, the codec is ALC3277,
and the HID of the codec in the BIOS is 10EC3277, so adding this
ID to the ACPI match table.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/codecs/rt5660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 27f7445b2432..e74b2e8cd423 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1246,6 +1246,7 @@ MODULE_DEVICE_TABLE(of, rt5660_of_match);
 
 static const struct acpi_device_id rt5660_acpi_match[] = {
 	{ "10EC5660", 0 },
+	{ "10EC3277", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5660_acpi_match);
-- 
2.17.1
