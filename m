From: Jon Smirl <jonsmirl@gmail.com>
Subject: snd_pcm_drain() and O_NONBLOCK
Date: Sun, 16 Aug 2009 10:20:23 -0400
Message-ID: <9e4733910908160720ud493ad5xf2e659bc238e8d99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C34FA2435A
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 16:20:24 +0200 (CEST)
Received: by yxe6 with SMTP id 6so3045858yxe.16
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 07:20:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm trying to fix brutefir to properly drain the driver before exiting.

This sequence does not work on a running stream.  snd_pcm_nonblock()
removes the O_NONBLOCK flag from the file handle but the change does
not get copied to stream->f_flags. snd_pcm_drain() returns -EAGAIN
since the flags have not be copied.

	    snd_pcm_nonblock(handles[IO][n], 0);
	    snd_pcm_drain(handles[IO][n]);
	    snd_pcm_nonblock(handles[IO][n], SND_PCM_NONBLOCK);

static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
int state)
{
	printk("snd_pcm_pre_drain_init flags %x\n", substream->f_flags);
	if (substream->f_flags & O_NONBLOCK)
		return -EAGAIN;
	printk("snd_pcm_pre_drain_init 1\n");
	substream->runtime->trigger_master = substream;
	return 0;
}

Searching through the ALSA code the only way f_flags gets copied from
the file handle to the stream handle is via snd_pcm_prepare(). But I
can't do a snd_pcm_prepare() on a running stream. I can't find any way
to change the NONBLOCK status on a running stream.

I also tried implementing the wait for drain the the user app.
snd_pcm_drain() always returns -EAGAIN of O_NONBLOCK is set. It can't
be used to poll for the drain status.

So how do I wait for a stream to drain?

-- 
Jon Smirl
jonsmirl@gmail.com
