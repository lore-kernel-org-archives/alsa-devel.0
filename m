From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoc: kirkwood: Use the Kirkwood audio driver in Dove
 boards
Date: Tue, 27 Aug 2013 20:27:11 +0200
Message-ID: <20130827202711.6230c38d@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch permits the generation of the Kirkwood audio driver which
may be used in the Dove boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/Kconfig                   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 9e1970c..78ed4a4 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
-	tristate "SoC Audio for the Marvell Kirkwood chip"
-	depends on ARCH_KIRKWOOD || COMPILE_TEST
+	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
