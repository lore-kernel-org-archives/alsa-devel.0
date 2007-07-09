From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  M-Audio Audiophile USB,
	native little endian (S16_LE) ?
Date: Mon, 9 Jul 2007 10:12:38 +0200
Message-ID: <000201c7c200$ed5026b0$161ce4a0@supelec.fr>
References: <20070708133618.62C75583E9@ip2-138.brfsodrahamn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D0B91037FA
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 10:12:48 +0200 (CEST)
In-Reply-To: <20070708133618.62C75583E9@ip2-138.brfsodrahamn.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Hakan Lennestal' <Hakan.Lennestal@brfsodrahamn.se>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org



> -----Message d'origine-----
> De : alsa-devel-bounces@alsa-project.org =

> [mailto:alsa-devel-bounces@alsa-project.org] De la part de =

> Hakan Lennestal
> Envoy=E9 : dimanche 8 juillet 2007 15:36
> =C0 : alsa-devel@alsa-project.org
> Cc : tiwai@suse.de
> Objet : [alsa-devel] M-Audio Audiophile USB, native little =

> endian (S16_LE) ?
> =

> =

> =

> Hi all !
> =

> I don't know if this is already known (?), but the M-Audio =

> Audiophile USB seem to be possible to run in native S16_LE =

> mode if initialized with device_setup=3D0x01 (possibly with =

> 0x11 also, have not tested that).

No I wasn't aware of this !
How did you figure this out ?

When you say 'it is possible' to run it in S16_LE do you mean it both
recognizes S16_BE and S16_LE or only S16_LE ?

Mine works with S16_BE but I must admit I haven't tested with S16_LE.

Regards,
Thibault
