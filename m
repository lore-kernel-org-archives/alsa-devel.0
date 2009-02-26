From: Tim Blechmann <tim@klingt.org>
Subject: Re: pointer callback question
Date: Thu, 26 Feb 2009 15:44:13 +0100
Message-ID: <49A6AABD.7040300@klingt.org>
References: <49946175.5070008@klingt.org>
	<s5h1vu3k0bj.wl%tiwai@suse.de>	<499462A5.2000705@klingt.org>
	<s5hy6wbillh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4393899422349175331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 900961038FC
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2009 15:44:16 +0100 (CET)
In-Reply-To: <s5hy6wbillh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4393899422349175331==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig58789A8A4B0C17831B00B1DB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58789A8A4B0C17831B00B1DB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hello takashi,

>>>> the brief log is (4 periods of 64 frames):
>>>> stream_pointer at 64
>>>> stream_pointer at 128
>>>> stream_pointer at 192
>>>> stream_pointer at 256
>>> This is invalid.  The pointer callback must return 0 in this case.
>>> The value the pointer callback returns is between 0 and buffer_size-1=
=2E
>> sry, typo, 5 periods of 64 frames
>=20
> Then it must be OK.  If the stream is stopped, it's likely by the
> buffer underrun detection or so...
>=20
> BTW, you should be sure that the buffer size is aligned to the period=20
> size if such a design is assumed.  Without the extra constraint, it
> could be unaligned as default.

now i am trying to debug it some more. the lx6464es card provides
commands to send audio buffers to the card, and issues an interrupt,
when the buffer has been processed. i am using one dma buffer of
period_bytes*periods (128 frames, 3 bytes per sample, 64 channels, 5
periods)

for the startup, i am sending a number of buffers to the card (periods):
[ 2825.545296] LX6464ES: starting: buffer index 0 on ef620000 (24576 byte=
s)
[ 2825.545385] LX6464ES: starting: buffer index 1 on ef626000 (24576 byte=
s)
[ 2825.545474] LX6464ES: starting: buffer index 2 on ef62c000 (24576 byte=
s)
[ 2825.545568] LX6464ES: starting: buffer index 3 on ef632000 (24576 byte=
s)
[ 2825.545662] LX6464ES: starting: buffer index 4 on ef638000 (24576 byte=
s)

for each buffer, the card issues an `end of buffer' interrupt, in which
i send a new buffer to the card and call snd_pcm_period_elapsed with an
updated hw pointer:
[ 2825.548340] LX6464ES: interrupt: gave buffer index 0 on ef620000
(24576 bytes)
[ 2825.548385] LX6464ES: stream_pointer at 128
[ 2825.550986] LX6464ES: interrupt: gave buffer index 1 on ef626000
(24576 bytes)
[ 2825.551029] LX6464ES: stream_pointer at 256
[ 2825.553653] LX6464ES: interrupt: gave buffer index 2 on ef62c000
(24576 bytes)
[ 2825.553695] LX6464ES: stream_pointer at 384
[ 2825.556353] LX6464ES: interrupt: gave buffer index 3 on ef632000
(24576 bytes)
[ 2825.556397] LX6464ES: stream_pointer at 512
[ 2825.559014] LX6464ES: interrupt: gave buffer index 4 on ef638000
(24576 bytes)
[ 2825.559061] LX6464ES: stream_pointer at 0

directly after returning 0 from the pointer callback, alsa requests a sto=
p:
[ 2825.559067] ->lx_pcm_trigger
the timing seems to be fine (2.7 ms for 128 frames).

any idea, why alsa wants to stop the transfer? am i missing something,
like to i need to inform alsa, that the cyclic buffer wraps around?

the code is available at [1]

thanks, tim

[1]
http://tim.klingt.org/git?p=3Ddigigram.git;a=3Dshortlog;h=3Drefs/heads/di=
gigram

--=20
tim@klingt.org
http://tim.klingt.org

Relying on the government to protect your privacy is like asking a
peeping tom to install your window blinds.
  John Perry Barlow


--------------enig58789A8A4B0C17831B00B1DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmmqsIACgkQdL+4qsZfVssbaACgozqIZwQENzB0J62Y6cju+QJM
1IIAnAvhj986Tthdh0m1aCS5Et/sQ6dA
=7myg
-----END PGP SIGNATURE-----

--------------enig58789A8A4B0C17831B00B1DB--

--===============4393899422349175331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4393899422349175331==--
