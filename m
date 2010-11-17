From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH] ASoC: add codec support for mini6410 and real6410 boards
Date: Wed, 17 Nov 2010 22:21:31 +0200
Message-ID: <20101117202131.3540.44215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 sound/soc/s3c24xx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 8a6b53c..b1fcbd3 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -132,7 +132,7 @@ config SND_S3C24XX_SOC_RX1950_UDA1380
 
 config SND_SOC_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_MINI6410 || MACH_REAL6410)
 	select SND_SOC_WM9713
 	select SND_S3C_SOC_AC97
 	help
