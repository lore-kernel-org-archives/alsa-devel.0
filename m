From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix wm8753 register cache size and
	initialization
Date: Fri,  3 Jul 2009 00:46:08 +0200
Message-ID: <1246574768-11447-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-077.synserver.de
	[212.40.180.77]) by alsa0.perex.cz (Postfix) with SMTP id 7F9672460B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 00:45:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The register cache size is of by one. There are 63 registers in use but the
register cache size has only space for 62.
Furthermore the codec's reg_cache_size is of by another one. Since the wm8753
register cache uses one-based indexing we have to add one to its size.

Register cache initialization only copied the first sizeof(void*) elements leaving the others
uninitialized. Fix it by using the size of the reg cache template.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8753.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index d28eeac..18a3ef9 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -79,7 +79,7 @@ static const u16 wm8753_reg[] = {
 	0x0097, 0x0097, 0x0000, 0x0004,
 	0x0000, 0x0083, 0x0024, 0x01ba,
 	0x0000, 0x0083, 0x0024, 0x01ba,
-	0x0000, 0x0000
+	0x0000, 0x0000, 0x0000
 };
 
 /* codec private data */
@@ -1660,11 +1660,11 @@ static int wm8753_register(struct wm8753_priv *wm8753)
 	codec->set_bias_level = wm8753_set_bias_level;
 	codec->dai = wm8753_dai;
 	codec->num_dai = 2;
-	codec->reg_cache_size = ARRAY_SIZE(wm8753->reg_cache);
+	codec->reg_cache_size = ARRAY_SIZE(wm8753->reg_cache) + 1;
 	codec->reg_cache = &wm8753->reg_cache;
 	codec->private_data = wm8753;
 
-	memcpy(codec->reg_cache, wm8753_reg, sizeof(codec->reg_cache));
+	memcpy(codec->reg_cache, wm8753_reg, sizeof(wm8753_reg));
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
 
 	ret = wm8753_reset(codec);
-- 
1.5.6.5
