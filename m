From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Add power down of widget powered up for
	suspend
Date: Mon, 23 Nov 2009 14:45:16 +0900
Message-ID: <4B0A216C.1030807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id EBC6D24450
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 06:45:26 +0100 (CET)
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KTJ008PVRZH4X@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 23 Nov 2009 14:45:17 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KTJ0098XRZGM7@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 23 Nov 2009 14:45:16 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

If the widget was powered up when the device enters to the suspend, it
remains on because the power of the widget doesn't change, but we need
to power down the widget on suspend.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/soc-dapm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d2af872..099d3b6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -978,8 +978,11 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 
 			power = w->power_check(w);
-			if (power)
+			if (power) {
 				sys_power = 1;
+				if (event == SND_SOC_DAPM_STREAM_SUSPEND)
+					power = 0;
+			}
 
 			if (w->power == power)
 				continue;
-- 
1.6.3.3
