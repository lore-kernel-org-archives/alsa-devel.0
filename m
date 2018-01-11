From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] sound: Remove unused register_sound_midi()
	and co
Date: Thu, 11 Jan 2018 17:13:32 +0100
Message-ID: <20180111161333.13349-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EBBE266E6D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 17:13:35 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C5D98ADFB
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 16:13:34 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These helpers are no longer used after the removal of the legacy OSS
drivers.  Let's clean up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/sound.h |  2 --
 sound/sound_core.c    | 35 -----------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/sound.h b/include/linux/sound.h
index 3c6d393c7f29..ec85b7a1f8d1 100644
--- a/include/linux/sound.h
+++ b/include/linux/sound.h
@@ -12,11 +12,9 @@ struct device;
 extern int register_sound_special(const struct file_operations *fops, int unit);
 extern int register_sound_special_device(const struct file_operations *fops, int unit, struct device *dev);
 extern int register_sound_mixer(const struct file_operations *fops, int dev);
-extern int register_sound_midi(const struct file_operations *fops, int dev);
 extern int register_sound_dsp(const struct file_operations *fops, int dev);
 
 extern void unregister_sound_special(int unit);
 extern void unregister_sound_mixer(int unit);
-extern void unregister_sound_midi(int unit);
 extern void unregister_sound_dsp(int unit);
 #endif /* _LINUX_SOUND_H */
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 99b73c675743..8b026b66cf18 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -452,26 +452,6 @@ int register_sound_mixer(const struct file_operations *fops, int dev)
 
 EXPORT_SYMBOL(register_sound_mixer);
 
-/**
- *	register_sound_midi - register a midi device
- *	@fops: File operations for the driver
- *	@dev: Unit number to allocate
- *
- *	Allocate a midi device. Unit is the number of the midi device requested.
- *	Pass -1 to request the next free midi unit.
- *
- *	Return: On success, the allocated number is returned. On failure,
- *	a negative error code is returned.
- */
-
-int register_sound_midi(const struct file_operations *fops, int dev)
-{
-	return sound_insert_unit(&chains[2], fops, dev, 2, 130,
-				 "midi", S_IRUSR | S_IWUSR, NULL);
-}
-
-EXPORT_SYMBOL(register_sound_midi);
-
 /*
  *	DSP's are registered as a triple. Register only one and cheat
  *	in open - see below.
@@ -532,21 +512,6 @@ void unregister_sound_mixer(int unit)
 
 EXPORT_SYMBOL(unregister_sound_mixer);
 
-/**
- *	unregister_sound_midi - unregister a midi device
- *	@unit: unit number to allocate
- *
- *	Release a sound device that was allocated with register_sound_midi().
- *	The unit passed is the return value from the register function.
- */
-
-void unregister_sound_midi(int unit)
-{
-	sound_remove_unit(&chains[2], unit);
-}
-
-EXPORT_SYMBOL(unregister_sound_midi);
-
 /**
  *	unregister_sound_dsp - unregister a DSP device
  *	@unit: unit number to allocate
-- 
2.15.1
