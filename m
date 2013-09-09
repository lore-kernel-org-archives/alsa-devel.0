From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 5/8] ASoC: davinci: Add support for
	AM33xx SoC Audio
Date: Mon, 9 Sep 2013 16:24:53 +0100
Message-ID: <20130909152453.GL29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <3080f759b7390ff36db367ef1faf8b9df0a8d64d.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8398333664029767417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4996E2650EE
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:24:57 +0200 (CEST)
In-Reply-To: <3080f759b7390ff36db367ef1faf8b9df0a8d64d.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oku@iki.fi
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8398333664029767417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E5RiUMWuxyMNPNnv"
Content-Disposition: inline


--E5RiUMWuxyMNPNnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 06:12:16PM +0300, oku@iki.fi wrote:

>  obj-$(CONFIG_SND_DAVINCI_SOC) +=3D snd-soc-davinci.o
> +obj-$(CONFIG_SND_AM33XX_SOC) +=3D snd-soc-davinci.o
>  obj-$(CONFIG_SND_DAVINCI_SOC_I2S) +=3D snd-soc-davinci-i2s.o
>  obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) +=3D snd-soc-davinci-mcasp.o
> +obj-$(CONFIG_SND_AM33XX_SOC) +=3D snd-soc-davinci-mcasp.o
>  obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) +=3D snd-soc-davinci-vcif.o
> =20
>  # DAVINCI Machine Support
>  snd-soc-evm-objs :=3D davinci-evm.o
> =20
>  obj-$(CONFIG_SND_DAVINCI_SOC_EVM) +=3D snd-soc-evm.o
> +obj-$(CONFIG_SND_AM33XX_SOC) +=3D snd-soc-evm.o

This appears to be trying to include a duplicate copy of some of the
existing code - that doesn't seem sensible?  I'd expect to see
additional machines added with || and possibly also some help text
updates.

Even better would be to get the code to the point where it has no
machine dependencies at all.

--E5RiUMWuxyMNPNnv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLehBAAoJELSic+t+oim95oUP+QFEztXt5nsAsl0/vw2yVDJb
0Ypx/4soPA/ZhMdHKSMpYWsSTPUYnYxTWEIT6b8oOKdnSrI4EmCxxyO/FJXjvDhT
VvvmeM9vsMY0OUuxO8gr91sTcXp0nLH6tNBgG39mdV6hbTIDOuGm/06hgqgMCe5K
daYiy8euHKYLG3O+Zb3Z1RSvyPxeixI4gMk+Nk2wq9+rUyHCUHPRZY9k4aQV1fz5
KUU5Tugk+rkrxOh1KJgul5GGvIyae6LqGHK78+U54WIGXh+XjnyYwC5q39RtELH3
rvJf940h3liuPhkOd/eilfIqbpNrqa+JNPxp84xshqt0yPhTjiUdyaO82BToj6+Y
EaVdZbheb35BbS9JOc45E0D9vks25CdqXvRsB/NfLZDZNKx/XnceZnzVtUb8m8fv
qwSTr3+SkBYk15TASTs/g9GqsKeoVq8nt37xGH+vSInmZm/R6x58CGMZ7iqdTL16
bySgG5kryVQBKHYyHSBBDtfnl1fdHBM/PD3xOy0gOnexglbHO9U5bcN7w4IxfPTG
TCzVyKHGNp1fKY+jeF/8Zu7rOsHBP98K8fU3iDAHCzxkWKmhshRYkNcVUqwyceR4
/NbOH1hIPmyEzY3nEZtuzAcb5xa6rMNAieNov7zy3vIVpqPq6Oe/ySzU6hZTrq4G
e8/Q9ZXV+PijLcbSiw5o
=H4R2
-----END PGP SIGNATURE-----

--E5RiUMWuxyMNPNnv--

--===============8398333664029767417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8398333664029767417==--
