From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] ASoC: multi-component - Enable WM8993/4
 common code to support WM8994
Date: Tue, 20 Jul 2010 14:28:33 +0900
Message-ID: <4C453401.1060401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D6CD103881
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 07:28:37 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5U00DX8CJM9C00@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 20 Jul 2010 14:28:34 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5U00MB4CJMMY@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 20 Jul 2010 14:28:34 +0900 (KST)
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch enable WM8993/4 common code which is used in WM8994 driver.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/codecs/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ea1f5ed..17e28eb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -85,8 +85,8 @@ config SND_SOC_ALL_CODECS
 
 config SND_SOC_WM_HUBS
 	tristate
-	default y if SND_SOC_WM8993=y
-	default m if SND_SOC_WM8993=m
+	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
+	default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m 
 
 config SND_SOC_AC97_CODEC
 	tristate
-- 
1.6.3.3
