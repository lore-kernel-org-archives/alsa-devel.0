From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] sound: oss: uart401: Used kmemdup instead of kmalloc and memcpy
Date: Mon, 25 Mar 2013 15:46:49 +0200
Message-ID: <1364219209-11807-1-git-send-email-gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>
List-Id: alsa-devel@alsa-project.org

Used kmemdup instead of replicating it's behaviour with kmalloc followed
by memcpy.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 sound/oss/uart401.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/oss/uart401.c b/sound/oss/uart401.c
index 8e514a6..5433c6f 100644
--- a/sound/oss/uart401.c
+++ b/sound/oss/uart401.c
@@ -352,23 +352,26 @@ int probe_uart401(struct address_info *hw_config, struct module *owner)
 		goto cleanup_irq;
 	}
 	conf_printf(name, hw_config);
-	midi_devs[devc->my_dev] = kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
+	midi_devs[devc->my_dev] = kmemdup(&uart401_operations,
+					  sizeof(struct midi_operations),
+					  GFP_KERNEL);
 	if (!midi_devs[devc->my_dev]) {
 		printk(KERN_ERR "uart401: Failed to allocate memory\n");
 		goto cleanup_unload_mididev;
 	}
-	memcpy(midi_devs[devc->my_dev], &uart401_operations, sizeof(struct midi_operations));
 
 	if (owner)
 		midi_devs[devc->my_dev]->owner = owner;
 	
 	midi_devs[devc->my_dev]->devc = devc;
-	midi_devs[devc->my_dev]->converter = kmalloc(sizeof(struct synth_operations), GFP_KERNEL);
+	midi_devs[devc->my_dev]->converter = kmemdup(&std_midi_synth,
+						     sizeof(struct synth_operations),
+						     GFP_KERNEL);
+
 	if (!midi_devs[devc->my_dev]->converter) {
 		printk(KERN_WARNING "uart401: Failed to allocate memory\n");
 		goto cleanup_midi_devs;
 	}
-	memcpy(midi_devs[devc->my_dev]->converter, &std_midi_synth, sizeof(struct synth_operations));
 	strcpy(midi_devs[devc->my_dev]->info.name, name);
 	midi_devs[devc->my_dev]->converter->id = "UART401";
 	midi_devs[devc->my_dev]->converter->midi_dev = devc->my_dev;
-- 
1.7.9.5
