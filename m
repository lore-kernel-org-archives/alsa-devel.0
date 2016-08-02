From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs42l73: Constify
	cs42l73_mclk_coeffs and cs42l73_mclkx_coeffs tables
Date: Tue,  2 Aug 2016 13:48:30 +0800
Message-ID: <1470116911-7592-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 950A02658B3
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 07:49:08 +0200 (CEST)
Received: by mail-pa0-f66.google.com with SMTP id cf3so11206550pad.2
 for <alsa-devel@alsa-project.org>; Mon, 01 Aug 2016 22:49:08 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l73.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 42a8fd4..8524e22 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -794,7 +794,7 @@ struct cs42l73_mclk_div {
 	u8 mmcc;
 };
 
-static struct cs42l73_mclk_div cs42l73_mclk_coeffs[] = {
+static const struct cs42l73_mclk_div cs42l73_mclk_coeffs[] = {
 	/* MCLK, Sample Rate, xMMCC[5:0] */
 	{5644800, 11025, 0x30},
 	{5644800, 22050, 0x20},
@@ -844,7 +844,7 @@ struct cs42l73_mclkx_div {
 	u8 mclkdiv;
 };
 
-static struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] = {
+static const struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] = {
 	{5644800,  1, 0},	/* 5644800 */
 	{6000000,  1, 0},	/* 6000000 */
 	{6144000,  1, 0},	/* 6144000 */
-- 
2.7.4
