From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: bfin-ac97: Fix prototype error following
	AC'97 refactoring
Date: Mon, 29 Jul 2013 08:53:37 +0100
Message-ID: <1375084417-29437-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 78128261A31
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 09:54:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of the multiplatform refactoring for AC'97 the AC'97 bus ops were
staticised meaning that the prototype (which was never needed) conflicts
with the declaration causing build failures.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/blackfin/bf5xx-ac97.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
index 15c635e..0c3e22d 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -9,7 +9,6 @@
 #ifndef _BF5XX_AC97_H
 #define _BF5XX_AC97_H
 
-extern struct snd_ac97_bus_ops bf5xx_ac97_ops;
 extern struct snd_ac97 *ac97;
 /* Frame format in memory, only support stereo currently */
 struct ac97_frame {
-- 
1.8.3.2
