From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset DSP pipe in
	skl_pcm_hw_free" to the asoc tree
Date: Tue, 17 Apr 2018 12:28:53 +0100
Message-ID: <E1f8On7-0000Mm-BA@debutante>
References: <1522651550-27236-3-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E26AF2675FF
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:28:58 +0200 (CEST)
In-Reply-To: <1522651550-27236-3-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Divya Prakash <divya1.prakash@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Reset DSP pipe in skl_pcm_hw_free

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 179c2e86328c3d7e07f87f9c45a216cda626e9ee Mon Sep 17 00:00:00 2001
From: Divya Prakash <divya1.prakash@intel.com>
Date: Mon, 2 Apr 2018 12:15:49 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset DSP pipe in skl_pcm_hw_free

Currently during destroy pipeline the gateway is disabled
before DMA completion. This leads to improper draining of
data and subsequently causing issues on HD-Audio DMA.
Hence added a new pipe reset IPC in skl_pcm_hw_free in
which the Gateway Enable(GEN bit) is reset to 0 after
DMA completion in skl_pcm_trigger.

Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 15cb8ac3e374..fe25515debec 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -366,9 +366,21 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_module_cfg *mconfig;
+	int ret;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+
+	if (mconfig) {
+		ret = skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+		if (ret < 0)
+			dev_err(dai->dev, "%s:Reset failed ret =%d",
+						__func__, ret);
+	}
+
 	snd_hdac_stream_cleanup(hdac_stream(stream));
 	hdac_stream(stream)->prepared = 0;
 
-- 
2.17.0
