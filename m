From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 2/3] MIPS: Ci20: Enable SND_JZ4740_SOC driver
Date: Wed,  6 Jun 2018 21:38:09 +0200
Message-ID: <20180606193811.16007-2-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the Ci20's defconfig to enable the JZ4780's SND driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index e1c14f6af824..0c08c7675b42 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -104,6 +104,10 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_JZ4740_SOC=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-- 
2.11.0
