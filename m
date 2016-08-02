From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs53l30: Constify
	cs53l30_mclk_coeffs and cs53l30_mclkx_coeffs tables
Date: Tue,  2 Aug 2016 13:48:31 +0800
Message-ID: <1470116911-7592-2-git-send-email-axel.lin@ingics.com>
References: <1470116911-7592-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 68BA2265938
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 07:49:13 +0200 (CEST)
Received: by mail-pa0-f65.google.com with SMTP id hh10so11282721pac.1
 for <alsa-devel@alsa-project.org>; Mon, 01 Aug 2016 22:49:13 -0700 (PDT)
In-Reply-To: <1470116911-7592-1-git-send-email-axel.lin@ingics.com>
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
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 227c556..b69c483 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -466,7 +466,7 @@ struct cs53l30_mclk_div {
 	u8 mclk_int_scale;
 };
 
-static struct cs53l30_mclk_div cs53l30_mclk_coeffs[] = {
+static const struct cs53l30_mclk_div cs53l30_mclk_coeffs[] = {
 	/* NOTE: Enable MCLK_INT_SCALE to save power. */
 
 	/* MCLK, Sample Rate, asp_rate, internal_fs_ratio, mclk_int_scale */
@@ -511,7 +511,7 @@ struct cs53l30_mclkx_div {
 	u8 mclkdiv;
 };
 
-static struct cs53l30_mclkx_div cs53l30_mclkx_coeffs[] = {
+static const struct cs53l30_mclkx_div cs53l30_mclkx_coeffs[] = {
 	{5644800,  1, CS53L30_MCLK_DIV_BY_1},
 	{6000000,  1, CS53L30_MCLK_DIV_BY_1},
 	{6144000,  1, CS53L30_MCLK_DIV_BY_1},
-- 
2.7.4
