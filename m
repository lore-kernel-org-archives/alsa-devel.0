From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mx27vis-aic32x4: Make sure we are
	running on the correct machine
Date: Sun, 11 Mar 2012 11:53:54 -0300
Message-ID: <1331477634-18616-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9237A2435F
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 15:54:05 +0100 (CET)
Received: by yenl1 with SMTP id l1so1944339yen.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 07:54:04 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, javier.martin@vista-silicon.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Only register mx27vis-aic32x4 if we are running on a imx27_visstrim_m10.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/imx/mx27vis-aic32x4.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 976f857..c982bc8 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -194,6 +194,9 @@ static int __init mx27vis_aic32x4_init(void)
 {
 	int ret;
 
+	if (!machine_is_imx27_visstrim_m10())
+		return 0;
+
 	mx27vis_aic32x4_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!mx27vis_aic32x4_snd_device)
 		return -ENOMEM;
-- 
1.7.1
