From: Christopher Head <alsa@chead.ca>
Subject: Re: Incorrect name of PCM
Date: Mon, 23 Jul 2018 09:21:59 -0700
Message-ID: <56F88318-0461-4587-AE9D-A885BB121ADC@chead.ca>
References: <20180722083850.5283c197@amdahl.home.chead.ca>
 <s5h7elm1k39.wl-tiwai@suse.de>
 <3E9578B3-156B-40D9-BC11-F8D11B73E722@chead.ca>
 <s5hsh4a3p34.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3980705762622953552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lovelace.chead.ca (lovelace.chead.ca [162.223.226.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E59A2675FC
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 18:22:05 +0200 (CEST)
In-Reply-To: <s5hsh4a3p34.wl-tiwai@suse.de>
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

--===============3980705762622953552==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/signed; boundary="----ZRF10MRNN99DY6VTA9S7O4ZE2M8AO4";
  protocol="application/pgp-signature"; micalg="pgp-sha512"

------ZRF10MRNN99DY6VTA9S7O4ZE2M8AO4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
 charset=utf-8

On July 23, 2018 9:15:59 AM PDT, Takashi Iwai <tiwai@suse=2Ede> wrote:
>Just ignore this entry=2E  alsa-lib tries to parse the all possible
>outputs that are provided from the kernel interface=2E  Due to
>historical reasons, this digital output might be either SPDIF or HDMI,
>and alsa-lib has no knowledge to distinguish easily, hence both spdif
>and hdmi device names are provided equally for such a case=2E

Not here, they aren=E2=80=99t=2E There is no PCM named =E2=80=9Cspdif=E2=
=80=9D at all: it isn=E2=80=99t in the list, and if I type it, I can=E2=80=
=99t play to it for a reason that looks a lot like it doesn=E2=80=99t exist=
=2E

--=20
Christopher Head
------ZRF10MRNN99DY6VTA9S7O4ZE2M8AO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iIEEABYKACkiHENocmlzdG9waGVyIEhlYWQgPGNoZWFkQGNoZWFkLmNhPgUCW1YA
pwAKCRBlX9lfCltNgbxlAQDlvFBBuXyHnZF7C+kyRF3Ru1ViuJpFtDCkDEI2sIJ2
0QEAkUY4d1FE5787sq8U1JNPDdEH07enEqV6SqTXZGAbZw8=
=WvDw
-----END PGP SIGNATURE-----

------ZRF10MRNN99DY6VTA9S7O4ZE2M8AO4--

--===============3980705762622953552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3980705762622953552==--
