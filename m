From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound/sb_midi: a couple indenting fixes
Date: Wed, 25 Feb 2015 16:32:16 +0300
Message-ID: <20150225133216.GQ19745@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Let's make things line up a little bit better.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/sb_midi.c b/sound/oss/sb_midi.c
index f139028..551ee75 100644
--- a/sound/oss/sb_midi.c
+++ b/sound/oss/sb_midi.c
@@ -179,14 +179,14 @@ void sb_dsp_midi_init(sb_devc * devc, struct module *owner)
 	{
 		printk(KERN_WARNING "Sound Blaster:  failed to allocate MIDI memory.\n");
 		sound_unload_mididev(dev);
-		  return;
+		return;
 	}
 	memcpy((char *) midi_devs[dev], (char *) &sb_midi_operations,
 	       sizeof(struct midi_operations));
 
 	if (owner)
-			midi_devs[dev]->owner = owner;
-	
+		midi_devs[dev]->owner = owner;
+
 	midi_devs[dev]->devc = devc;
 
 
