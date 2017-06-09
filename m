From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ak4613: Fix out of bounds array access
	for ak4613_iface
Date: Fri,  9 Jun 2017 15:01:21 +0800
Message-ID: <20170609070121.30359-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D98CD266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:01:34 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id v14so6884063pgn.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:01:34 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ak4613.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index e3121ca..c87ec49 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -347,7 +347,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 		if (ak4613_dai_fmt_matching(priv->iface, is_play, fmt, width))
 			iface = priv->iface;
 	} else {
-		for (i = ARRAY_SIZE(ak4613_iface); i >= 0; i--) {
+		for (i = ARRAY_SIZE(ak4613_iface) - 1; i >= 0; i--) {
 			if (!ak4613_dai_fmt_matching(ak4613_iface + i,
 						     is_play,
 						     fmt, width))
-- 
2.9.3
