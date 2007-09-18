From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 15:57:41 +0200
Message-ID: <46EFD955.1000601@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>
	<s5habrkchpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050308040103030409040902"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CA6EC244E8
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:58:40 +0200 (CEST)
In-Reply-To: <s5habrkchpa.wl%tiwai@suse.de>
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050308040103030409040902
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 01:54 PM, Takashi Iwai wrote:

> Let's leave seq_instr as is.  It's a never-working concept.  The only
> user is OPL3, and this should be rewritten using hwdep.  Then we'll
> get rid of this whole code chunk.

Well, if you insist, but thought I'd submit is seperately once again. The 
schedule_timeout() calls in there are so-so, will simply not schedule, but that

	while (instr->use)
		schedule_timeout(1);

loop is dangerous. There's nothing that I can see that's stopping the 
compiler from turning this into an infinite loop:

	if (instr->use)
		while (1)
			schedule_timeout(1);

I'll admit I have no idea where this code ends up, but if it's _ever_ used 
this seems to not be good.

Ofcourse, feel free to drop on the floor if you really do insist.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

--------------050308040103030409040902
Content-Type: text/plain;
 name="schedule_timeout-seq_instr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-seq_instr.diff"

diff -r 0028e39ead78 core/seq/seq_instr.c
--- a/core/seq/seq_instr.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/core/seq/seq_instr.c	Tue Sep 18 14:49:04 2007 +0200
@@ -109,7 +109,7 @@ void snd_seq_instr_list_free(struct snd_
 			spin_lock_irqsave(&list->lock, flags);
 			while (instr->use) {
 				spin_unlock_irqrestore(&list->lock, flags);
-				schedule_timeout(1);
+				schedule_timeout_uninterruptible(1);
 				spin_lock_irqsave(&list->lock, flags);
 			}				
 			spin_unlock_irqrestore(&list->lock, flags);
@@ -198,8 +198,10 @@ int snd_seq_instr_list_free_cond(struct 
 		while (flist) {
 			instr = flist;
 			flist = instr->next;
-			while (instr->use)
-				schedule_timeout(1);
+			while (instr->use) {
+				schedule_timeout_uninterruptible(1);
+				barrier();
+			}
 			if (snd_seq_instr_free(instr, atomic)<0)
 				snd_printk(KERN_WARNING "instrument free problem\n");
 			instr = next;
@@ -555,7 +557,7 @@ static int instr_free(struct snd_seq_kin
 					   SNDRV_SEQ_INSTR_NOTIFY_REMOVE);
 		while (instr->use) {
 			spin_unlock_irqrestore(&list->lock, flags);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 			spin_lock_irqsave(&list->lock, flags);
 		}				
 		spin_unlock_irqrestore(&list->lock, flags);

--------------050308040103030409040902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050308040103030409040902--
