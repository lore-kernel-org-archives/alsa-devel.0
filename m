From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: enable S24_LE format
	support" to the asoc tree
Date: Tue, 26 Mar 2019 14:42:48 +0000 (GMT)
Message-ID: <20190326144248.7BE161121B57@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3034CF89726
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:42:59 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jenny TC <jenny.tc@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: enable S24_LE format support

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

>From 36e075ce74ec4e261a638bf09d10b3348ca4d883 Mon Sep 17 00:00:00 2001
From: Jenny TC <jenny.tc@intel.com>
Date: Sat, 23 Mar 2019 18:40:10 +0530
Subject: [PATCH] ASoC: Intel: Skylake: enable S24_LE format support

To enable S24_LE format, sample_type in topology fw has to be set to 1.
But sample_type defined in topology firmware configuration is not
getting reflected in the dsp param. This patch sets sample_type in base
config so that the sample type defined in the topology firmware is reflected
in the dsp params. This issues was uncovered while debugging the S24_LE format
which require the MSB byte in 32 bit word to be skipped. Setting sample_type
in topology firmware to 1 helps to skip MSB byte word.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 28c4806b196a..4bf70b4429f0 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -483,6 +483,7 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 	base_cfg->audio_fmt.bit_depth = format->bit_depth;
 	base_cfg->audio_fmt.valid_bit_depth = format->valid_bit_depth;
 	base_cfg->audio_fmt.ch_cfg = format->ch_cfg;
+	base_cfg->audio_fmt.sample_type = format->sample_type;
 
 	dev_dbg(ctx->dev, "bit_depth=%x valid_bd=%x ch_config=%x\n",
 			format->bit_depth, format->valid_bit_depth,
-- 
2.20.1
