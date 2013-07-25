From: Alexander Blinne <alexander.blinne@uni-jena.de>
Subject: Re: Decibel Levels for Storm Medusa 5.1 USB Headset
Date: Fri, 26 Jul 2013 00:01:14 +0200
Message-ID: <51F1A02A.4020907@uni-jena.de>
References: <51ED907A.1070305@uni-jena.de> <s5h61vzkp61.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4112752590025035354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout0.rz.uni-jena.de (mailout0.rz.uni-jena.de [141.35.1.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 352DB26109D
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 00:01:19 +0200 (CEST)
In-Reply-To: <s5h61vzkp61.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4112752590025035354==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F98lvpaDkXS1UPKQETw7VDwogWQBjkuqg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F98lvpaDkXS1UPKQETw7VDwogWQBjkuqg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

well I have to admit that those level were just a guess. I have now made
an accurate measurement of the real volume levels by playing back white
noise through the headset and recording with a microphone at the same
time, while increasing the hardware volume level with 'amixer'. Then i
have measured the volumes with audacity's contrast-analyzer and smoothed
the resulting curve by applying a nonlinear least squares fit with a
function a*log(x+d*x^2+e*x^3)+b+c*x, wich fits the data really well.

The resulting levels are:

0	invalid/unconclusive, sometimes mute, sometimes louder than 1. seems
not to be working correctly.

1	-24,91
2	-22,31
3	-20,10
4	-18,15
5	-16,46
6	-15,00
7	-13,73
8	-12,61
9	-11,62
10	-10,72
11	-9,91
12	-9,17
13	-8,49
14	-7,87
15	-7,28
16	-6,74
17	-6,23
18	-5,75
19	-5,30
20	-4,88
21	-4,48
22	-4,09
23	-3,73
24	-3,38
25	-3,05
26	-2,74
27	-2,44
28	-2,15
29	-1,87
30	-1,61
31	-1,35
32	-1,10
33	-0,87
34	-0,64
35	-0,42
36	-0,21
37	0,00


Alex



--F98lvpaDkXS1UPKQETw7VDwogWQBjkuqg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHxoC0ACgkQSpzrZw97cykFLACg7+MUl2o+vmFLL2UUa/giLGbh
JmUAn3UsB/Ng83JuSg3oGwCRXNPj5ha5
=1uIM
-----END PGP SIGNATURE-----

--F98lvpaDkXS1UPKQETw7VDwogWQBjkuqg--

--===============4112752590025035354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4112752590025035354==--
