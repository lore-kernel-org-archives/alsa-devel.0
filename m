From: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Subject: Re: RE :  M-Audio Audiophile USB,
 native little endian  (S16_LE) ?
Date: Mon, 09 Jul 2007 12:39:35 +0200
Message-ID: <20070709103936.2540F5813E@ip2-138.brfsodrahamn.se>
References: <Thibault.LeMeur@supelec.fr>
Reply-To: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2-138.brfsodrahamn.se (ip2-138.brfsodrahamn.se
	[213.187.199.138])
	by alsa0.perex.cz (Postfix) with ESMTP id CB927103833
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 12:39:36 +0200 (CEST)
In-Reply-To: Message from "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
	of "Mon, 09 Jul 2007 10:12:38 +0200."
	<000201c7c200$ed5026b0$161ce4a0@supelec.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> > I don't know if this is already known (?), but the M-Audio =

> > Audiophile USB seem to be possible to run in native S16_LE =

> > mode if initialized with device_setup=3D0x01 (possibly with =

> > 0x11 also, have not tested that).
> =

> No I wasn't aware of this !
> How did you figure this out ?

When initialized with device_setup=3D0x01 my box only produces noise.
With 0x00 (or omitted) it works ok, except for spdif out sometimes
not being setup correctly (no signal detect by the amp it is connected to).
0x09 seem to work without problems. Have not tested any other combinations.

Using a setup with 0x01 and preparing a raw S16_LE file (with "mpg123 -s") =

and then playing with "aplay -D hw:2 -f S16_BE -r 44100 -c 2" produced good =

quality sound.
This made me suspect that the device really is operating in native S16_LE.
 =

> When you say 'it is possible' to run it in S16_LE do you mean it both
> recognizes S16_BE and S16_LE or only S16_LE ?

Sorry, a bit unclear. Only S16_LE.

> Mine works with S16_BE but I must admit I haven't tested with S16_LE.

Ok, this then seem to be something that has changed over time in the firmwa=
re =

(or hw) ?
The fw version of my box is 1.01.

Regards.

/H=E5kan
