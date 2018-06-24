From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ASoC: Intel: bytcr_rt5651: Add support for
	external amplifier enable GPIO
Date: Sun, 24 Jun 2018 15:02:47 +0200
Message-ID: <20180624130247.18150-2-hdegoede@redhat.com>
References: <20180624130247.18150-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BFDF2675FC
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 15:02:54 +0200 (CEST)
In-Reply-To: <20180624130247.18150-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The rt5651 does not have a built-in speaker amplifier, so it is often
used together with an external amplifier. On Cherry Trail boards this
external amplifier's enable pin is driven through a GPIO, which is
given as the first GPIO in the ACPI resources of the codec fwnode.

This commit adds a mapping from the first GPIO to "ext-amp-enable-gpios"
to the codec device, so that the codec driver can find and contorl the
GPIO.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 987720e203f9..925dfb46b4fe 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -26,8 +26,10 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/gpio/machine.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -414,6 +416,18 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 	{}
 };
 
+static const struct x86_cpu_id cherrytrail_cpu_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT }, /* Braswell, CHT */
+	{}
+};
+
+static const struct acpi_gpio_params ext_amp_enable_gpios = { 0, 0, false };
+
+static const struct acpi_gpio_mapping byt_rt5651_gpios[] = {
+	{ "ext-amp-enable-gpios", &ext_amp_enable_gpios, 1 },
+	{ },
+};
+
 /*
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
@@ -441,8 +455,15 @@ static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
 
 	ret = device_add_properties(i2c_dev, props);
-	put_device(i2c_dev);
+	if (ret)
+		goto out;
 
+	/* Cherry Trail devices use an external amplifier enable gpio */
+	if (x86_match_cpu(cherrytrail_cpu_ids))
+		ret = devm_acpi_dev_add_driver_gpios(i2c_dev, byt_rt5651_gpios);
+
+	put_device(i2c_dev);
+out:
 	return ret;
 }
 
-- 
2.17.1
