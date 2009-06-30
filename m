From: =?ISO-8859-1?Q?Juan_Jes=FAs_Garc=EDa_de_Soria_Lucena?=
	<skandalfo@gmail.com>
Subject: Re: [PATCH] Line In for Acer Inspire 6530G model
Date: Tue, 30 Jun 2009 21:56:34 +0200
Message-ID: <b0bb99640906301256g64ee3aa1yc66364d3800c934a@mail.gmail.com>
References: <20090626082750.6D1B210092@gold.linx.net>
	<s5hzlbrv76f.wl%tiwai@suse.de>
	<d54969c50906292054j77aa8dd5ha0e2954b1e793f38@mail.gmail.com>
	<b0bb99640906292307o13c2d842nbf3a078590cee911@mail.gmail.com>
	<s5h8wjai600.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CC7210386B
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 21:56:35 +0200 (CEST)
Received: by ey-out-2122.google.com with SMTP id 22so105248eye.47
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 12:56:34 -0700 (PDT)
In-Reply-To: <s5h8wjai600.wl%tiwai@suse.de>
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
Cc: Tony Vroon <tony@linx.net>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

Wow!

El 30 de junio de 2009 08:35, Takashi Iwai<tiwai@suse.de> escribi=F3:
> The alsa-driver snapshot tarball can be found at
>  ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-=
snapshot.tar.gz

I installed the snapshot, rebooted, plugged in both a CD player into
the line in and an external mic, launched

   (arecord | aplay) &

and then started playing with the alsamixer controls.

I can confirm that pluggin in headphones mute all the speakers. Also
the LFE level controls the bass speaker correctly.

I played with the "Capture" / "Input Source" pair of controls, and can
confirm that "Internal Mic", "External Mic" and "Line In" work ok. I'm
not sure about how to test the "CD" and "Input Mix" options.

I couldn't do anything about "Capture 1" / "Input Source 1". Has it
anything to do with the second capture device I get from arecord -l?


skandalfo@rimmer:~$ arecord -l
**** Lista de CAPTURE Dispositivos Hardware ****
tarjeta 0: SB [HDA ATI SB], dispositivo 0: ALC888 Analog [ALC888 Analog]
  Subdispositivos: 1/1
  Subdispositivo #0: subdevice #0
tarjeta 0: SB [HDA ATI SB], dispositivo 2: ALC888 Analog [ALC888 Analog]
  Subdispositivos: 1/1
  Subdispositivo #0: subdevice #0


I tried to perform the same tests with arecord -Dhw:0,2 but it
complained about no appropriate sample format, so I suppose I was
trying something stupid.


In any case, congratulations, and lots of thanks for your good work.
My laptop now sounds much better :-D


Best regards,

   Juan Jesus.


-- =

Dream small if success is enough for you; dream big if you need to
change the world.
