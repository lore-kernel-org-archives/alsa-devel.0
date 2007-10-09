From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] [RFC] sis7019: Initial support
	for	the	SiS7019 Audio Accelerator
Date: Tue, 09 Oct 2007 12:46:17 -0400
Message-ID: <1191948377.27906.46.camel@obelisk.thedillows.org>
References: <11915588983461-git-send-email-dave@thedillows.org>
	<s5hzlysty91.wl%tiwai@suse.de>
	<1191939558.27906.38.camel@obelisk.thedillows.org>
	<Pine.LNX.4.58.0710090745180.7644@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id C00F424715
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 18:46:25 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0710090745180.7644@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-10-09 at 07:59 -0700, Trent Piepho wrote:
> On Tue, 9 Oct 2007, Dave Dillow wrote:
> > It looks like my prepare() gets called by snd_pcm_action_nonatomic() in
> > sound/core/pcm_native.c, and that takes a read lock on the link
> > semaphore, so the group won't be changed, but I don't see anything that
> > would prevent prepare() being called twice on the same substream
> > concurrently. So, I'll probably need to keep some locking to avoid an
> > issue there, unless I'm missing a lock upstream.
> 
> You're right about that, prepare() can be called concurrently on the same
> substream, as can all the non-atomic functions like hw_params().  To be
> sure, I wrote a multi-threaded test program to execute concurrent ioctls.
> 
> There is a per-device mutex for open/close, so they can't run concurrently.
> 
> Note that the ALSA code does *not* handle concurrent calls to hw_params()
> or prepare() correctly.  Your driver may have a lock, but the alsa core
> doesn't, and will read and write to the runtime parameters concurrently.
> See http://article.gmane.org/gmane.linux.alsa.devel/48846

Good deal, so I'm not crazy. And to implement some sanity checking, I'll
need to copy all the data I need out of the runtime with some memory
barriers (or use the ones implicit in spin_locks) and then sanity check
that, as otherwise there's no guarantee that hw_parms() won't be
changing them while I'm looking at them....

At this point, I may just punt on the locking in prepare(), since we're
all a bit screwed here, and once the driver gets merged look at fixing
the locks upstream to close the issue.
