From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise using pulseaudio with ymf724f
Date: Wed, 14 Sep 2011 07:09:24 +0800
Message-ID: <CAN8ccibqYPovEn=M9b-x4ZjqM3U9DwKnJtyDUKGoos-C2WBVXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 00D752433E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 01:09:27 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1078288fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 16:09:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/12 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> How accurate is the ymfpci timer ?
>
> The period interrupts are not accurate at all. =A0The ymfpci hardware
> internally uses fixed periods of 256 frames at 48 kHz; the driver
> reports a period interrupt when the next hardware interrupt at or after
> a period boundary occurs. =A0The current position reported by the hardware
> is the position at the time of the last hardware interrupt.
>
>> my ymf724f seem play quite well with alsa "hw" device but with bad
>> noise with alsa-pulse plugin (e.g. aplay when not using default period
>> times ) =A0and it also occurrs on =A0 benshee on ubuntu 11.4 live cd
>
> It should be possible to increase accuracy by using the hardware period
> parameters (48 kHz _and_ 256 frames/period).
>
> TODO: implement support for the NORESAMPLE flag.
>
>

Is 256 frames/period in s16 stereo since the card support mono ,
stereo , U8 and S16 ,

What is the meaning of SNDRV_PCM_INFO_BLOCK_TRANSFER since the
rewind_safeguard of PA server is 256 bytes ?

Will this help since minimum period time of snd_ymfpci is 5.333ms but
alsa-pulse plugin announce a lower value 128 bytes (period_bytes_min)
to the alsa application ?

PA server has

#define ABSOLUTE_MIN_LATENCY (500)
#define ABSOLUTE_MAX_LATENCY (10*PA_USEC_PER_SEC)
