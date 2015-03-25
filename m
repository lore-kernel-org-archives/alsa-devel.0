From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: [PATCH] ASoC: snd_soc_tas5086: Reinit register values
	on probe
Date: Wed, 25 Mar 2015 16:29:39 +0100
Message-ID: <1427297379-17736-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B83F265363
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 16:30:34 +0100 (CET)
Received: by wgs2 with SMTP id 2so32038958wgs.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:30:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zonque@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

If the machine driver has been un/reloaded, the register values of
the codec driver have to be reinitialized in order to run properly.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 sound/soc/codecs/tas5086.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 249ef5c..cd19171 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -851,10 +851,16 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	}
 
 	tas5086_reset(priv);
+	regcache_mark_dirty(priv->regmap);
+
 	ret = tas5086_init(codec->dev, priv);
 	if (ret < 0)
 		goto exit_disable_regulators;
 
+	ret = regcache_sync(priv->regmap);
+	if (ret < 0)
+		goto exit_disable_regulators;
+
 	/* set master volume to 0 dB */
 	ret = regmap_write(priv->regmap, TAS5086_MASTER_VOL, 0x30);
 	if (ret < 0)
-- 
1.9.3
