From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OSS: keep index within bounds of midi_devs[]
Date: Mon, 16 Nov 2009 17:05:02 +0100
Message-ID: <4B01782E.80802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752901AbZKPPwg@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When the {orig,midi}_dev equals num_midis, that's one too
large already.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
In MIDIbuf_open() sound/oss/midibuf.c:166

        if (num_midis > MAX_MIDI_DEV)
        {
                printk(KERN_ERR "midi: Too many midi interfaces\n");
                num_midis = MAX_MIDI_DEV;
        }

num_midis is at most MAX_MIDI_DEV.

`git grep -n MAX_MIDI_DEV' and note that when the index equals
num_midis this causes reads/writes outside array bounds for
midi_devs, midi2synth, dev_conf and others (below check in patch).

 sound/oss/midi_synth.c |    2 +-
 sound/oss/mpu401.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/midi_synth.c b/sound/oss/midi_synth.c
index 9e45098..3bc7104 100644
--- a/sound/oss/midi_synth.c
+++ b/sound/oss/midi_synth.c
@@ -426,7 +426,7 @@ midi_synth_open(int dev, int mode)
 	int             err;
 	struct midi_input_info *inc;
 
-	if (orig_dev < 0 || orig_dev > num_midis || midi_devs[orig_dev] == NULL)
+	if (orig_dev < 0 || orig_dev >= num_midis || midi_devs[orig_dev] == NULL)
 		return -ENXIO;
 
 	midi2synth[orig_dev] = dev;
diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 734b8f9..0af9d24 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -770,7 +770,7 @@ static int mpu_synth_ioctl(int dev, unsigned int cmd, void __user *arg)
 
 	midi_dev = synth_devs[dev]->midi_dev;
 
-	if (midi_dev < 0 || midi_dev > num_midis || midi_devs[midi_dev] == NULL)
+	if (midi_dev < 0 || midi_dev >= num_midis || midi_devs[midi_dev] == NULL)
 		return -ENXIO;
 
 	devc = &dev_conf[midi_dev];
