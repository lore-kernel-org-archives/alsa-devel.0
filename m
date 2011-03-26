From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: twl6040: Return -ENOMEM if
 create_singlethread_workqueue fails
Date: Sat, 26 Mar 2011 15:53:58 +0800
Message-ID: <1301126038.7662.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/twl6040.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 482fcdb..255901c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1629,8 +1629,10 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	priv->naudint = naudint;
 	priv->workqueue = create_singlethread_workqueue("twl6040-codec");
 
-	if (!priv->workqueue)
+	if (!priv->workqueue) {
+		ret = -ENOMEM;
 		goto work_err;
+	}
 
 	INIT_DELAYED_WORK(&priv->delayed_work, twl6040_accessory_work);
 
-- 
1.7.1
