From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Refresh sysfs during hdmi
	device probe" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:08 +0000
Message-ID: <E1eMdoi-0004js-Cs@debutante>
References: <20171206110406.11400-6-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CE22F2679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:19 +0100 (CET)
In-Reply-To: <20171206110406.11400-6-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Puneeth Prabhu <puneethx.prabhu@intel.com>
Cc: alsa-devel@alsa-project.org, Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Refresh sysfs during hdmi device probe

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

>From 0fb02ba36d01a04dab03c0a424607844ef4dadbf Mon Sep 17 00:00:00 2001
From: Puneeth Prabhu <puneethx.prabhu@intel.com>
Date: Wed, 6 Dec 2017 16:34:05 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Refresh sysfs during hdmi device probe

All nodes of hdmi codec widgets are not updated in sysfs interface
(/sys/bus/hdaudio/devices/<dev>/widgets/) as the vendor widget is not
programmed to enable all the converters and pins during init. So,
refresh the sysfs widget interface after enabling all pins and
converters.

Signed-off-by: Puneeth Prabhu <puneethx.prabhu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 3a35ede7027d..b706547c46d5 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2042,6 +2042,7 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 			"Failed in parse and map nid with err: %d\n", ret);
 		return ret;
 	}
+	snd_hdac_refresh_widgets(hdev, true);
 
 	/* ASoC specific initialization */
 	ret = snd_soc_register_codec(&hdev->dev, &hdmi_hda_codec,
-- 
2.15.0
