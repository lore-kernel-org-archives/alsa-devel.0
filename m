From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] hda-intel: Add position_fix quirk for ASUS
 M2V-MX SE.
Date: Wed, 10 Mar 2010 13:14:05 +0100
Message-ID: <1268223246.3843.63.camel@mattotaupa>
References: <1265658166.3834.35.camel@mattotaupa>
	<s5h8wal4sgp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6066410236005007740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E740103849
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:14:10 +0100 (CET)
In-Reply-To: <s5h8wal4sgp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, stable@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6066410236005007740==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ccmUlEJKKg+aDuahkZtl"


--=-ccmUlEJKKg+aDuahkZtl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 22.02.2010, 08:53 +0100 schrieb Takashi Iwai:
> At Mon, 08 Feb 2010 20:42:46 +0100,
> Paul Menzel wrote:
> >=20
> > With PulseAudio and an application accessing an input device like `gnom=
e-volume-manager` both have high CPU load as reported in [1].
> >=20
> > Loading `snd-hda-intel` with `position_fix=3D1` fixes this issue. There=
fore add a quirk for ASUS M2V-MX SE.
> >=20
> > The only downside is, when now exiting for example MPlayer when it is p=
laying an audio file a high pitched sound is outputted by the speaker.
> >=20
> > $ lspci -vvnn | grep -A10 Audio
> > 20:01.0 Audio device [0403]: VIA Technologies, Inc. VT1708/A [Azalia HD=
AC] (VIA High Definition Audio Controller) [1106:3288] (rev 10)
> > 	Subsystem: ASUSTeK Computer Inc. Device [1043:8290]
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 17
> > 	Region 0: Memory at fbffc000 (64-bit, non-prefetchable) [size=3D16K]
> > 	Capabilities: <access denied>
> > 	Kernel driver in use: HDA Intel
> >=20
> > [1] http://sourceforge.net/mailarchive/forum.php?thread_name=3D12655506=
75.4642.24.camel%40mattotaupa&forum_name=3Dalsa-user
> >=20
> > Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
>=20
> Applied.  Thanks.

Unfortunately I have to report that I noticed that with this change
sometimes audio just fails the following way.

I play an audio file with MPlayer and suddenly at the beginning of a new
title instead of the normal audio only tones as played from a guitar are
played. I do not know how to better describe. Anyway quitting MPlayer
stops audio entirely, but starting to play audio files again still gives
the =E2=80=9Cguitar=E2=80=9D sounds. Playing a song with Totem works though=
 afterward
and then MPlayer works also again.

It just happens arbitrarily once a week and I cannot reproduce this.

I do not see anything in the logs, so I do not know if it is a
PulseAudio issue or something else. :(

Regarding ALSA I only see the following in `/var/log/messages`.

        hda-intel: IRQ timing workaround is activated for card #0. Suggest =
a bigger bdl_pos_adj.

I do not know how to best proceed. Maybe dequeue this patch?


Thanks,

Paul


[1] patch alsa-hda-intel-add-position_fix-quirk-for-asus-m2v-mx-se.patch ad=
ded to 2.6.33-stable tree
[2] patch alsa-hda-intel-add-position_fix-quirk-for-asus-m2v-mx-se.patch ad=
ded to 2.6.32-stable tree

--=-ccmUlEJKKg+aDuahkZtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuXjQ0ACgkQPX1aK2wOHVhN/wCcDO/M2qarogixKsKm+T9rez83
5G0An0q5h24vze6CYbrdKtWGCgIkdvtA
=9Px6
-----END PGP SIGNATURE-----

--=-ccmUlEJKKg+aDuahkZtl--


--===============6066410236005007740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6066410236005007740==--
