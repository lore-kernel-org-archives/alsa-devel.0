From: "Brad Bosch" <bradbosch@comcast.net>
Subject: Patch for possible race with /proc/asound symlinks in
	core/info.c
Date: Sat, 21 Feb 2009 10:55:30 -0600
Message-ID: <18848.12802.583166.745498@waldo.imnotcreative.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F7731037F7
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 17:56:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav,

I discovered and fixed an ALSA oops in a very old kernel (2.6.5) used
in an embedded application and looking at the latest kernels, it's not
clear to me that this was ever completely fixed in newer kernels.  I'm
sending this email so someone who understands the interactions between
the USB and ALSA subsystems better than I do can determine if a
similar fix might be required in the newer kernels.

In the old kernel, the oops often happens when a USB device is
unplugged and then a device with the same ID (or the same device) is
immediately plugged back in before the old device is completely
cleaned up.  The included patch resolves the problem in that kernel.

The problem was that two cards were creating symbolic links in
/proc/asound with the same name (id) but pointing to differen't cards.
The proc subsystem apparently allowed this.  Later, when one of the
entries is removed (using it's name), the wrong entry may be removed,
freeing the wrong struct proc_dir_entry and leaving a pointer to the
freed memory in the other card's proc_root_link member.  Later when
that USB device is unplugged and snd_info_card_disconnect() is called,
snd_remove_proc_entry() will reference the name member of struct
proc_dir_entry which by now may be changed, or even null.  It turns
out to be trivial to avoid this problem by simply not storing the
pointer to the proc_dir_entry as we don't need it anyway to determine
the name of the link to remove.  Instead, for the case of the symbolic
link, we call remove_proc_entry directly using the card id for the
link name (just as we did when it was created).

I don't know if two symbolic links are ever created in /proc/asound
with the same name in the newer kernels or newer ALSA code and in fact, I
haven't been able to reproduce the problem there.  However, since the
patch reduces both the data and code size, and eliminates a potential
crash, you may want to apply it anyway.

This patch won't apply directly to newer kernels because of minor
changes, but it's trivial to apply by hand.  Let me know if you need
me to re-base the patch.

--Brad

Index: sound/core/info.c
===================================================================
RCS file: /cvs/kernels/kernel_2_6_5/sound/core/info.c,v
retrieving revision 1.1.4.1.10.1
diff -u -r1.1.4.1.10.1 info.c
--- sound/core/info.c	22 Feb 2006 14:06:25 -0000	1.1.4.1.10.1
+++ sound/core/info.c	20 Feb 2009 02:05:01 -0000
@@ -618,7 +618,6 @@
 	p = proc_symlink(card->id, snd_proc_root, card->proc_root->name);
 	if (p == NULL)
 		return -ENOMEM;
-	card->proc_root_link = p;
 	return 0;
 }
 
@@ -629,10 +628,7 @@
 int snd_info_card_free(snd_card_t * card)
 {
 	snd_assert(card != NULL, return -ENXIO);
-	if (card->proc_root_link) {
-		snd_remove_proc_entry(snd_proc_root, card->proc_root_link);
-		card->proc_root_link = NULL;
-	}
+	remove_proc_entry(card->id, snd_proc_root);
 	if (card->proc_root) {
 		snd_info_unregister(card->proc_root);
 		card->proc_root = NULL;
Index: include/sound/core.h
===================================================================
RCS file: /cvs/kernels/kernel_2_6_5/include/sound/core.h,v
retrieving revision 1.1.4.1
diff -u -r1.1.4.1 core.h
--- include/sound/core.h	15 Apr 2005 21:45:13 -0000	1.1.4.1
+++ include/sound/core.h	20 Feb 2009 02:05:02 -0000
@@ -152,7 +152,6 @@
 
 	snd_info_entry_t *proc_root;	/* root for soundcard specific files */
 	snd_info_entry_t *proc_id;	/* the card id */
-	struct proc_dir_entry *proc_root_link;	/* number link to real id */
 
 	struct snd_monitor_file *files; /* all files associated to this card */
 	struct snd_shutdown_f_ops *s_f_ops; /* file operations in the shutdown state */
