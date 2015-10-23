From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: add check for master/slave format"
	to the asoc tree
Date: Sat, 24 Oct 2015 07:17:06 +0900
Message-ID: <E1Zpke2-0002Kf-QY@finisterre>
References: <1444320760-21936-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A40D0264F30
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 00:17:22 +0200 (CEST)
In-Reply-To: <1444320760-21936-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: add check for master/slave format

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

>From ab57b8e90c658a72944c48a81a1352e61e84db02 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 23 Oct 2015 17:15:41 -0400
Subject: [PATCH] ASoC: dwc: add check for master/slave format

DW i2s controller's master/slave config can be read from a
read-only register. Machine driver can try to set a master/slave
format on cpu-dai using 'set_fmt' of dai ops. A check is added to
verify codec is master when dwc is slave and vice-versa.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 3a52f82..f427325 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -341,12 +341,43 @@ static int dw_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		if (dev->capability & DW_I2S_SLAVE)
+			ret = 0;
+		else
+			ret = -EINVAL;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		if (dev->capability & DW_I2S_MASTER)
+			ret = 0;
+		else
+			ret = -EINVAL;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret = -EINVAL;
+		break;
+	default:
+		dev_dbg(dev->dev, "dwc : Invalid master/slave format\n");
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 static struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.startup	= dw_i2s_startup,
 	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
+	.set_fmt	= dw_i2s_set_fmt,
 };
 
 static const struct snd_soc_component_driver dw_i2s_component = {
-- 
2.6.1
