From: Mario Contreras <kenpuudenkiberserk@gmail.com>
Subject: Fwd: Fwd: Fwd: Fwd: Fwd: Testers wanted: New SB X-Fi
	driver
Date: Mon, 25 May 2009 11:38:42 +0200
Message-ID: <71efeafc0905250238w380f59ck665df1570c31b4b2@mail.gmail.com>
References: <71efeafc0905250053x32b23773r104087c6f0ed3deb@mail.gmail.com>
	<71efeafc0905250107g668f155eu811b860d598be2c2@mail.gmail.com>
	<fd3eb9bf0905250110h7549ecc0s272483bb7fc5c29a@mail.gmail.com>
	<71efeafc0905250114k56b3051cxeb298e1f3af67699@mail.gmail.com>
	<s5htz39bnru.wl%tiwai@suse.de>
	<71efeafc0905250130v6f427a00pfa0d503c53909cb7@mail.gmail.com>
	<s5hprdxbmvd.wl%tiwai@suse.de>
	<71efeafc0905250144p5221b020h35ab4ee4a5243733@mail.gmail.com>
	<71efeafc0905250214v79a42395o93b65227d7f4f12b@mail.gmail.com>
	<s5hzld15xzy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FD60103846
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:38:43 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3139202fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 02:38:42 -0700 (PDT)
In-Reply-To: <s5hzld15xzy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I haven't understanded the last part. Anyway, it means this card is not
supported at the moment, right? Thanks.

---------- Forwarded message ----------
From: Takashi Iwai <tiwai@suse.de>
Date: 2009/5/25
Subject: Re: [alsa-devel] Fwd: Fwd: Fwd: Fwd: Testers wanted: New SB X-Fi
driver
To: Mario Contreras <kenpuudenkiberserk@gmail.com>
Cc: alsa-devel@alsa-project.org


At Mon, 25 May 2009 11:14:51 +0200,
Mario Contreras wrote:
>
> I have reinstalled only the alsa-driver and I've run aplay.
>
> With aplay -l I have this:
>
> **** Lista de PLAYBACK Dispositivos Hardware ****
> tarjeta 0: Intel [HDA Intel], dispositivo 0: ALC1200 Analog [ALC1200
Analog]
>   Subdispositivos: 1/1
>   Subdispositivo #0: subdevice #0
> tarjeta 1: HDMI [HDA ATI HDMI], dispositivo 3: ATI HDMI [ATI HDMI]
>   Subdispositivos: 1/1
>   Subdispositivo #0: subdevice #0
> tarjeta 2: Generic [HD-Audio Generic], dispositivo 0: CA0110 Analog
[CA0110
> Analog]
>   Subdispositivos: 1/1
>   Subdispositivo #0: subdevice #0
> tarjeta 2: Generic [HD-Audio Generic], dispositivo 1: CA0110 Digital
[CA0110
> Digital]
>   Subdispositivos: 1/1
>   Subdispositivo #0: subdevice #0
>
> Then, I executed aplay -D hw:2,0 foo.wav. And it returns this:
>
> Sonando WAVE 'foo.wav' : Signed 32 bit Little Endian, Ratio 44100 Hz,
> Est=E9reo
> aplay: pcm_write:1528: error de escritura: Error de entrada/salida
>
> If the language is a problem(sorry, I'm spanish), it means something like
> writting error: Input/output error. Thanks.

OK, thanks for testing.
It looks like a model that currently doesn't work by unknown reason.
IIRC, there was another case.


Takashi
