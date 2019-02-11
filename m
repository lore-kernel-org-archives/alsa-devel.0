From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Add soft reset on probe
Date: Mon, 11 Feb 2019 07:08:38 +0100
Message-ID: <20190211060839.21417-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 97C1E267488
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 07:06:13 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Softly reset registers values on module probe

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 6714aa8d9026..543cb86fd764 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -287,6 +287,14 @@ int pcm3060_probe(struct device *dev)
 	int rc;
 	struct pcm3060_priv *priv = dev_get_drvdata(dev);
 
+	/* soft reset */
+	rc = regmap_update_bits(priv->regmap, PCM3060_REG64,
+				PCM3060_REG_MRST, 0);
+	if (rc) {
+		dev_err(dev, "failed to reset component, rc=%d\n", rc);
+		return rc;
+	}
+
 	if (dev->of_node)
 		pcm3060_parse_dt(dev->of_node, priv);
 
-- 
2.13.6
