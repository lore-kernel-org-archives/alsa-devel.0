From: Yifeng Li <tomli@tomli.me>
Subject: [PATCH] rt286: add Thinkpad Helix 2 to force_combo_jack_table
Date: Thu, 4 May 2017 01:34:14 +0800
Message-ID: <20170503173414.GA28670@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: bardliao@realtek.com, oder_chiou@realtek.com, broonie@kernel.org, yang.jie@linux.intel.com, jinliangx.wang@intel.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Keyon <yang.jie@linux.intel.com>
Cc: Jinliang Wang <jinliangx.wang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yifeng Li <tomli@tomli.me>
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
2.12.1
