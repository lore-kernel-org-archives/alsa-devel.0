From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why my linux OS has only 8 sound cards ? How can I
 modify it ?
Date: Tue, 08 Nov 2011 18:37:53 +0100
Message-ID: <4EB968F1.2000100@ladisch.de>
References: <8c87f06b-dbfc-4035-8e5b-044e598939ae@i13g2000prg.googlegroups.com>	<CA+55aFwtfDu5PdBSAazMSPrni=Pv9cpE110=tfKXM8rCa4H6Kw@mail.gmail.com>
	<s5hsjlyehe9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B4495243C8
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 18:37:08 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2B4EC2127B
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 12:37:05 -0500 (EST)
In-Reply-To: <s5hsjlyehe9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, Chris Shen <chris2shen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Linus Torvalds wrote:
> > Takashi, any idea? Do we have some 8-sound-card limit somewhere?
> > 
> > I do see that we have that odd
> > 
> >         if (card && card->number >= 8)
> >                 return 0; /* ignore silently */
> > 
> > in sound/core/sound_oss.c: snd_register_oss_device(), but it has no
> > comments. The thing goes back to 2005 with the commit log entry of
> > "[ALSA] dynamic minors (6/6): increase maximum number of sound cards",
> > but the value '8'isn't explained.
> 
> ALSA itself can support 32 cards when CONFIG_SND_DYNAMIC_MINORS is
> set ...
> The above code is, however, about OSS-emulation.  And I guess it's
> just a left-over of the old static limitation.

Yes; I didn't change the limit in the OSS emulation because the minor
number layout doesn't have space for all 32 cards, and extending the
limit to 16 did not seem worth the effort for a 'legacy' interface.

> Actually OSS could support up to 16 cards (in theory).
> 
> Below is an untested fix patch.  Does it work?

Not without increasing SNDRV_OSS_MINORS, too:


diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 0c164e5..d6dbe46 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -34,7 +34,7 @@
 #include <linux/sound.h>
 #include <linux/mutex.h>

-#define SNDRV_OSS_MINORS 128
+#define SNDRV_OSS_MINORS 256

 static struct snd_minor *snd_oss_minors[SNDRV_OSS_MINORS];
 static DEFINE_MUTEX(sound_oss_mutex);
