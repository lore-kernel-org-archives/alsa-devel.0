From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to reconfigure registers
	in runtime resume" to the asoc tree
Date: Sun, 21 Feb 2016 02:15:44 +0900
Message-ID: <E1aXB8C-0008M6-G2@finisterre>
References: <1454161428-7896-15-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38EA62650BD
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:50 +0100 (CET)
In-Reply-To: <1454161428-7896-15-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix to reconfigure registers in runtime resume

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

>From ab85f5b36ea3474622303a36293e63cf78f4a797 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 17 Feb 2016 21:34:02 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to reconfigure registers in runtime
 resume

The register are reset during the D3 to D0 transition. So
reconfigure them.

Also as all DAIs are now supported, remove the dai id check in prepare.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 57ab212..2445b43 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -374,11 +374,6 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	struct hdac_ext_dma_params *dd;
 	int ret;
 
-	if (dai->id > 0) {
-		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
-		return -ENODEV;
-	}
-
 	dai_map = &hdmi->dai_map[dai->id];
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
@@ -451,6 +446,18 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
+		struct hdac_hdmi_dai_pin_map *dai_map)
+{
+	/* Enable transmission */
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+			AC_VERB_SET_DIGI_CONVERT_1, 1);
+
+	/* Category Code (CC) to zero */
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+			AC_VERB_SET_DIGI_CONVERT_2, 0);
+}
+
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
 		struct hdac_hdmi_dai_pin_map *dai_map)
 {
@@ -580,6 +587,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map->pin = pin;
 
+	hdac_hdmi_enable_cvt(hdac, dai_map);
 	ret = hdac_hdmi_enable_pin(hdac, dai_map);
 	if (ret < 0)
 		return ret;
@@ -949,14 +957,6 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 		dai_map->dai_id = dai_id;
 		dai_map->cvt = cvt;
 
-		/* Enable transmission */
-		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-				AC_VERB_SET_DIGI_CONVERT_1, 1);
-
-		/* Category Code (CC) to zero */
-		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-				AC_VERB_SET_DIGI_CONVERT_2, 0);
-
 		dai_id++;
 
 		if (dai_id == HDA_MAX_CVTS) {
@@ -1527,6 +1527,9 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 		return err;
 	}
 
+	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
+	hdac_hdmi_skl_enable_dp12(&edev->hdac);
+
 	/* Power up afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
-- 
2.7.0
