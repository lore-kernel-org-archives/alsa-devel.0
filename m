From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: skl_hda_dsp_common: create HDMI
	jack kctl" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:38 +0100 (BST)
Message-ID: <20190808203339.095C32742BE9@ypsilon.sirena.org.uk>
References: <20190808192734.18286-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E6E5F805A8
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:42 +0200 (CEST)
In-Reply-To: <20190808192734.18286-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Libin Yang <libin.yang@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: skl_hda_dsp_common: create HDMI jack kctl

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 0e4cc44f5066b22938f384cd57db99d66311de90 Mon Sep 17 00:00:00 2001
From: Libin Yang <libin.yang@intel.com>
Date: Thu, 8 Aug 2019 14:27:34 -0500
Subject: [PATCH] ASoC: intel: skl_hda_dsp_common: create HDMI jack kctl

This patch call snd_jack_add_new_kctl() to create the HDMI jack kctls.
Userspace needs these kctls to detect the hdmi monitor hotplug.

In /usr/share/alsa/ucm, the config file needs to assign a jack kctl to
"JackControl" to let PA get the jack hotplug status.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190808192734.18286-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_hda_dsp_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 55fd82e05e2c..58409b6e476e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -147,6 +147,11 @@ int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
 		if (err)
 			return err;
 
+		err = snd_jack_add_new_kctl(pcm->hdmi_jack.jack,
+					    jack_name, SND_JACK_AVOUT);
+		if (err)
+			dev_warn(component->dev, "failed creating Jack kctl\n");
+
 		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
 					  &pcm->hdmi_jack);
 		if (err < 0)
-- 
2.20.1
