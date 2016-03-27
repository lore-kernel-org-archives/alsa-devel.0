From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8960: Provide a menu selection text
Date: Sun, 27 Mar 2016 19:06:14 -0300
Message-ID: <1459116374-13464-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 371B5261785
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 00:06:37 +0200 (CEST)
Received: by mail-qg0-f52.google.com with SMTP id j35so96581282qge.0
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 15:06:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Provide a menu selection text so that users can enable, disable or 
mark it as module in menuconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a..196101b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -909,7 +909,7 @@ config SND_SOC_WM8955
 	tristate
 
 config SND_SOC_WM8960
-	tristate
+	tristate "Wolfson Microelectronics WM8960 CODEC"
 
 config SND_SOC_WM8961
 	tristate
-- 
1.9.1
