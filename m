From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: bells: Select WM1250-EV1 Springbank
	audio I/O module
Date: Fri,  2 Nov 2012 10:42:02 +0000
Message-ID: <1351852922-3806-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1351852922-3806-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 167C3264FFA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 11:43:52 +0100 (CET)
In-Reply-To: <1351852922-3806-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure we select the WM1250-EV1 as the current software system
configuration demands it.

Change-Id: Ib75cfb4e98d74714e5f9acb9bfb76f24d802f755
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index fa166bd..3c7c3a5 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -208,6 +208,7 @@ config SND_SOC_BELLS
 	select SND_SOC_WM5110
 	select SND_SOC_WM9081
 	select SND_SOC_WM0010
+	select SND_SOC_WM1250_EV1
 
 config SND_SOC_LOWLAND
 	tristate "Audio support for Wolfson Lowland"
-- 
1.8.0
