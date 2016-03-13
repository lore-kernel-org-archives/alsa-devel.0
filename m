From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add broxton device ID" to
	the asoc tree
Date: Sun, 13 Mar 2016 15:14:56 +0700
Message-ID: <E1af1Au-0004G9-Ak@finisterre>
References: <1457671376-18667-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0107326057A
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:12 +0100 (CET)
In-Reply-To: <1457671376-18667-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add broxton device ID

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

>From e2304803fd05eac509c8e37bb626c192510e4e77 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 11 Mar 2016 10:12:55 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add broxton device ID

Broxton HDMI codec is similar to Skylake so add the device ID

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7851dd204a49..cb0b036a1139 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1634,6 +1634,7 @@ static const struct dev_pm_ops hdac_hdmi_pm = {
 
 static const struct hda_device_id hdmi_list[] = {
 	HDA_CODEC_EXT_ENTRY(0x80862809, 0x100000, "Skylake HDMI", 0),
+	HDA_CODEC_EXT_ENTRY(0x8086280a, 0x100000, "Broxton HDMI", 0),
 	{}
 };
 
-- 
2.7.0
