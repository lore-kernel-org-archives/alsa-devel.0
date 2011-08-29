From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: Have multiple opens removed on one device?
Date: Mon, 29 Aug 2011 18:11:15 +0800
Message-ID: <CAHG8p1B4b+F_Uoo8+QTn_g3XDF6AcW-WdfsyovsEupJLUZQxVw@mail.gmail.com>
References: <CAHG8p1BRN365PTyDxh-6UFWKtf_M-WcVZDGmuXB0W+CjTgPNGQ@mail.gmail.com>
	<s5hipppsqe9.wl%tiwai@suse.de>
	<20110822112143.GB9232@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id E395124634
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 12:11:16 +0200 (CEST)
Received: by qwf7 with SMTP id 7so3147400qwf.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 03:11:15 -0700 (PDT)
In-Reply-To: <20110822112143.GB9232@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/8/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Aug 22, 2011 at 12:15:58PM +0200, Takashi Iwai wrote:
>> Scott Jiang wrote:
>
>> > In kernel 2.6.34 I can use aplay to play audio at the same time, alsa
>> > will mix the audio.
>
>> No, kernel part doesn't do such a thing. =A0If it's mixed, it must be
>> in the user-space (either dmix or a daemon like pulseaudio), unless
>> you hardware can do mixing by itself.
>
> There *are* some cards (mostly older ones like emu10k) that support
> multiple streams transparently but this has never been supported in
> ASoC due a lack of hardware that can do it.
>

Hi Mark,

Indeed we use dmix. But now we can't open the same device twice.
Our alsa lib and utils version is 1.0.18.
The test command: aplay 1.wav &; aplay 1.wav
In 2.6.34, strace
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) =3D 4
open("/dev/snd/pcmC0D0p", O_RDWR|O_APPEND|O_NONBLOCK) =3D 4

In 3.0, strace
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) =3D 4
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) =3D -1 EBUSY (Device or
resource busy)

The O_APPEND flag missed in new kernel. But we use the same lib and
utils. It's strange.
And I found the prefer subdevice changes from 0 to -1. These two
changes cause kernel return device busy.

Mark, can you do this simple test on your board? I appreciate your
help. Thank you very much.

Regards,
Scott
