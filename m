From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] ALSA: hda: Fix assign invalid fixed slots pcm numbers to
 HDA_PCM_TYPE_HDMI in get_empty_pcm_device
Date: Sun, 3 Sep 2017 21:52:31 +0800
Message-ID: <20170903135231.GB2278@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

The length of pcm_dev_bits in hda_bus is SNDRV_PCM_DEVICES,
and the definiton of SNDRV_PCM_DEVICES is:
"
 #if defined(CONFIG_SND_DYNAMIC_MINORS)
 #define SNDRV_PCM_DEVICES       (SNDRV_OS_MINORS-2)
 #else
 #define SNDRV_PCM_DEVICES       8
 #endif
"

So the max valid fixed slots pcm number is 7, and the first
non-fixed slot is 8.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 sound/pci/hda/hda_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3db26c4..df6b57e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3118,7 +3118,7 @@ static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 	static int audio_idx[HDA_PCM_NTYPES][5] = {
 		[HDA_PCM_TYPE_AUDIO] = { 0, 2, 4, 5, -1 },
 		[HDA_PCM_TYPE_SPDIF] = { 1, -1 },
-		[HDA_PCM_TYPE_HDMI]  = { 3, 7, 8, 9, -1 },
+		[HDA_PCM_TYPE_HDMI]  = { 3, 7, -1 },
 		[HDA_PCM_TYPE_MODEM] = { 6, -1 },
 	};
 	int i;
@@ -3139,7 +3139,7 @@ static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 
 #ifdef CONFIG_SND_DYNAMIC_MINORS
 	/* non-fixed slots starting from 10 */
-	for (i = 10; i < 32; i++) {
+	for (i = 8; i < 32; i++) {
 		if (!test_and_set_bit(i, bus->pcm_dev_bits))
 			return i;
 	}
-- 
1.8.5.6.2.g3d8a54e.dirty
