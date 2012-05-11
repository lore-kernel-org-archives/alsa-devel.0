From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Getting alsa on Caanoo
Date: Fri, 11 May 2012 11:29:39 +0200
Message-ID: <4FACDC03.2050105@ladisch.de>
References: <CAEQ8eXOzGoF55nwa0W=GvSwf63tZ1jkp0sQDXMP-0Of=frWKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8ACB910BB5D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 11:25:45 +0200 (CEST)
In-Reply-To: <CAEQ8eXOzGoF55nwa0W=GvSwf63tZ1jkp0sQDXMP-0Of=frWKeg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Marc Nostromo [M-.-n]" <marc.nostromo@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Marc Nostromo [M-.-n] wrote:
> # cat /proc/asound/*
> 0 [nanoKONTROL    ]: USB-Audio =96 nanoKONTROL
>
> So I'm thinking I'm on the right track.
>
> But I don't see anything in /dev to connect to so I can't really do
> anything with my device.

ALSA devices are in /dev/sound/.

> From what I read here
>
> http://www.gp32x.com/board/index.php?/topic/60064-usbrs232-device-with-th=
e-caanoo/page__p__954641&#entry954641
>
> it could be due to the fact /dev is mounted in read-only (and that there's
> no /dev/midiXX present) and that I need to create the device file with
> mknod.

The alsa-driver package has the snddevices script, but it works only if
the kernel was compiled without CONFIG_SND_DYNAMIC_MINORS.

> However I'm not sure of what I should do in the specific context of
> midi/audio with alsa. Right now all I'm looking for is raw midi & pcm out.

aplay something.wav
aplaymidi something.mid


Regards,
Clemens
