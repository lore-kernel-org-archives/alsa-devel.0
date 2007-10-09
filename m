From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] [RFC] sis7019: Initial support for
	the	SiS7019 Audio Accelerator
Date: Tue, 09 Oct 2007 10:19:18 -0400
Message-ID: <1191939558.27906.38.camel@obelisk.thedillows.org>
References: <11915588983461-git-send-email-dave@thedillows.org>
	<s5hzlysty91.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 0174F246DA
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 16:19:23 +0200 (CEST)
In-Reply-To: <s5hzlysty91.wl%tiwai@suse.de>
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

On Tue, 2007-10-09 at 11:48 +0200, Takashi Iwai wrote:
> You need to unlock sis->hw_lock before calling
> snd_pcm_period_elapsed().  It may call snd_pcm_stop() at XRUN, and
> this invokes the trigger callback, which locks hw_lock again.
> Simply re-acquire hw_lock after calling snd_pcm_period_elapsed().

If I'm guaranteed that I'll never have my prepare() method called
concurrently for the same substream, I think I can do away with the
hw_lock completely -- though I need to think through scenarios about
closing the stream and a late interrupt...

It looks like my prepare() gets called by snd_pcm_action_nonatomic() in
sound/core/pcm_native.c, and that takes a read lock on the link
semaphore, so the group won't be changed, but I don't see anything that
would prevent prepare() being called twice on the same substream
concurrently. So, I'll probably need to keep some locking to avoid an
issue there, unless I'm missing a lock upstream.

I'll have a look at removing locks from the interrupt handler
completely, though.

Thanks,
Dave
