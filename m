From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hda: fix unbalanced codec dev refcount
	for HDA_DEV_ASOC" to the asoc tree
Date: Mon,  3 Jun 2019 19:02:02 +0100 (BST)
Message-ID: <20190603180202.ADC9B440046@finisterre.sirena.org.uk>
References: <20190531160137.5603-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAB5CF89737
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:03 +0200 (CEST)
In-Reply-To: <20190531160137.5603-1-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hda: fix unbalanced codec dev refcount for HDA_DEV_ASOC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From d6947bb234dcc86e878d502516d0fb9d635aa2ae Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 31 May 2019 09:01:37 -0700
Subject: [PATCH] ASoC: hda: fix unbalanced codec dev refcount for HDA_DEV_ASOC

HDA_DEV_ASOC type codec device refcounts are managed differently
from HDA_DEV_LEGACY devices. The refcount is released explicitly
in snd_hdac_ext_bus_device_remove() for ASOC type devices.
So, remove the put_device() call in snd_hda_codec_dev_free()
for such devices to make the refcount balanced. This will prevent
the NULL pointer exception when the codec driver is released
after the card is freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/pci/hda/hda_codec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ec0b8595eb4d..6cdec64dc68a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -834,7 +834,14 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 	codec->in_freeing = 1;
 	snd_hdac_device_unregister(&codec->core);
 	codec_display_power(codec, false);
-	put_device(hda_codec_dev(codec));
+
+	/*
+	 * In the case of ASoC HD-audio bus, the device refcount is released in
+	 * snd_hdac_ext_bus_device_remove() explicitly.
+	 */
+	if (codec->core.type == HDA_DEV_LEGACY)
+		put_device(hda_codec_dev(codec));
+
 	return 0;
 }
 
-- 
2.20.1
