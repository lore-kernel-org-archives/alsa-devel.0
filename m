From: "Brad Bosch" <bradbosch@comcast.net>
Subject: [PATCH] possible race with /proc/asound symlinks in
	core/info.c
Date: Tue, 24 Feb 2009 10:50:35 -0600
Message-ID: <18852.9563.644447.714536@waldo.imnotcreative.homeip.net>
References: <18848.12802.583166.745498@waldo.imnotcreative.homeip.net>
	<s5hmycd4ojx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA05.emeryville.ca.mail.comcast.net
	(qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 77F2310385A
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 17:50:53 +0100 (CET)
In-Reply-To: <s5hmycd4ojx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Brad Bosch <bradbosch@comcast.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai writes:
 > Thanks for the patch!  I'm very interested in whether the problem
 > happens with the very same scenario in the latest driver code.
 > There are still a few (but rare) bug reports, supposedly happening
 > with the same use-case.  But, the disconnection code was largely
 > changed since 2.6.5, it's not clear at all whether it's the same
 > cause or not.

If the oops stack trace for these bug reports looks something like
this, I'd guess there may still be a race which allows this bug:

Unable to handle kernel NULL pointer dereference at virtual address 0000004c    
 printing eip:                                                                  
02166027                                                                        
*pde = 00000000                                                                 
Oops: 0000 [#1]                                                                 
PREEMPT                                                                         
CPU:    0                                                                       
EIP:    0060:[<02166027>]    Tainted: P                                         
EFLAGS: 00010286   (2.6.5-1.358pt)                                              
EIP is at remove_proc_entry+0x34/0xe5                                           
eax: 00000000   ebx: 3f87bc94   ecx: ffffffff   edx: 0000004c                   
esi: 154fca64   edi: 0000004c   ebp: 41fa9ed8   esp: 41fa9ec8                   
ds: 007b   es: 007b   ss: 0068                                                  
Process events/0 (pid: 3, threadinfo=41fa9000 task=03f2eb50)                    
Stack: 0000004c 3f87bc94 154fca64 00000001 41fa9ef8 431c9b09 0000004c 37ddd8c0  
       431cece5 3f87bc94 0000004c 154fca64 41fa9f0c 431ca648 37ddd8c0 3f87bc94  
       154fca64 41fa9f40 431c8cad 154fca64 00000000 03f2eb50 02111205 00100100  
Call Trace:                                                                     
 [<431c9b09>] snd_remove_proc_entry+0x24/0x3c [snd]                             
 [<431ca648>] snd_info_card_free+0x7d/0xab [snd]                                
 [<431c8cad>] snd_card_free+0x17e/0x1f9 [snd]                                   


 > Well, the sound core checks the duplicated id string, so I'm wondering
 > where the same id string comes from.  Also, the recent kobject handler
 > checks the duplicated entry, and will spew the errors at
 > registration.

Then I wouldn't expect to see the oops above in the latest kernels
unless something else is deleting the symlink entries in /proc/asound
But as you point out below, this patch shouldn't cause any trouble and
I think it is an improvement anyway.

 > 
 > Yes, the fix sounds sane and likely applicable to the latest code.
 > At least it should be harmless...
 > 
 > > This patch won't apply directly to newer kernels because of minor
 > > changes, but it's trivial to apply by hand.  Let me know if you need
 > > me to re-base the patch.
 > 
 > Yes, please.  Then let's queue to the devel tree and see whether
 > any regression occurs actually :)

OK.  Here is the patch based on 2.6.28.7.  I've applied, built, and
tested it here and seen no ill effects.

Thanks!

--Brad

Signed-off-by: Bradley Bosch <bradbosch@comcast.net>

ChangeLog:
Avoid caching a pointer to struct proc_dir_entry for the card symbolic
links in /proc/asound and eliminate the proc_root_link member of
struct snd_card.  This avoids a potential oops should the link ever be
freed by another card.

--- sound/core/info.c~	2009-02-20 16:41:27.000000000 -0600
+++ sound/core/info.c	2009-02-23 18:09:44.000000000 -0600
@@ -648,7 +648,6 @@ int snd_info_card_register(struct snd_ca
 	p = proc_symlink(card->id, snd_proc_root, card->proc_root->name);
 	if (p == NULL)
 		return -ENOMEM;
-	card->proc_root_link = p;
 	return 0;
 }
 
@@ -661,10 +660,7 @@ void snd_info_card_disconnect(struct snd
 	if (!card)
 		return;
 	mutex_lock(&info_mutex);
-	if (card->proc_root_link) {
-		snd_remove_proc_entry(snd_proc_root, card->proc_root_link);
-		card->proc_root_link = NULL;
-	}
+	remove_proc_entry(card->id, snd_proc_root);
 	if (card->proc_root)
 		snd_info_disconnect(card->proc_root);
 	mutex_unlock(&info_mutex);
--- include/sound/core.h~	2009-02-20 16:41:27.000000000 -0600
+++ include/sound/core.h	2009-02-23 18:10:34.000000000 -0600
@@ -132,7 +132,6 @@ struct snd_card {
 
 	struct snd_info_entry *proc_root;	/* root for soundcard specific files */
 	struct snd_info_entry *proc_id;	/* the card id */
-	struct proc_dir_entry *proc_root_link;	/* number link to real id */
 
 	struct snd_monitor_file *files; /* all files associated to this card */
 	struct snd_shutdown_f_ops *s_f_ops; /* file operations in the shutdown
