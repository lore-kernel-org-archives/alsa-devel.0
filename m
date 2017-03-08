From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/8] ASoC: rt5665: Vref3 is necessary for Mono
	Amp
Date: Wed, 8 Mar 2017 19:05:31 +0800
Message-ID: <1488971136-19100-3-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 64F76267098
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:48 +0100 (CET)
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

Vref3 is necessary for Mono Amp. So add it to dapm routes

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index ecc02ee..4fd542b 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -3915,6 +3915,7 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 	{"Mono MIX", "MONOVOL Switch", "MONOVOL"},
 	{"Mono Amp", NULL, "Mono MIX"},
 	{"Mono Amp", NULL, "Vref2"},
+	{"Mono Amp", NULL, "Vref3"},
 	{"Mono Amp", NULL, "CLKDET SYS"},
 	{"Mono Amp", NULL, "CLKDET MONO"},
 	{"Mono Playback", "Switch", "Mono Amp"},
-- 
2.7.4
