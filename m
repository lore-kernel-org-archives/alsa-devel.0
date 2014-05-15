From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC 03/11] sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD
 dependency
Date: Thu, 15 May 2014 16:23:47 +0200
Message-ID: <1400163836-9831-7-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux ARM <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/kirkwood/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 1f7c7ee3527a..6a0f79d2bb33 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
+	depends on ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
2.0.0.rc2
