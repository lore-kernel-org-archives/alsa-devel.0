From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] ASoC: QCOM: Add support for ipq806x SOC
Date: Thu, 20 Nov 2014 09:51:00 +0000
Message-ID: <20141120095100.GK22111@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <AE8D85F1-A1E0-4656-B160-37AA3300FE58@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n95ggtiZmkwHBchJ"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AE8D85F1-A1E0-4656-B160-37AA3300FE58@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--n95ggtiZmkwHBchJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2014 at 02:16:10PM -0600, Kumar Gala wrote:

Kumar, as I keep saying please fix your mailer to word wrap within
paragraphs.

> Some general comments, you shouldn=E2=80=99t have gerrit Change-Id=E2=80=
=99s in commit

Indeed.

> messages, the Kconfig/Makefile changes should be part of the patch
> that adds the code associated with them.

No, it's totally fine for a large new driver like this that's split over
many commits to add the Kconfig and Makefile at the end - there is no
value in trying to split them up.

--n95ggtiZmkwHBchJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbbmEAAoJECTWi3JdVIfQ3CEH/1kR10+Fa4Dg60qiSNAob4l1
S3YBWxzxLCdsXt0JFG/bi9LKiXMg3Z0SKpK3xHo1c8uMxzbdGfXffxUJ1yExAmpm
SMEyicRcJXrKzpuASaZOD9xnw1HzU/U18A6UJUKo5ewenxoxQJOB8KOudTBekegV
BYjDS+ks0gYlsoXCAthAOO0+C1sydR1RMELFsgWfse2YXCCA2HaIyr2oLMdrsYC9
bf7nWC816Q1z29gLsGolb59DXjF8hoDn0fS0twYV24ATEA4ta7TIs8/00NMvtbZP
SrTMzNby+XpbSkJgNbg7TpM1Uhvno0O4qS75yRJBq14XJVXdJ2xlnqCOVdJrwnI=
=WIMX
-----END PGP SIGNATURE-----

--n95ggtiZmkwHBchJ--
