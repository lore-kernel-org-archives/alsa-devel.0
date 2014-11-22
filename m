From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound: oss: uart401: remove unneeded NULL check
Date: Sat, 22 Nov 2014 21:29:01 +0300
Message-ID: <20141122182901.GA6994@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Himangi Saraogi <himangi774@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"devc" can't be NULL here so there is no need to check.  Also I removed
the "devc = NULL" assignment because devc is stored on stack so it's
a no-op.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/uart401.c b/sound/oss/uart401.c
index 279bc56..dae4d43 100644
--- a/sound/oss/uart401.c
+++ b/sound/oss/uart401.c
@@ -412,13 +412,10 @@ void unload_uart401(struct address_info *hw_config)
 
 	if (!devc->share_irq)
 		free_irq(devc->irq, devc);
-	if (devc)
-	{
-		kfree(midi_devs[devc->my_dev]->converter);
-		kfree(midi_devs[devc->my_dev]);
-		kfree(devc);
-		devc = NULL;
-	}
+	kfree(midi_devs[devc->my_dev]->converter);
+	kfree(midi_devs[devc->my_dev]);
+	kfree(devc);
+
 	/* This kills midi_devs[x] */
 	sound_unload_mididev(hw_config->slots[4]);
 }
