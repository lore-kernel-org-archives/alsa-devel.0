From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
 after reset
Date: Fri, 10 May 2013 21:59:02 +0100
Message-ID: <20130510205902.GW3200@sirena.org.uk>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9081577796556437383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9957E2619EC
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 22:59:13 +0200 (CEST)
In-Reply-To: <1368144947-23775-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============9081577796556437383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vo2ArcSjcOqS/fzO"
Content-Disposition: inline


--Vo2ArcSjcOqS/fzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 09:15:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> After a 'reboot' command in Linux or after pressing the system's reset bu=
tton
> the sgtl5000 driver fails to probe:

Applied, thanks.

--Vo2ArcSjcOqS/fzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjV+SAAoJELSic+t+oim93oUP/313iuTfGpD10rDqArBmFGEc
uwOeE+whyQfFN68G0M+FMEqZ+y6rnnVTHdUpyEQht1hmAvnqblM1dzaZVldr3pT6
TsTQ1AFzYJjt+IGWWPh+R2yl/uug35mZuijsWvOC76qoktL30XP4bTYcYHrcqF1j
6xpLq35c68DTosvqOLX3Z++Xm8hgI8P7tV5sca7YQsZoE7az3hnp5oatuoOy0o5j
s8mu9VONbT62/vVYUm9b3ne56CjrqKEFoBW+gTaNNBRLoixgnXthlNarms1SvpN4
Irp1Jw/AmHaq9hwhrZ6Q0bstbW+GRfiO7Vjizd7ZHIZgnElV42zI4qOhVWgAldA/
64oFBsD7J8OrhLWC70u1FY880g1RUlsSmm5Nt3UPS+ob6sdivhiHwqCGunvowLIs
+mOtD6Wss4hYyw0R5VF7ex98k6NTFc0BncvTojfdsPKUZ3yjfXnFrhdvcOTkHWnw
6quhEmKlyEX1RtvbJ7h/RR0p4ilJvbV9yxXz4l4GWYfj4q95zrDewivRBQJcWkWC
mxNQ77kAvQoJNrbDp+pRG7ErGqstBgRZTVDMIhHR9r85ZscD3KuDjC6ozlgq0rVu
oKQ4PUUywDAJuOMjSileyCA+aiIFXOx771NkktVWySHGz2EAR+PNFxle+1q9Vx5S
hxpGue7yTbyoRid3GgDD
=Xb+b
-----END PGP SIGNATURE-----

--Vo2ArcSjcOqS/fzO--

--===============9081577796556437383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9081577796556437383==--
