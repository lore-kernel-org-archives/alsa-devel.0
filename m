From: Andrei Hirgau <hirgauandrei@gmail.com>
Subject: [PATCH] sound: soc: generic: Removed unnecessary blank line
Date: Sat, 25 Feb 2017 12:29:37 +0200
Message-ID: <1488018577-10910-1-git-send-email-hirgauandrei@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com, nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrei Hirgau <hirgauandrei@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reported by checkpatch.pl

Signed-off-by: Andrei Hirgau <hirgauandrei@gmail.com>
---
 sound/soc/generic/simple-card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 85b4f18..53bcf95 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -448,7 +448,6 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->snd_card.num_links	= num;
 
 	if (np && of_device_is_available(np)) {
-
 		ret = asoc_simple_card_parse_of(np, priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
-- 
2.7.4
