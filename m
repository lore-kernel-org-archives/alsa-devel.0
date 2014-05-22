From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ASoC: alc5623: Depend on I2C.
Date: Thu, 22 May 2014 17:54:59 +0200
Message-ID: <1400774099-24708-1-git-send-email-andrew@lunn.ch>
References: <537c16a2.M0hsJdtS6xDtvRgJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id EBD6D265630
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 18:18:00 +0200 (CEST)
In-Reply-To: <537c16a2.M0hsJdtS6xDtvRgJ%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@linaro.org
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, kbuild-all@01.org, jim.epost@gmail.com
List-Id: alsa-devel@alsa-project.org

This is an i2c driver, so make the Kconfig entry depend on I2C.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c59943a19f94..397b66c2b999 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -274,6 +274,7 @@ config SND_SOC_AK5386
 
 config SND_SOC_ALC5623
        tristate "Realtek ALC5623 CODEC"
+       depends on I2C
 
 config SND_SOC_ALC5632
 	tristate
-- 
2.0.0.rc2
