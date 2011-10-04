From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Remove unneeded hw_write
	initialisation in ak4671
Date: Tue, 04 Oct 2011 11:44:42 +0800
Message-ID: <1317699882.19150.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 54B972440C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 05:45:00 +0200 (CEST)
Received: by ywn1 with SMTP id 1so82535ywn.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 20:44:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It is not required now.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4671.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 2ecf128..41e3d55 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -628,8 +628,6 @@ static int ak4671_probe(struct snd_soc_codec *codec)
 	struct ak4671_priv *ak4671 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4671->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-- 
1.7.4.1
