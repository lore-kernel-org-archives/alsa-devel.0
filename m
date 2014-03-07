From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 7/7] ASoC: sirf: Add bt-sco card
Date: Fri, 7 Mar 2014 14:12:07 +0800
Message-ID: <20140307061207.GG13126@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-8-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920655712414396009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91A0326599B
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 07:23:02 +0100 (CET)
In-Reply-To: <1394008480-29135-8-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============1920655712414396009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THlL8lzu8dvjtcEp"
Content-Disposition: inline


--THlL8lzu8dvjtcEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2014 at 04:34:40PM +0800, RongJun Ying wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
>=20
> This connects platform DAI, USP(DSP mode) CPU DAI and
> bt-sco Codec DAI together and works as a mach driver.

Again, can this use simple-card and...

> +	fmt =3D card->dai_link[0].dai_fmt;
> +
> +	/* Set cpu DAI configuration */
> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);

=2E..this shouldn't be needed.

--THlL8lzu8dvjtcEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGWM0AAoJELSic+t+oim9BRcP/1/ChIuDkerCMvx0yL+1YrYE
HRCVz9fTA5lQ/1Fr9IS24C7ZnxiQBxTGWe2Pk4BgcGItYFAVlcwdZ63jyWlWEy8G
778NM4RYK+DhYXl2FTSrBUjjddc0rs1j/kbOGCyi5/NhvSrsEZ8wscJkCzuh2ELz
WhFlORhIWL4vrXgHbNTQjROQT+sogYyCGQOcVmpZz9RejlPMX/eBJnRY1+xY7S96
3aGDG7IgD0bO+gt8BcgiakLR3lSVgzrkO1oDEZxfI+1bHIE5F/3gNUNEFVPWD+DE
cl23wcTZfg7fFYRNtAYTzHKwSODt9h6SzILcDgmQLoJKRt3qpluKZlSwzyAQ6sFm
fu3RWyw4Gb87mlOok0qrNLZsbDNVSH5tsn6KF2i9GOk7ceqc2aEvDuJD5ttfn88O
7zK0Z0qgpf5G3pR75p4yhWJriEpiWFDwAB4dIgosFxE5O55iChiOEwY+xrh2DBPE
5uNtSBeq+ebdbAZpejHVc12TSCO/2NQX6sG1/MS04jpPooRRgSd2KxNKIbVaNN/R
NfzCLHpjdyKPYnpWZ5wNEjGI4rpJmYuuxqgvcj3jgdNV3Qa0iEtBpd6kMy97y8nb
6ZYwbtA6DR4DELwmKz+QgoQ8ZcAYCnrC2tEiQRT6pQN7X25ftgSpENVLmgQbm3PS
rJl6O/vcs3q5YwZ1wdzx
=UHNL
-----END PGP SIGNATURE-----

--THlL8lzu8dvjtcEp--

--===============1920655712414396009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1920655712414396009==--
