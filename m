From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: hdac_hdmi: Limit sampling rates
	at dai creation" to the asoc tree
Date: Fri,  7 Sep 2018 17:08:46 +0100 (BST)
Message-ID: <20180907160846.D47601122A6D@debutante.sirena.org.uk>
References: <1533662356-6452-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA2A4267835
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 18:08:51 +0200 (CEST)
In-Reply-To: <1533662356-6452-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, harshapriya.n@intel.com, vkoul@kernel.org, broonie@kernel.org, naveen.m@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: hdac_hdmi: Limit sampling rates at dai creation

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

>From 3b857472f34faa7d11001afa5e158833812c98d7 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Tue, 7 Aug 2018 12:19:16 -0500
Subject: [PATCH] ASoC: Intel: hdac_hdmi: Limit sampling rates at dai creation

Playback of 44.1Khz contents with HDMI plugged returns
"Invalid pipe config" because HDMI paths in the FW
topology are configured to operate at 48Khz.

This patch filters out sampling rates not supported
at hdac_hdmi_create_dais() to let user space SRC
to do the converting.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index dc6a0dfea050..41d90dc6ebf7 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1410,6 +1410,12 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdev,
 		if (ret)
 			return ret;
 
+		/* Filter out 44.1, 88.2 and 176.4Khz */
+		rates &= ~(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_88200 |
+			   SNDRV_PCM_RATE_176400);
+		if (!rates)
+			return -EINVAL;
+
 		sprintf(dai_name, "intel-hdmi-hifi%d", i+1);
 		hdmi_dais[i].name = devm_kstrdup(&hdev->dev,
 					dai_name, GFP_KERNEL);
-- 
2.19.0.rc1
