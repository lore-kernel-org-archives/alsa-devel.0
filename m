From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 1/4] ASoC: Add SOC_DOUBLE_R_EXT
Date: Thu, 24 Sep 2015 18:19:49 +0100
Message-ID: <73e9957cca4f29bd1b9881c4518132e47b2f00b4.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org

_EXT version of SOC_DOUBLE_R required to allow for custom handlers.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/sound/soc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..2d79cb5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -217,6 +217,13 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = \
 		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert, 0) }
+#define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
+	 xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
--
1.9.3
