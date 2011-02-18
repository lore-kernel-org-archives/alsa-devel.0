From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 10/29] wl1273: mfd_cell is now implicitly
	available to drivers
Date: Thu, 17 Feb 2011 19:07:17 -0800
Message-ID: <1297998456-7615-11-git-send-email-dilinger@queued.net>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lunge.queued.net (LUNGE.MIT.EDU [18.54.1.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EBB124422
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 04:08:03 +0100 (CET)
In-Reply-To: <1297998456-7615-1-git-send-email-dilinger@queued.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The cell's platform_data is now accessed with a helper function;
change clients to use that, and remove the now-unused data_size.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/media/radio/radio-wl1273.c |    2 +-
 drivers/mfd/wl1273-core.c          |    2 --
 sound/soc/codecs/wl1273.c          |    3 ++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/radio/radio-wl1273.c b/drivers/media/radio/radio-wl1273.c
index 7ecc8e6..4698eb0 100644
--- a/drivers/media/radio/radio-wl1273.c
+++ b/drivers/media/radio/radio-wl1273.c
@@ -2138,7 +2138,7 @@ static int wl1273_fm_radio_remove(struct platform_device *pdev)
 
 static int __devinit wl1273_fm_radio_probe(struct platform_device *pdev)
 {
-	struct wl1273_core **core = pdev->dev.platform_data;
+	struct wl1273_core **core = mfd_get_data(pdev);
 	struct wl1273_device *radio;
 	struct v4l2_ctrl *ctrl;
 	int r = 0;
diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index d2ecc24..703085e 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -80,7 +80,6 @@ static int __devinit wl1273_core_probe(struct i2c_client *client,
 	cell = &core->cells[children];
 	cell->name = "wl1273_fm_radio";
 	cell->platform_data = &core;
-	cell->data_size = sizeof(core);
 	children++;
 
 	if (pdata->children & WL1273_CODEC_CHILD) {
@@ -89,7 +88,6 @@ static int __devinit wl1273_core_probe(struct i2c_client *client,
 		dev_dbg(&client->dev, "%s: Have codec.\n", __func__);
 		cell->name = "wl1273-codec";
 		cell->platform_data = &core;
-		cell->data_size = sizeof(core);
 		children++;
 	}
 
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 861b28f..1ad0d5a 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -436,7 +436,8 @@ EXPORT_SYMBOL_GPL(wl1273_get_format);
 
 static int wl1273_probe(struct snd_soc_codec *codec)
 {
-	struct wl1273_core **core = codec->dev->platform_data;
+	struct wl1273_core **core =
+			mfd_get_data(to_platform_device(codec->dev));
 	struct wl1273_priv *wl1273;
 	int r;
 
-- 
1.7.2.3
