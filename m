From: pascal.huerst@gmail.com
Subject: [PATCH 1/1] ASoC: tas5086: Reinit register values in
	probe function
Date: Thu, 22 Jan 2015 16:26:46 +0100
Message-ID: <1421940406-20283-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

If the machine driver has been un/reloaded, the register values of
the tas5086 codec have to be reinitialized, in order to work properly.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>

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
