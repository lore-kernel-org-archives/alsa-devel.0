From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Possible problem with snd_pcm_oss_sync()
Date: Wed, 21 May 2008 13:25:41 +0200
Message-ID: <483406B5.4010408@ladisch.de>
References: <4832F65E.5070008@freescale.com> <48331F26.4030104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 71A7E2450B
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 13:25:43 +0200 (CEST)
In-Reply-To: <48331F26.4030104@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> The customer is using an old application called "bplay" to test OSS audio
> support on our hardware.  The application works fine on x86, but fails on our
> PowerPC board.  It could be an endian issue, but I doubt it.

Is that a recent enough version of bplay, from Debian?  Older ones
didn't work on big-endian machines.

> #1) Stopped audio stream output after doing followings:
> 1. Opening /dev/mixer
> 2. Getting a channel value (0x00000001) that is used for "ioctl(fd,
> SOUND_MIXER_READ_DEVMASK, &Sndsts);".
> 3. Write audio volume information by "ioctl(fd,
> SOUND_MIXER_WRITE_VOLUME, &Value);",

I didn't find this in the bplay code.

If writing to a mixer control stops the audio stream, this may be a bug
in the driver (whatever driver this is).

> #2) Stopped audio stream output after doing following:
> 2. Executing command "ioctl(fd, SNDCTL_DSP_SYNC, NULL);",

This ioctl stops the output (after playing the remaining data in the
buffer).  The application can restart playing by writing more data.

> XXXX found that by commenting out the "sync_audio" function on the source
> code of "bplay" made "bplay" work. So XXXX suspects the implementation of the
> ioctl on the OSS emulation may have a problem.

bplay calls the SYNC ioctl before setting the sample format, but this is
not allowed: <http://manuals.opensound.com/developer/callorder.html>.

Removing that call to sync_audio() fixes the bug.  :-)

> snd_pcm_oss_sync() displays this message:
>
> sync: buffer_used
>
> What does this mean?

It means that the buffer contains some data which will be played before
the device is stopped and the ioctl returns.


HTH
Clemens
