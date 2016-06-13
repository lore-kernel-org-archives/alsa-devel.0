From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: arizona: Add a couple of missing
	consts
Date: Mon, 13 Jun 2016 13:35:14 +0100
Message-ID: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C40265347
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:35:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ajit.pandey@soctronics.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 549161b..8d6dbf3 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -630,7 +630,7 @@ const struct soc_enum arizona_asrc_rate1 =
 			      arizona_rate_text, arizona_rate_val);
 EXPORT_SYMBOL_GPL(arizona_asrc_rate1);
 
-static const char *arizona_vol_ramp_text[] = {
+static const char * const arizona_vol_ramp_text[] = {
 	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
 	"15ms/6dB", "30ms/6dB",
 };
@@ -659,7 +659,7 @@ SOC_ENUM_SINGLE_DECL(arizona_out_vi_ramp,
 		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_out_vi_ramp);
 
-static const char *arizona_lhpf_mode_text[] = {
+static const char * const arizona_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
 
@@ -687,7 +687,7 @@ SOC_ENUM_SINGLE_DECL(arizona_lhpf4_mode,
 		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf4_mode);
 
-static const char *arizona_ng_hold_text[] = {
+static const char * const arizona_ng_hold_text[] = {
 	"30ms", "120ms", "250ms", "500ms",
 };
 
@@ -1764,7 +1764,7 @@ restore_aif:
 	return ret;
 }
 
-static const char *arizona_dai_clk_str(int clk_id)
+static const char * const arizona_dai_clk_str(int clk_id)
 {
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
-- 
2.1.4
