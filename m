From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5659: connect LOUT Amp with Charge
	Pump
Date: Mon, 16 Oct 2017 19:15:14 +0800
Message-ID: <1508152516-25767-2-git-send-email-bardliao@realtek.com>
References: <1508152516-25767-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D6F5B266B38
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 13:16:02 +0200 (CEST)
In-Reply-To: <1508152516-25767-1-git-send-email-bardliao@realtek.com>
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

"Charge Pump" is necessary for "LOUT Amp".

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5659.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 999432e..fa66b11 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3209,6 +3209,7 @@ static const struct snd_soc_dapm_route rt5659_dapm_routes[] = {
 	{ "LOUT R MIX", "OUTVOL R Switch", "OUTVOL R" },
 	{ "LOUT Amp", NULL, "LOUT L MIX" },
 	{ "LOUT Amp", NULL, "LOUT R MIX" },
+	{ "LOUT Amp", NULL, "Charge Pump" },
 	{ "LOUT Amp", NULL, "SYS CLK DET" },
 	{ "LOUT L Playback", "Switch", "LOUT Amp" },
 	{ "LOUT R Playback", "Switch", "LOUT Amp" },
-- 
2.7.4
