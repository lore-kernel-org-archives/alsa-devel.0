From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: wm8523: Fix array size for
	bclk_ratios
Date: Wed,  2 Aug 2017 17:55:13 +0800
Message-ID: <20170802095514.29138-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D797B26720B
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 11:55:31 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id p13so2034999pfd.4
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 02:55:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ARRAY_SIZE(bclk_ratios) returns 7 for current code, then it cannot catch
the error if "no matching BCLK/fs ratio". Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 6d0a272..b1e4ce7 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -116,7 +116,7 @@ static struct {
 static struct {
 	int value;
 	int ratio;
-} bclk_ratios[WM8523_NUM_RATES] = {
+} bclk_ratios[] = {
 	{ 2, 32 },
 	{ 3, 64 },
 	{ 4, 128 },
-- 
2.9.3
