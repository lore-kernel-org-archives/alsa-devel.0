From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mm functions vs. normal IO
Date: Tue, 04 Mar 2008 08:58:47 +0100
Message-ID: <47CD0137.9000608@ladisch.de>
References: <47CC7E6D.4030704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1098C24334
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 08:57:13 +0100 (CET)
In-Reply-To: <47CC7E6D.4030704@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Reiner <reiner1210@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Reiner wrote:
> I was astonished that a simple wav playback example does not exist.

The alsa-lib package has test/pcm_min.c.

> What should be used:
>
> snd_pcm_mmap_commit
> (I think snd_pcm_mmap_writei is the same with an additional copy behind ?)

snd_pcm_mmap_writei is the same as calling snd_pcm_mmap_begin, copying
into the buffer, and calling snd_pcm_mmap_commit.

> or snd_pcm_writei

If you have to ask, use snd_pcm_writei.

> I think mmap will have better performance,

Only if the program generates samples on the fly and can write them
directly to the buffer in a format supported by the hardware.

If you already have the data in some buffer, copying it into the
device's buffer with snd_pcm_writei or snd_pcm_mmap_writei is just as
fast as when you copy it into the device's buffer by yourself.

> but will it work with all soundcards?

Not directly.  ALSA has mmap emulation for cards that don't support it.
And there are devices where only support mmap access is
SND_PCM_ACCESS_MMAP_COMPLEX.

> I'am also looking for a function to get the number of played frames.

ALSA doesn't count them.  This is nothing that a program couldn't do
trivially by itself.


HTH
Clemens
