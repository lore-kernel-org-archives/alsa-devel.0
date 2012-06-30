From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Sat, 30 Jun 2012 12:54:25 +0100
Message-ID: <20120630115424.GX28922@opensource.wolfsonmicro.com>
References: <s5ha9zmw2cy.wl%tiwai@suse.de>
	<71354327.345161.1340985944186.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7760951562157396844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E8562433D
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 13:54:26 +0200 (CEST)
In-Reply-To: <71354327.345161.1340985944186.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7760951562157396844==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MA55IEjTDEadc2f"
Content-Disposition: inline


--8MA55IEjTDEadc2f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2012 at 06:05:44PM +0200, Beno=EEt Th=E9baudeau wrote:
> On Fri, Jun 29, 2012 at 05:43:09PM +0200, Takashi Iwai wrote:

> > That's a valid assumption.  Usually get and put callbacks must be
> > paired well.

> What is the point of having customizable get/put callbacks if
> dapm_set_path_status() ignores them and duplicates their core behavior?

Nobody needed to do that yet.

> In the aic3x example, the bit-field is actually a mixer volume control, a=
nd not
> only a boolean, so I was planning to post a fix for that. The issue is th=
at the
> encoding of register values for this volume has holes that should not be
> duplicated in userspace raw values, so custom get and put callbacks have =
to be
> used here that will not be compatible with snd_soc_dapm_get_volsw(), whic=
h will
> be blocking for dapm_set_path_status(). Do you have a simple solution for=
 that?

Clearly the driver is just buggy and should implement get for itself
too.  As far as reading back the path status is concerned so long as
the mapping looks OK as a boolean we're fine, it doesn't matter what the
individual volumes are as all the code is interested in is on/off.

> In the meantime, please find below a quick patch for the consistency issu=
e.

Stop doing this, send patches for review rather than burying them in the
middle of e-mails where they're at best a pain to apply.

--8MA55IEjTDEadc2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7ujpAAoJEBus8iNuMP3dyHgP/2+cUBveOvmW8qxm4DtOAZER
FfD/xk3MZ1le6ImSxXnfIT71DVhaXCiiKc/7GJ2GoU9b5PDI/J0ejx/txC58eknr
qhcWM/VGFJj3icOzlB16o8eVsjyJvuBcTSPv/T6qw8V2aKdLZ5lq56qsJx8k5MTu
MJ1HDfbyI4YqhfUCTLjUUUXjqyFxSlZvdf9XULfZ8kwpGcVDhkmjHWRA20+jlcG0
i7RN1iBZ2/84wqTX8fB1dLLYfgSgVYOobE37qLM87lIcXeD/XUY76kgh3wDzq75F
8lOq3N4T1AxlEyCXxMIavbk5Mc1U/AU9j3lFci1ymh+/g2GhOkAIDpIxlcTvZ1AQ
AZ47k431NXEq3B9sxBYRtjupwbUNfpbsSQakHyG/MjE8Lj+HwHXgiP8/CqX+wug3
LBgW3l8zVWZplUpaa3N6sQ+X2GpndRm4BsNiAlO5eTfJrP6B5LZ8acjClKkHiNUX
xf5PR/qHHpB7OdJ7dtcTHxX0gAZs/h6BgbSzKLJ6ccxiTQRiv9IgO2iq0R+0Zz1B
idd5fVxkuoXzudnU4bZbRW2KdLqkzWbfEUCrjrfgLx/bbTZ4/TEI/YHOmzRZh91e
qt/FQMxni6Ln482qNbdQTEXm2c57e5XYQLIKIMFUTbuHXXVJWzs4vCB0yG0mXbbE
GDJjll8hiC6U1QDIKG7o
=8fQr
-----END PGP SIGNATURE-----

--8MA55IEjTDEadc2f--

--===============7760951562157396844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7760951562157396844==--
