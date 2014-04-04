From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/6] ASoC: hdmi: Include of.h
Date: Fri,  4 Apr 2014 11:29:09 +0530
Message-ID: <1396591153-10924-2-git-send-email-sachin.kamat@linaro.org>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id BAD78265733
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:44 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id x10so2854227pdj.23
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:43 -0700 (PDT)
In-Reply-To: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

of_match_ptr is defined in of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/hdmi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 9cb1c7d..1087fd5 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -20,6 +20,7 @@
  */
 #include <linux/module.h>
 #include <sound/soc.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #define DRV_NAME "hdmi-audio-codec"
-- 
1.7.9.5
