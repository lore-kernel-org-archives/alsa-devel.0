From: Joe Perches <joe@perches.com>
Subject: [PATCH 48/49] sound/oss/dev_table.c: Use vzalloc
Date: Thu,  4 Nov 2010 20:08:12 -0700
Message-ID: <a81978ec2765c2f5d90b736f3f691935e2afa17c.1288925425.git.joe@perches.com>
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1011031108260.11625@router.home>
In-Reply-To: <cover.1288925424.git.joe@perches.com>
References: <cover.1288925424.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/oss/dev_table.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/oss/dev_table.c b/sound/oss/dev_table.c
index 727bdb9..d8cf3e5 100644
--- a/sound/oss/dev_table.c
+++ b/sound/oss/dev_table.c
@@ -71,7 +71,7 @@ int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
 	if (sound_nblocks >= MAX_MEM_BLOCKS)
 		sound_nblocks = MAX_MEM_BLOCKS - 1;
 
-	op = (struct audio_operations *) (sound_mem_blocks[sound_nblocks] = vmalloc(sizeof(struct audio_operations)));
+	op = (struct audio_operations *) (sound_mem_blocks[sound_nblocks] = vzalloc(sizeof(struct audio_operations)));
 	sound_nblocks++;
 	if (sound_nblocks >= MAX_MEM_BLOCKS)
 		sound_nblocks = MAX_MEM_BLOCKS - 1;
@@ -81,7 +81,6 @@ int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
 		sound_unload_audiodev(num);
 		return -(ENOMEM);
 	}
-	memset((char *) op, 0, sizeof(struct audio_operations));
 	init_waitqueue_head(&op->in_sleeper);
 	init_waitqueue_head(&op->out_sleeper);	
 	init_waitqueue_head(&op->poll_sleeper);
@@ -128,7 +127,7 @@ int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
 	/* FIXME: This leaks a mixer_operations struct every time its called
 	   until you unload sound! */
 	   
-	op = (struct mixer_operations *) (sound_mem_blocks[sound_nblocks] = vmalloc(sizeof(struct mixer_operations)));
+	op = (struct mixer_operations *) (sound_mem_blocks[sound_nblocks] = vzalloc(sizeof(struct mixer_operations)));
 	sound_nblocks++;
 	if (sound_nblocks >= MAX_MEM_BLOCKS)
 		sound_nblocks = MAX_MEM_BLOCKS - 1;
@@ -137,7 +136,6 @@ int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
 		printk(KERN_ERR "Sound: Can't allocate mixer driver for (%s)\n", name);
 		return -ENOMEM;
 	}
-	memset((char *) op, 0, sizeof(struct mixer_operations));
 	memcpy((char *) op, (char *) driver, driver_size);
 
 	strlcpy(op->name, name, sizeof(op->name));
-- 
1.7.3.1.g432b3.dirty
