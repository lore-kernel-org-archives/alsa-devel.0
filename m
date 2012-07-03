From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix dapm_set_path_status()
	connect
Date: Tue, 3 Jul 2012 20:08:46 +0100
Message-ID: <20120703190845.GC29030@opensource.wolfsonmicro.com>
References: <1535746789.386644.1341061383351.JavaMail.root@advansee.com>
	<1035078102.502287.1341229521711.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6108275085056489636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2431A245C0
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 21:08:47 +0200 (CEST)
In-Reply-To: <1035078102.502287.1341229521711.JavaMail.root@advansee.com>
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


--===============6108275085056489636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PAKmkkBo0+rTwAqJ"
Content-Disposition: inline


--PAKmkkBo0+rTwAqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2012 at 01:45:21PM +0200, Beno=EEt Th=E9baudeau wrote:
> dapm_set_path_status() sets connect incorrectly in the case max > 1 with =
invert.
> In that case, the raw disconnect value should be max, which corresponds t=
o the
> userspace value 0.

Applied, thanks.

--PAKmkkBo0+rTwAqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP80M1AAoJEBus8iNuMP3d/AkQAIuICt4nP3Zzj7rWMyYyOwQg
bTDPNAyGZbP96vVAeU5w9veqtekJczqIe/rM/nW4q/Of1rnbMbwum+O4pVteXRmG
kw9LOVauV0hjkPjfjG2YjTQFLOnWt/ABraF5AIMOjMel47Wr6xXQV3+OaQAD/16E
odjOXTEaliQ+tjTNof5K8deXN9KBw8v5xOMyqjzkzBlH3bbp907YuBykwlF7n4s/
2lI2vaHGSXIHiLimECbcMRrydSRTz1+o+HMXu4u5NmgqnfYbp+8geHb/60g1dpmM
Cmxz9FZq5D+XZvW7rzTmGNDwc2/VWcwQekD/WhEhnbg8fue44ZFS0mIb4r8UmIyr
28rYYVhLOeUUoach6GUxK0UYSB6oFLCt14zW/Z/i+vTc5VhvSh2YmgHm9WHH++I7
8T36NC2suV6X3PK5jZ/mqiScP6SAOxJdnBpC+t/q0ZkiclPTwPD0aYgBTDNrirTS
s9algv5C6Lch+mO1JISnHG8T0FoO4m3Xi3ww8x5klAg+4i7wwYJq0LYobe8kJrEe
IzZBu75Gz1SS2MiJo9KNlMuNwRHcHj3dKUf6l/f3VAZK+hBaA4KYiHpjf+Oo+5mR
/HoNoNag+wecnL4WmYHc4mQWGA+vFdkho6wNbfU6tG1HVvLbHBTpAV6vizdn4v3P
GI4QQJuABJeEeQQt9RB6
=NbQW
-----END PGP SIGNATURE-----

--PAKmkkBo0+rTwAqJ--

--===============6108275085056489636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6108275085056489636==--
