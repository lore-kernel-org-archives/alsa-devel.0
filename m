From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 4/8] ASoC: rt5665: CLKDET is also a power of
	ASRC
Date: Wed, 8 Mar 2017 19:05:32 +0800
Message-ID: <1488971136-19100-4-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 620112670A1
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:49 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We need to power on CLKDET to use ASRC function.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 4fd542b..efacc94 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -3181,6 +3181,9 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 	{"DAC Mono Right Filter", NULL, "DAC Mono R ASRC", is_using_asrc},
 	{"DAC Stereo1 Filter", NULL, "DAC STO1 ASRC", is_using_asrc},
 	{"DAC Stereo2 Filter", NULL, "DAC STO2 ASRC", is_using_asrc},
+	{"I2S1 ASRC", NULL, "CLKDET"},
+	{"I2S2 ASRC", NULL, "CLKDET"},
+	{"I2S3 ASRC", NULL, "CLKDET"},
 
 	/*Vref*/
 	{"Mic Det Power", NULL, "Vref2"},
-- 
2.7.4
