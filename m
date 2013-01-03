From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsi: don't use platform info
	pointer on probe()
Date: Thu, 3 Jan 2013 12:51:02 +0000
Message-ID: <20130103125102.GI4627@opensource.wolfsonmicro.com>
References: <87sj6qyiju.wl%kuninori.morimoto.gx@renesas.com>
 <87r4mayiiu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3210516677671566941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A047E261608
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 13:51:03 +0100 (CET)
In-Reply-To: <87r4mayiiu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3210516677671566941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 27, 2012 at 07:15:08PM -0800, Kuninori Morimoto wrote:
> Current FSI driver is using platform info pointer,
> but it is not good design for DT support.
> This patch made it not to use platform info pointer.

Applied, thanks.

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5X6vAAoJELSic+t+oim92B0P/iArc7l++JkStH99wsyRy/Mf
pbZ8N7IucZaC7rvBEZbyh1cAcFsZ6emoaijg9VGXvBaInSk6FdVy2sMZGMzHJm/z
v2OxkfSq66T56UZWzS/xFJEEDKgiltKHNtUOww8r+hGW6e+YwMpiQOYH0CqhFxOg
tBU+/erHrqhGunHq1Tm9im6wqte3WSNHJ3LqXrAsJEzw3A2z4w0LfXTwOjWY/aEx
v924lTMv0Qsjw5wh4BYt7V6UHEX57cYEiwGKsKQXDT/Uelzovd3noomrZGAaTM2D
uSwAs4RtONxpgazfVcia/wXKYaIMeNwaAJ6SgaL9+dX5p2bcqrNd65B+4Ewp8F2j
9s/c3bkXATI0hv3hgHXxvkNKkd2jqTNYf+QwJLgj43LJIcMDC4Jsn+8T69JeaZI+
JL+ZRtO1bJpbZ7w8XdbFO2cRXqKv4YGZgPfaOiOyRXVRJlm3jdbIfOUI91oIQ1lz
warKTvJyQAJZoyPmSbqbUSY9JkpuRDjdHfAAw9i+VFp0HChe3jT8LNe8AF6WCoq8
7lPDfFNjEJAR768vZ2zMBn8KD5pzQDlwyx9J/cP18MCdBE3tjQg0AbbsOR/MHPlf
BQ7pB01HVe11mxqA/PtXK56afBTpQmX3pPNdDuBF/GUr3YJk/m1rs7D/6JJjvfjK
G8SKfuL8ybr83DWYJ3Pw
=8634
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--

--===============3210516677671566941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3210516677671566941==--
