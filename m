From: Mark Brown <broonie@kernel.org>
Subject: Applied "rt286: add Thinkpad Helix 2 to force_combo_jack_table" to the asoc tree
Date: Mon, 15 May 2017 17:03:01 +0900
Message-ID: <E1dAAy5-0002Sr-2s@finisterre>
References: <20170503173414.GA28670@localhost.localdomain>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503173414.GA28670@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Yifeng Li <tomli@tomli.me>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, oder_chiou@realtek.com, jinliangx.wang@intel.com, yang.jie@linux.intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.orgbroonie@kernel.org, bardliao@realtek.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   rt286: add Thinkpad Helix 2 to force_combo_jack_table

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

>From fe0dfd6358a17c79bd7d6996af7512ba452a7059 Mon Sep 17 00:00:00 2001
From: Yifeng Li <tomli@tomli.me>
Date: Thu, 4 May 2017 01:34:14 +0800
Subject: [PATCH] rt286: add Thinkpad Helix 2 to force_combo_jack_table

Thinkpad Helix 2 is a tablet PC, the audio is powered by Core M
broadwell-audio and rt286 codec. For all versions of Linux kernel,
the stereo output doesn't work properly when earphones are plugged
in, the sound was coming out from both channels even if the audio
contains only the left or right channel. Furthermore, if a music
recorded in stereo is played, the two channels cancle out each other
out, as a result, no voice but only distorted background music can be
heard, like a sound card with builtin a Karaoke sount effect.

Apparently this tablet uses a combo jack with polarity incorrectly
set by rt286 driver. This patch adds DMI information of Thinkpad Helix 2
to force_combo_jack_table[] and the issue is resolved. The microphone
input doesn't work regardless to the presence of this patch and still
needs help from other developers to investigate.

This is my first patch to LKML directly, sorry for CC-ing too many
people here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=93841
Signed-off-by: Yifeng Li <tomli@tomli.me>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 9c365a7f758d..7899a2cdeb42 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1108,6 +1108,13 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Kabylake Client platform")
 		}
 	},
+	{
+		.ident = "Thinkpad Helix 2nd",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Helix 2nd")
+		}
+	},
 
 	{ }
 };
-- 
2.11.0
