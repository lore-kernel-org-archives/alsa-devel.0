From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: remove HDMI device
	unregister" to the asoc tree
Date: Wed, 08 Feb 2017 18:34:00 +0000
Message-ID: <E1cbX44-0000gl-L0@debutante>
References: <1486547221-32593-1-git-send-email-vincent.abriou@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68B97266B0A
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 19:34:14 +0100 (CET)
In-Reply-To: <1486547221-32593-1-git-send-email-vincent.abriou@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vincent Abriou <vincent.abriou@st.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: remove HDMI device unregister

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8480ac567959eecdc694cf4f9c02d6fa687384b6 Mon Sep 17 00:00:00 2001
From: Vincent Abriou <vincent.abriou@st.com>
Date: Wed, 8 Feb 2017 10:47:01 +0100
Subject: [PATCH] ASoC: hdmi-codec: remove HDMI device unregister

While unregistering the hdmi-codec, the hdmi device list must be
cleaned up. It avoid kernel page fault when registering again the
hdmi-codec.

Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index dc6715a804a1..8c5ae1fc23a9 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -32,6 +32,7 @@ struct hdmi_device {
 };
 #define pos_to_hdmi_device(pos)	container_of((pos), struct hdmi_device, list)
 LIST_HEAD(hdmi_device_list);
+static DEFINE_MUTEX(hdmi_mutex);
 
 #define DAI_NAME_SIZE 16
 
@@ -794,6 +795,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hd = NULL;
+	mutex_lock(&hdmi_mutex);
 	list_for_each(pos, &hdmi_device_list) {
 		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
 
@@ -805,13 +807,16 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 	if (!hd) {
 		hd = devm_kzalloc(dev, sizeof(*hd), GFP_KERNEL);
-		if (!hd)
+		if (!hd) {
+			mutex_unlock(&hdmi_mutex);
 			return -ENOMEM;
+		}
 
 		hd->dev = dev->parent;
 
 		list_add_tail(&hd->list, &hdmi_device_list);
 	}
+	mutex_unlock(&hdmi_mutex);
 
 	if (hd->cnt >= ARRAY_SIZE(hdmi_dai_name)) {
 		dev_err(dev, "too many hdmi codec are deteced\n");
@@ -853,11 +858,25 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct list_head *pos;
 	struct hdmi_codec_priv *hcp;
 
-	hcp = dev_get_drvdata(&pdev->dev);
+	mutex_lock(&hdmi_mutex);
+	list_for_each(pos, &hdmi_device_list) {
+		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
+
+		if (tmp->dev == dev->parent) {
+			list_del(pos);
+			break;
+		}
+	}
+	mutex_unlock(&hdmi_mutex);
+
+	hcp = dev_get_drvdata(dev);
 	kfree(hcp->chmap_info);
-	snd_soc_unregister_codec(&pdev->dev);
+	snd_soc_unregister_codec(dev);
+
 	return 0;
 }
 
-- 
2.11.0
