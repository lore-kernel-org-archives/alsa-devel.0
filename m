From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: use dev_to_hdac_dev and
	to_ehdac_device" to the asoc tree
Date: Mon, 04 Jan 2016 22:18:49 +0000
Message-ID: <E1aGDSj-0002kl-BP@debutante>
References: <a740643997f286e5ec60d523ddcb9d42f78f514a.1451312334.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81F3C260522
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 23:18:59 +0100 (CET)
In-Reply-To: <a740643997f286e5ec60d523ddcb9d42f78f514a.1451312334.git.geliangtang@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geliang Tang <geliangtang@163.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: use dev_to_hdac_dev and to_ehdac_device

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

>From 51b2c4258f29d83120819a829a78345a3dac17c4 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliangtang@163.com>
Date: Mon, 28 Dec 2015 22:47:13 +0800
Subject: [PATCH] ASoC: hdac_hdmi: use dev_to_hdac_dev and to_ehdac_device

Use dev_to_hdac_dev() and to_ehdac_device() instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1a2f33b4abfc..b999fb2a463b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -67,9 +67,9 @@ struct hdac_hdmi_priv {
 
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 {
-	struct hdac_device *hdac = container_of(dev, struct hdac_device, dev);
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
 
-	return container_of(hdac, struct hdac_ext_device, hdac);
+	return to_ehdac_device(hdac);
 }
 
 static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
-- 
2.6.2
