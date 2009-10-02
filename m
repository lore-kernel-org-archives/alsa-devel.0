From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] Soc: wm8940: Fix check on error code form
	snd_soc_codec_set_cache_io
Date: Fri, 02 Oct 2009 16:09:49 +0100
Message-ID: <4AC617BD.4070706@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-5.csi.cam.ac.uk (ppsw-5.csi.cam.ac.uk [131.111.8.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 957FF244F5
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 17:09:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


Soc: wm8940: Fix check on error code form snd_soc_codec_set_cache_io

Fix for typo in commit 8d50e447d19fec64adebeef55f2b60d695435412
ASoC: Factor out I/O for Wolfson 8 bit data 16 bit register CODECs

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---

 sound/soc/codecs/wm8940.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index da97aae..1ef2454 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -790,7 +790,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 	codec->reg_cache = &wm8940->reg_cache;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
-	if (ret == 0) {
+	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
-- 
1.6.3.3
