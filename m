From: Stas Sergeev <stsp@aknet.ru>
Subject: snd_pcsp locking mess
Date: Sun, 18 May 2008 22:20:43 +0400
Message-ID: <4830737B.70108@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id EA48224369
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 20:20:54 +0200 (CEST)
In-Reply-To: <20080518172258.D0DFB108060@picon.linux-foundation.org>
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

bugme-daemon@bugzilla.kernel.org wrote:
> ------- Comment #17 from tiwai@suse.de  2008-05-18 10:22 -------
> Anyway, what I meant is that the part touching I/O ports could be a faster path
> than softirq.  And the hrtimer code can use a bit simpler locks.  The hrtimer
> callback needs just one thing about DMA buffer - the buffer is allocated and
> the address doesn't change during the callback.  So, we'd need the lock for the
> hr callback and for the PCM prepare, hwparams and free callbacks, i.e. to
> assure that the hrtimer callback is finished when these PCM callbacks may
> change the DMA buffer.  Thus this lock doesn't have to be PCM substream lock.
I wonder if it would be better to introduce
such a lock in an alsa core rather than in a
driver. The same way as snd_pcm_stream_lock().

> The current lock mess may come from the PCM trigger (STOP) called from
> snd_pcm_period_elapsed().  So, putting snd_pcm_period_elapsed() out of hrtimer
> lock is anyway necessary.  A tasklet for snd_pcm_period_elapsed() is needed for
> this reason, too.
Wouldn't it be better to just make
snd_pcm_period_elapsed() to not take
the stream lock? There is a requirement
right now to drop the stream lock before
calling this. I still beleive this is
the root of all the headache. If you
need to drop it, then you either accept
the race or need a second lock, and the
troubles ensue.
