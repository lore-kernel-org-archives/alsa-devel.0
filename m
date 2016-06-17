From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: cs53l30: Fix non static symbol
	warnings
Date: Fri, 17 Jun 2016 17:22:00 +0000
Message-ID: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 414602668E3
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 19:22:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

sound/soc/codecs/cs53l30.c:182:20: warning:
 symbol 'input1_sel_values' was not declared. Should it be static?
sound/soc/codecs/cs53l30.c:202:20: warning:
 symbol 'input2_sel_values' was not declared. Should it be static?
sound/soc/codecs/cs53l30.c:734:20: warning:
 symbol 'cs53l30_src_rates' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/cs53l30.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 714e579..a9949ad 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -179,7 +179,7 @@ static const char * const input1_sel_text[] = {
 	"DMIC1 Off ADC1 Off",
 };
 
-unsigned int const input1_sel_values[] = {
+static unsigned int const input1_sel_values[] = {
 	CS53L30_CH_TYPE,
 	CS53L30_ADCxB_PDN | CS53L30_CH_TYPE,
 	CS53L30_ADCxA_PDN | CS53L30_CH_TYPE,
@@ -199,7 +199,7 @@ static const char * const input2_sel_text[] = {
 	"DMIC2 Off ADC2 Off",
 };
 
-unsigned int const input2_sel_values[] = {
+static unsigned int const input2_sel_values[] = {
 	0x0,
 	CS53L30_ADCxB_PDN,
 	CS53L30_ADCxA_PDN,
@@ -731,7 +731,7 @@ static int cs53l30_set_tristate(struct snd_soc_dai *dai, int tristate)
 				  CS53L30_ASP_3ST_MASK, val);
 }
 
-unsigned int const cs53l30_src_rates[] = {
+static unsigned int const cs53l30_src_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
 };
