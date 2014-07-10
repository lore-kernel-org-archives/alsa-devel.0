From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 04/12] ASoC: kirkwood: Remove ARCH_KIRKWOOD
	dependency
Date: Thu, 10 Jul 2014 23:36:24 +0200
Message-ID: <1405028192-9623-5-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 78611264F10
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 23:42:32 +0200 (CEST)
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mark Brown <broonie@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

mach-kirkwood has been removed, now that kirkwood lives in
mach-mvebu. Remove ARCH_KIRKWOOD since ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/kirkwood/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 1f7c7ee3527a..132bb83f8e99 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
+	depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
2.0.1
