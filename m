From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/7] ASoC: rt5651: Add ACPI ID 10EC5640
Date: Sun, 30 Dec 2018 00:00:20 +0100
Message-ID: <20181229230025.21949-3-hdegoede@redhat.com>
References: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id D66EB267A66
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:34 +0100 (CET)
In-Reply-To: <20181229230025.21949-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some BYT platforms have a RT5651 codec while using an ACPI node with
a HID of 10EC5640 to describe the coded. Add the 10EC5640 HID to the
acpi_device_id list, so that the rt5651 will bind to the codec on these
devices.

Like the rt5645 and rt5670 drivers which also have the 10EC5640 ACPI HID
in their acpi_device_id list for similar reasons, the rt5651 driver checks
the codecs device-id register so that it will only bind if the codec
actually is a rt5651 and it will ignore actual rt5640 codecs.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index b7ba64350a07..95183a7de305 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2138,6 +2138,7 @@ MODULE_DEVICE_TABLE(of, rt5651_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5651_acpi_match[] = {
 	{ "10EC5651", 0 },
+	{ "10EC5640", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5651_acpi_match);
-- 
2.20.1
