From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: uda1380: Remove unused DAI ID defines
Date: Wed, 23 Nov 2016 10:30:10 +0100
Message-ID: <1479893411-32011-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A669266F37
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 10:30:21 +0100 (CET)
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

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. The last user of these defines was removed in commit
f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
remove the defines as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda1380.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index 942e392..69a326a 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -72,8 +72,4 @@
 #define R22_SKIP_DCFIL	0x0002
 #define R23_AGC_EN	0x0001
 
-#define UDA1380_DAI_DUPLEX	0 /* playback and capture on single DAI */
-#define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
-#define UDA1380_DAI_CAPTURE	2 /* capture DAI */
-
 #endif /* _UDA1380_H */
-- 
2.1.4
