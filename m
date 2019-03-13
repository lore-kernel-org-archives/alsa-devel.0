From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: src: fix compiler warnings" to
	the asoc tree
Date: Wed, 13 Mar 2019 15:38:57 +0000 (GMT)
Message-ID: <20190313153857.32FED1128B97@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5A2CF8974E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 16:38:58 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: src: fix compiler warnings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 825b22e5961a47ba7387d3ee6729956d6bb3b495 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Thu, 7 Mar 2019 11:34:53 +0900
Subject: [PATCH] ASoC: rsnd: src: fix compiler warnings

compiler complains about following declarations

sound/soc/sh/rcar/src.c:174:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsdsr_table_pattern1[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:183:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsdsr_table_pattern2[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:192:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 bsisr_table[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:201:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan288888[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:210:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan244888[] = {
 ^~~~~
sound/soc/sh/rcar/src.c:219:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
 const static u32 chan222222[] = {
 ^~~~~

This patch moves the 'static' keyword to the front of the
declaration to fix the compiler warnings

Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index db81e066b92e..79716725f67b 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -135,7 +135,7 @@ unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
 	return rate;
 }
 
-const static u32 bsdsr_table_pattern1[] = {
+static const u32 bsdsr_table_pattern1[] = {
 	0x01800000, /* 6 - 1/6 */
 	0x01000000, /* 6 - 1/4 */
 	0x00c00000, /* 6 - 1/3 */
@@ -144,7 +144,7 @@ const static u32 bsdsr_table_pattern1[] = {
 	0x00400000, /* 6 - 1   */
 };
 
-const static u32 bsdsr_table_pattern2[] = {
+static const u32 bsdsr_table_pattern2[] = {
 	0x02400000, /* 6 - 1/6 */
 	0x01800000, /* 6 - 1/4 */
 	0x01200000, /* 6 - 1/3 */
@@ -153,7 +153,7 @@ const static u32 bsdsr_table_pattern2[] = {
 	0x00600000, /* 6 - 1   */
 };
 
-const static u32 bsisr_table[] = {
+static const u32 bsisr_table[] = {
 	0x00100060, /* 6 - 1/6 */
 	0x00100040, /* 6 - 1/4 */
 	0x00100030, /* 6 - 1/3 */
@@ -162,7 +162,7 @@ const static u32 bsisr_table[] = {
 	0x00100020, /* 6 - 1   */
 };
 
-const static u32 chan288888[] = {
+static const u32 chan288888[] = {
 	0x00000006, /* 1 to 2 */
 	0x000001fe, /* 1 to 8 */
 	0x000001fe, /* 1 to 8 */
@@ -171,7 +171,7 @@ const static u32 chan288888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan244888[] = {
+static const u32 chan244888[] = {
 	0x00000006, /* 1 to 2 */
 	0x0000001e, /* 1 to 4 */
 	0x0000001e, /* 1 to 4 */
@@ -180,7 +180,7 @@ const static u32 chan244888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan222222[] = {
+static const u32 chan222222[] = {
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
-- 
2.20.1
