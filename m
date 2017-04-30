From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Disallow building designware_pcm as a module" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:31 +0900
Message-ID: <E1d4oQp-00046F-9k@finisterre>
References: <97eea73556a8d12afb66df9bc1f1d8510345098d.1493373039.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <97eea73556a8d12afb66df9bc1f1d8510345098d.1493373039.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Jose Abreu <joabreu@synopsys.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>Lubomir Rintel <lkundrak@v3.sk>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Disallow building designware_pcm as a module

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

>From c9afc1834e8132783772d73007706d3ae3848483 Mon Sep 17 00:00:00 2001
From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Fri, 28 Apr 2017 10:55:25 +0100
Subject: [PATCH] ASoC: dwc: Disallow building designware_pcm as a module

Designware PCM is an extension to Designware I2S and they are dependent
on each other. For this reason, make Designware PCM a boolean which will
compile with Desigwnare I2S module. The name of the module is not changed
but the name of the files need to be changed.

Also, without this commit we get errors when probbing designware_i2s module
because of unspecified license:

designware_pcm: module license 'unspecified' taints kernel.
Disabling lock debugging due to kernel taint
designware_pcm: Unknown symbol __rcu_read_lock (err 0)
designware_pcm: Unknown symbol devm_snd_soc_register_platform (err 0)
designware_pcm: Unknown symbol synchronize_rcu (err 0)
designware_pcm: Unknown symbol __rcu_read_unlock (err 0)
designware_pcm: Unknown symbol snd_soc_set_runtime_hwparams (err 0)

So, this is really needed as a fix.

Fixes: 79361b2b98b7 ("ASoC: dwc: Add PIO PCM extension")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/Kconfig                         | 4 ++--
 sound/soc/dwc/Makefile                        | 6 +++---
 sound/soc/dwc/{designware_i2s.c => dwc-i2s.c} | 0
 sound/soc/dwc/{designware_pcm.c => dwc-pcm.c} | 3 ---
 4 files changed, 5 insertions(+), 8 deletions(-)
 rename sound/soc/dwc/{designware_i2s.c => dwc-i2s.c} (100%)
 rename sound/soc/dwc/{designware_pcm.c => dwc-pcm.c} (98%)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index c297efe43861..c6fd95fa5ca6 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -8,10 +8,10 @@ config SND_DESIGNWARE_I2S
 	 maximum of 8 channels each for play and record.
 
 config SND_DESIGNWARE_PCM
-	tristate "PCM PIO extension for I2S driver"
+	bool "PCM PIO extension for I2S driver"
 	depends on SND_DESIGNWARE_I2S
 	help
-	 Say Y, M or N if you want to add a custom ALSA extension that registers
+	 Say Y or N if you want to add a custom ALSA extension that registers
 	 a PCM and uses PIO to transfer data.
 
 	 This functionality is specially suited for I2S devices that don't have
diff --git a/sound/soc/dwc/Makefile b/sound/soc/dwc/Makefile
index 38f1ca31c5fa..3e24c0ff95fb 100644
--- a/sound/soc/dwc/Makefile
+++ b/sound/soc/dwc/Makefile
@@ -1,5 +1,5 @@
 # SYNOPSYS Platform Support
 obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_i2s.o
-ifdef CONFIG_SND_DESIGNWARE_PCM
-obj-$(CONFIG_SND_DESIGNWARE_I2S) += designware_pcm.o
-endif
+
+designware_i2s-y := dwc-i2s.o
+designware_i2s-$(CONFIG_SND_DESIGNWARE_PCM) += dwc-pcm.o
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/dwc-i2s.c
similarity index 100%
rename from sound/soc/dwc/designware_i2s.c
rename to sound/soc/dwc/dwc-i2s.c
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/dwc-pcm.c
similarity index 98%
rename from sound/soc/dwc/designware_pcm.c
rename to sound/soc/dwc/dwc-pcm.c
index 459ec861e6b6..406fd867117b 100644
--- a/sound/soc/dwc/designware_pcm.c
+++ b/sound/soc/dwc/dwc-pcm.c
@@ -129,13 +129,11 @@ void dw_pcm_push_tx(struct dw_i2s_dev *dev)
 {
 	dw_pcm_transfer(dev, true);
 }
-EXPORT_SYMBOL_GPL(dw_pcm_push_tx);
 
 void dw_pcm_pop_rx(struct dw_i2s_dev *dev)
 {
 	dw_pcm_transfer(dev, false);
 }
-EXPORT_SYMBOL_GPL(dw_pcm_pop_rx);
 
 static int dw_pcm_open(struct snd_pcm_substream *substream)
 {
@@ -281,4 +279,3 @@ int dw_pcm_register(struct platform_device *pdev)
 {
 	return devm_snd_soc_register_platform(&pdev->dev, &dw_pcm_platform);
 }
-EXPORT_SYMBOL_GPL(dw_pcm_register);
-- 
2.11.0
