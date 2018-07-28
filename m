From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] ASoC: wm8988: fix typo in rate constraints
Date: Sat, 28 Jul 2018 14:30:17 +0200
Message-ID: <20180728123017.GA28930@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id AB7A126775C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 14:30:22 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992066AbeG1MaVkFxPo (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Sat, 28 Jul 2018 14:30:21 +0200
Content-Disposition: inline
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Remove duplicated entry and add missing zero in rate constraints.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/wm8988.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 62200117444b..6e52c6a8bab3 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -522,7 +522,7 @@ static inline int get_coeff(int mclk, int rate)
 /* The set of rates we can generate from the above for each SYSCLK */
 
 static const unsigned int rates_12288[] = {
-	8000, 12000, 16000, 24000, 24000, 32000, 48000, 96000,
+	8000, 12000, 16000, 24000, 32000, 48000, 96000,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_12288 = {
@@ -540,7 +540,7 @@ static const struct snd_pcm_hw_constraint_list constraints_112896 = {
 };
 
 static const unsigned int rates_12[] = {
-	8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 41100, 48000,
 	48000, 88235, 96000,
 };
 
-- 
2.18.0
