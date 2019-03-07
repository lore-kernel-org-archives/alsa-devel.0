From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v1 2/2] ASoC: rsnd: src: fix compiler warnings
Date: Thu, 7 Mar 2019 11:34:53 +0900
Message-ID: <20190307023453.25017-3-jiada_wang@mentor.com>
References: <20190307023453.25017-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307023453.25017-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/sh/rcar/src.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 45096a66c074..585ffba0244b 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -134,7 +134,7 @@ unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
 	return rate;
 }
 
-const static u32 bsdsr_table_pattern1[] = {
+static const u32 bsdsr_table_pattern1[] = {
 	0x01800000, /* 6 - 1/6 */
 	0x01000000, /* 6 - 1/4 */
 	0x00c00000, /* 6 - 1/3 */
@@ -143,7 +143,7 @@ const static u32 bsdsr_table_pattern1[] = {
 	0x00400000, /* 6 - 1   */
 };
 
-const static u32 bsdsr_table_pattern2[] = {
+static const u32 bsdsr_table_pattern2[] = {
 	0x02400000, /* 6 - 1/6 */
 	0x01800000, /* 6 - 1/4 */
 	0x01200000, /* 6 - 1/3 */
@@ -152,7 +152,7 @@ const static u32 bsdsr_table_pattern2[] = {
 	0x00600000, /* 6 - 1   */
 };
 
-const static u32 bsisr_table[] = {
+static const u32 bsisr_table[] = {
 	0x00100060, /* 6 - 1/6 */
 	0x00100040, /* 6 - 1/4 */
 	0x00100030, /* 6 - 1/3 */
@@ -161,7 +161,7 @@ const static u32 bsisr_table[] = {
 	0x00100020, /* 6 - 1   */
 };
 
-const static u32 chan288888[] = {
+static const u32 chan288888[] = {
 	0x00000006, /* 1 to 2 */
 	0x000001fe, /* 1 to 8 */
 	0x000001fe, /* 1 to 8 */
@@ -170,7 +170,7 @@ const static u32 chan288888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan244888[] = {
+static const u32 chan244888[] = {
 	0x00000006, /* 1 to 2 */
 	0x0000001e, /* 1 to 4 */
 	0x0000001e, /* 1 to 4 */
@@ -179,7 +179,7 @@ const static u32 chan244888[] = {
 	0x000001fe, /* 1 to 8 */
 };
 
-const static u32 chan222222[] = {
+static const u32 chan222222[] = {
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
 	0x00000006, /* 1 to 2 */
-- 
2.19.2
