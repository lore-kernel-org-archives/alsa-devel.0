From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: bf5xx-ac97: Remove unused extern
	declaration
Date: Tue, 30 Jul 2013 13:34:10 +0200
Message-ID: <1375184050-21514-2-git-send-email-lars@metafoo.de>
References: <1375184050-21514-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-230.synserver.de (smtp-out-231.synserver.de
 [212.40.185.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 55967260729
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:52:54 +0200 (CEST)
In-Reply-To: <1375184050-21514-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The blackfin ac97 driver never defines nor uses a global ac97 struct. So remove
the extern declaration for it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ac97.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
index 0c3e22d..a680fdc 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -9,7 +9,6 @@
 #ifndef _BF5XX_AC97_H
 #define _BF5XX_AC97_H
 
-extern struct snd_ac97 *ac97;
 /* Frame format in memory, only support stereo currently */
 struct ac97_frame {
 	u16 ac97_tag;		/* slot 0 */
-- 
1.8.0
