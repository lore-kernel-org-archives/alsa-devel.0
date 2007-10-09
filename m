From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] [RFC] sis7019: Initial support for	the
 SiS7019 Audio Accelerator
Date: Tue, 9 Oct 2007 07:59:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710090745180.7644@shell4.speakeasy.net>
References: <11915588983461-git-send-email-dave@thedillows.org>
	<s5hzlysty91.wl%tiwai@suse.de>
	<1191939558.27906.38.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 605D9246ED
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 16:59:31 +0200 (CEST)
In-Reply-To: <1191939558.27906.38.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Dillow <dave@thedillows.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Oct 2007, Dave Dillow wrote:
> On Tue, 2007-10-09 at 11:48 +0200, Takashi Iwai wrote:
> > You need to unlock sis->hw_lock before calling
> > snd_pcm_period_elapsed().  It may call snd_pcm_stop() at XRUN, and
> > this invokes the trigger callback, which locks hw_lock again.
> > Simply re-acquire hw_lock after calling snd_pcm_period_elapsed().
>
> If I'm guaranteed that I'll never have my prepare() method called
> concurrently for the same substream, I think I can do away with the
> hw_lock completely -- though I need to think through scenarios about
> closing the stream and a late interrupt...
>
> It looks like my prepare() gets called by snd_pcm_action_nonatomic() in
> sound/core/pcm_native.c, and that takes a read lock on the link
> semaphore, so the group won't be changed, but I don't see anything that
> would prevent prepare() being called twice on the same substream
> concurrently. So, I'll probably need to keep some locking to avoid an
> issue there, unless I'm missing a lock upstream.

You're right about that, prepare() can be called concurrently on the same
substream, as can all the non-atomic functions like hw_params().  To be
sure, I wrote a multi-threaded test program to execute concurrent ioctls.

There is a per-device mutex for open/close, so they can't run concurrently.

Note that the ALSA code does *not* handle concurrent calls to hw_params()
or prepare() correctly.  Your driver may have a lock, but the alsa core
doesn't, and will read and write to the runtime parameters concurrently.
See http://article.gmane.org/gmane.linux.alsa.devel/48846
