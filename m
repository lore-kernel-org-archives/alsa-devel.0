From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: remove unused 'dai_map'" to
	the asoc tree
Date: Thu, 15 Dec 2016 12:21:43 +0000
Message-ID: <E1cHV2d-0000u8-R1@debutante>
References: <1481218297-17568-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2052086260511479892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 310EB266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:49 +0100 (CET)
In-Reply-To: <1481218297-17568-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============2052086260511479892==
Content-Type: text/plain

The patch

   ASoC: hdac_hdmi: remove unused 'dai_map'

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

>From d56923da8f92dee0b557d3a8d6a3639deec35637 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:28 +0530
Subject: [PATCH] ASoC: hdac_hdmi: remove unused 'dai_map'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In hdac_hdmi_playback_cleanup(), a variable 'dai_map' is initialized but not
used. Also while removing this two mare variables 'edev' and 'hdmi' become
unused, so remove all these as well.

sound/soc/codecs/hdac_hdmi.c: In function ‘hdac_hdmi_playback_cleanup’:
sound/soc/codecs/hdac_hdmi.c:470:32: warning: variable ‘dai_map’ set but not used [-Wunused-but-set-variable]
  struct hdac_hdmi_dai_pin_map *dai_map;

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c602c4960924..793bc853ddef 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -464,12 +464,7 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
 	struct hdac_ext_dma_params *dd;
-	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
-
-	dai_map = &hdmi->dai_map[dai->id];
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 
-- 
2.11.0


--===============2052086260511479892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2052086260511479892==--
