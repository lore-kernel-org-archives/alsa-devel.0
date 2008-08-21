From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Thu, 21 Aug 2008 14:25:36 +0400
Message-ID: <48AD42A0.9030509@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>	<s5h4p8jbvaj.wl%tiwai@suse.de>	<48AD21EF.8010906@aknet.ru>
	<s5hej4ibuus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040008090209000004020905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 83DB8244B3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 12:24:21 +0200 (CEST)
In-Reply-To: <s5hej4ibuus.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040008090209000004020905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

Takashi Iwai wrote:
> I don't remember exactly, but adding a new callback doesn't sound so
> perfect.  Well, it's just one pointer, but it's added all over
> places.
Well, it can be a concern only as long
as the callback is entirely useless. :)
If it does the right thing, then it
certainly worth a pointer.

> Anyway, could you repost it?  Then we can discuss about it more
> concretely.
Attached, and the entire message is at
the bottom.

> A known problem with PCM substream lock is that it's to be used for
> multiple bound streams as well.  My concern is whether this can be
> still avoided well by your changes.
That's why I haven't made the patch
for the PCM locking change. Someone
else should know better how to make
it the safe way.

Below is an old message with the patch.
---
Hi.

I was trying to get the locking right
in my pcsp driver, and I have the following
problem.
I am using the chip->playback_substream in
the IRQ handler context. To prevent the chance
of closing the substream on another CPU while
the IRQ handler still messes with it, I
decided to protect it with the spinlock.
So I acquire the same lock both in an IRQ
handler and in the pcsp_stop_playing() routine.
That way I can be sure they never step on
each other's feet, even on SMP.
The problem is though that ALSA calls the
trigger() function to stop the playback both
within the task context and within the IRQ
context (later is via snd_pcm_period_elapsed(),
which is called from an IRQ context).
So the above locking scheme does not work,
because trigger() being called from an IRQ
context, takes the already taken lock.
I can drop the lock before calling snd_pcm_period_elapsed(),
but I beleive this opens a (very small) race
condition.
What can be a solution to this problem?
I think it is never too good to call the same
callbacks from both the task and IRQ contexts,
but the ALSA does this. In other words, can
something like the attached patch ever be applied,
or am I misunderstanding the problem completely?
The patch adds the separate callback, which is
intended to be called from an IRQ context only.
Does this look like the right solution?
---


--------------040008090209000004020905
Content-Type: text/x-patch;
 name="as_stop.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as_stop.diff"

--- linux-2.6.21/sound/core/pcm_native.c.old	2007-05-12 11:30:06.000000000 +0400
+++ linux-2.6.21/sound/core/pcm_native.c	2007-05-20 01:22:45.000000000 +0400
@@ -922,8 +922,14 @@
 static int snd_pcm_do_stop(struct snd_pcm_substream *substream, int state)
 {
 	if (substream->runtime->trigger_master == substream &&
-	    snd_pcm_running(substream))
-		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
+	    snd_pcm_running(substream)) {
+		if (substream->ops->async_stop)
+			/* the driver provides a separate callback
+			 * for the IRQ context */
+			substream->ops->async_stop(substream);
+		else
+			substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
+	}
 	return 0; /* unconditonally stop all substreams */
 }
 
--- linux-2.6.21/include/sound/pcm.h.old	2007-05-12 11:30:01.000000000 +0400
+++ linux-2.6.21/include/sound/pcm.h	2007-05-20 01:21:29.000000000 +0400
@@ -68,6 +68,7 @@
 	int (*hw_free)(struct snd_pcm_substream *substream);
 	int (*prepare)(struct snd_pcm_substream *substream);
 	int (*trigger)(struct snd_pcm_substream *substream, int cmd);
+	int (*async_stop)(struct snd_pcm_substream *substream);
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    snd_pcm_uframes_t pos,


--------------040008090209000004020905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040008090209000004020905--
