From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: wm8523: Constfiy lrclk_ratios and
	bclk_ratios
Date: Wed,  2 Aug 2017 17:55:14 +0800
Message-ID: <20170802095514.29138-2-axel.lin@ingics.com>
References: <20170802095514.29138-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E89F7267281
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 11:55:39 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 83so5940565pgb.4
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 02:55:39 -0700 (PDT)
In-Reply-To: <20170802095514.29138-1-axel.lin@ingics.com>
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

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index b1e4ce7..c7c33e9 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -100,7 +100,7 @@ static const struct snd_soc_dapm_route wm8523_dapm_routes[] = {
 	{ "LINEVOUTR", NULL, "DAC" },
 };
 
-static struct {
+static const struct {
 	int value;
 	int ratio;
 } lrclk_ratios[WM8523_NUM_RATES] = {
@@ -113,7 +113,7 @@ static struct {
 	{ 7, 1152 },
 };
 
-static struct {
+static const struct {
 	int value;
 	int ratio;
 } bclk_ratios[] = {
-- 
2.9.3
