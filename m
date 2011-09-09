From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] ALSA: aoa: Remove obsolete cleanup for
	clientdata
Date: Fri, 9 Sep 2011 12:05:40 +0200
Message-ID: <20110909100540.GJ1912@pengutronix.de>
References: <1315561784.2831.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6453341465633273386=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 506412509C
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 12:05:45 +0200 (CEST)
In-Reply-To: <1315561784.2831.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6453341465633273386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2011 at 05:49:44PM +0800, Axel Lin wrote:
> The i2c core will clear the clientdata pointer automatically.
> We don't have to set the `data' field to NULL in remove() or
> if probe() failed anymore.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5p5PQACgkQD27XaX1/VRtV2wCeMwUZIlQBEnfmsfKZgbz+6H/a
ipQAn0ivB/xLvRMgbtLBSZcIQcnH3bWz
=dfHY
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--

--===============6453341465633273386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6453341465633273386==--
