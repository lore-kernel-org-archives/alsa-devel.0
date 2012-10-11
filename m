From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 2/3] ASoC: sam9g20: using platform device for audio part
Date: Thu, 11 Oct 2012 10:38:16 +0800
Message-ID: <1349923097-14115-3-git-send-email-voice.shen@atmel.com>
References: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    9 +++++++++
 arch/arm/mach-at91/board-sam9g20ek.c     |   17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index a76b868..0f24cfb 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -768,6 +768,14 @@ static inline void configure_ssc_pins(unsigned pins)
 		at91_set_A_periph(AT91_PIN_PB21, 1);
 }
 
+static struct platform_device at91sam9260_ssc_dai_device = {
+	.name	= "atmel-ssc-dai",
+	.id	= 0,
+	.dev	= {
+		.parent	= &(at91sam9260_ssc_device.dev),
+	},
+};
+
 /*
  * SSC controllers are accessed through library code, instead of any
  * kind of all-singing/all-dancing driver.  For example one could be
@@ -792,6 +800,7 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins)
 	}
 
 	platform_device_register(pdev);
+	platform_device_register(&at91sam9260_ssc_dai_device);
 }
 
 #else
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 3ab2b86..5b6a6f9 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -353,6 +353,22 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
         },
 };
 
+static struct platform_device sam9g20ek_pcm_device = {
+	.name	= "atmel-pcm-audio",
+	.id = -1,
+};
+
+static struct platform_device sam9g20ek_audio_device = {
+	.name   = "at91sam9g20ek-audio",
+	.id     = -1,
+};
+
+static void __init ek_add_device_audio(void)
+{
+	platform_device_register(&sam9g20ek_pcm_device);
+	platform_device_register(&sam9g20ek_audio_device);
+}
+
 
 static void __init ek_board_init(void)
 {
@@ -394,6 +410,7 @@ static void __init ek_board_init(void)
 	at91_set_B_periph(AT91_PIN_PC1, 0);
 	/* SSC (for WM8731) */
 	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
+	ek_add_device_audio();
 }
 
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
-- 
1.7.9.5

