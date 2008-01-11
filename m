From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ALSA : Can't open capture device
Date: Fri, 11 Jan 2008 14:26:42 +0100
Message-ID: <15264.6636510783$1200058039@news.gmane.org>
References: <000801c85440$8ec2f280$ac48d780$@bouin@kerlink.fr>
	<1200057414.30917.1230696923@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id D0E4C24502
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 14:26:43 +0100 (CET)
In-Reply-To: <1200057414.30917.1230696923@webmail.messagingengine.com>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

arecord answer me this : =

arecord -l
**** List of PLAYBACK Hardware Devices ****
card 0: codec [xxxxxxx audio codec], device 0: xxxxxx xxxxxx-I2S-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

After looking for traces in pcm.c and sound.c, I've found this : =

soc_new_pcm playback 1, capture 1
snd_pcm_dev_register str pcmC0D0p
snd_register_device_for_dev minor 16
snd_pcm_dev_register str pcmC0D0c
snd_register_device_for_dev minor 24
snd_register_device_for_dev minor 0

My pcmC0D0x minor devices were wrong :'( i've remade them and now it works.

Thanks a lot.

Regards,
Alex.

-----Message d'origine-----
De=A0: Clemens Ladisch [mailto:cladisch@fastmail.net] =

Envoy=E9=A0: vendredi 11 janvier 2008 14:17
=C0=A0: Alexandre BOUIN; alsa-devel@alsa-project.org
Objet=A0: Re: [alsa-devel] ALSA : Can't open capture device

Alexandre BOUIN wrote:
> I'm working on an intern project, using an AT91SAM9260EK-based board,
> embedded system.
> Our kernel contains a full ALSA 1.14 with ASoC layer.
> Our ASoC driver works well in capture and playback, if we are using OSS
> layer or directly /dev/dsp.
> So I need some tips on ALSA layer side :
> =

> here you can see that my device is created : =

> ll /dev/snd/
> crwxrwxrwx    1 root     root     116,   0 Dec 26  2007 controlC0
> crwxrwxrwx    1 root     root     116,   4 Dec 26  2007 hwC0D0
> crwxrwxrwx    1 root     root     116,  14 Dec 26  2007 pcmC0D0c
> crwxrwxrwx    1 root     root     116,  16 Dec 26  2007 pcmC0D0p
> ll /dev/dsp
> crwxrwxrwx    1 root     root      14,   3 Dec 26  2007 /dev/dsp
> =

> A cat on playback device works (I added some traces in kernel) : =

> cat < /dev/snd/pcmC0D0p
> snd_pcm_open : enter
> snd_pcm_open_file : before snd_pcm_open_substream
> snd_pcm_open_file : after snd_pcm_open_substream
> cat: read error: Invalid argument
> =

> But a cat on capture device does not work : =

> cat < /dev/snd/pcmC0D0c
> -sh: cannot open /dev/snd/pcmC0D0c: No such device

Does the capture device appear in /proc/asound/devices or in the output
of "arecord -l"?


Regards,
Clemens
