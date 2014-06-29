From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 04/13] ASoC: kirkwood: Remove ARCH_KIRKWOOD and
	ARCH_DOVE dependency
Date: Sun, 29 Jun 2014 22:59:52 +0200
Message-ID: <1404075603-31838-6-git-send-email-andrew@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id A491D261622
 for <alsa-devel@alsa-project.org>; Sun, 29 Jun 2014 23:06:05 +0200 (CEST)
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, rmk+kernel@arm.linux.org.uk, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>
List-Id: alsa-devel@alsa-project.org

Both mach-kirkwood and mach-dove has been removed, now that Kirkwood
and Dove live in mach-mvebu. Remove these config symbols since
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/kirkwood/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 1f7c7ee3527a..952234de0cac 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
2.0.0
