From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V4 3/3] ALSA: deprecate MIPS AU1X00 AC97 driver
Date: Sun, 24 Jul 2011 12:11:51 +0200
Message-ID: <1311502311-16916-4-git-send-email-manuel.lauss@googlemail.com>
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lrg@ti.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

Now that an ASoC variant is available, tell users that this
driver is now living on borrowed time...

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V4: no changes.
V3: mark driver DEPRECATED instead of removing it outright.

 sound/mips/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index a9823fa..77dd0a1 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -23,12 +23,15 @@ config SND_SGI_HAL2
 
 
 config SND_AU1X00
-	tristate "Au1x00 AC97 Port Driver"
+	tristate "Au1x00 AC97 Port Driver (DEPRECATED)"
 	depends on SOC_AU1000 || SOC_AU1100 || SOC_AU1500
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
 	  ALSA Sound driver for the Au1x00's AC97 port.
 
+	  Newer drivers for ASoC are available, please do not use
+	  this driver as it will be removed in the future.
+
 endif	# SND_MIPS
 
-- 
1.7.6

