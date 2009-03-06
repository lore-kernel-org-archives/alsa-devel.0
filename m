From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 1/1] ALSA: ASoC: Davinci: Fix incorrect machine
	type for SFFSDR board
Date: Fri,  6 Mar 2009 15:56:53 -0500
Message-ID: <1236373013-31366-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id E58B8243CD
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 21:56:57 +0100 (CET)
Received: from localhost.localdomain (mail.lyrtech.com [204.101.172.90])
	by server.hugovil.com (8.13.6/8.13.6) with ESMTP id n26KutHh028654
	for <alsa-devel@alsa-project.org>; Fri, 6 Mar 2009 15:56:56 -0500
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
---
 sound/soc/davinci/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 7d3a85d..411a710 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -21,7 +21,7 @@ config SND_DAVINCI_SOC_EVM
 
 config SND_DAVINCI_SOC_SFFSDR
 	tristate "SoC Audio support for SFFSDR"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
+	depends on SND_DAVINCI_SOC && MACH_SFFSDR
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_PCM3008
 	select SFFSDR_FPGA
-- 
1.5.4.5
