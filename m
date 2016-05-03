From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Potential NULL deref in hdac_hdmi_get_spk_alloc()" to the asoc tree
Date: Tue, 03 May 2016 17:31:04 +0100
Message-ID: <E1axdE0-0007md-6S@debutante>
References: <20160503074258.GA9722@mwanda>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503074258.GA9722@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Sachin Mokashi <sachinx.mokashi@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Potential NULL deref in hdac_hdmi_get_spk_alloc()

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

>From 8f658815da156a9239b98b34e5ba1d3db71a2f6e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 3 May 2016 10:42:58 +0300
Subject: [PATCH] ASoC: hdac_hdmi: Potential NULL deref in
 hdac_hdmi_get_spk_alloc()

We intended || here instead of &&.  The original code potentially leads
to a NULL dereference.

Fixes: 2889099eb8cd ('ASoC: hdac_hdmi: Register chmap controls and ops')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0ed39753c871..f1170e060230 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1614,7 +1614,7 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_pin *pin = pcm->pin;
 
-	if (!pin && !pin->eld.eld_valid)
+	if (!pin || !pin->eld.eld_valid)
 		return 0;
 
 	return pin->eld.info.spk_alloc;
-- 
2.8.1
