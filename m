From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH v1] ASoC: soc-pcm: add symmetry for
 channels and sample bits
Date: Thu, 14 Nov 2013 11:57:04 +0000
Message-ID: <20131114115704.GL26614@sirena.org.uk>
References: <1384340184-4381-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0924279373085422887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E2026170E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 12:57:08 +0100 (CET)
In-Reply-To: <1384340184-4381-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0924279373085422887==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 06:56:24PM +0800, Nicolin Chen wrote:
> Some SoCs can only work in mono or stereo mode at one time. So if
> we let them capture a mono stream while playing a stereo stream,
> there might be a problem occur to one of these two streams: double
> paced or slowed down.

Nice.  Applied, thanks.

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShLqMAAoJELSic+t+oim915MQAI5OXA9CTWlTDK1TF7M50/1U
xxLYfmvWKvhoZavcBSeU3X87o8kz5Kn6d0VzBdGlNoVwxW5xJjTz72xz2WNqUU2r
Dqt80m19BXQmlV47QqLwMOyHclfwNB9Udzm3FQctWqMa9TRoTVCR7i8b4zDlXUrF
FmBVfxXuVStmtIXD5SzA4Efiif/83/vCPNVsggHr5HCN2WcWB1DnEp94AgNj5fee
9rjqUETqK65F3INKpE6PTDmOjEqZ/gqFTTDDNIkXJ8KxpUYUQEIEeE2sR3OLpXjd
/PyWKsovOBFcEUnU/QdOcUVhQWReBQheDDVVFeuW1I0tNjMTzu0+1PGjPnmPN+C3
j2sMepj2PGlB4d3ImCh5FOLR4wUi4uRPbsUt1vypooXNySTCXZuUDWkK3fP/EfW3
9T5ZPZl0+d9gjfA0AyLfdeZBtR27wUDETDZBpexEGhMCSdMzRG5NltPtd2UpeMQn
5rVioqYhLQM7nQumAuGvJ9w6fE5xfGQbC7k8h4gSfDSBFoG640JUPB1+KBfsI6mI
NmeNyb9Zy/zwYCURyP7O0ji9dkXYnE46KcRHfldyPOLQGuRthjtDNZzoT56dHvZJ
LXlFaKlnF/S71moXFGM47owkmAFXpvj12p0FOzcwf3D/eHZY1HYCbjocjhHNYblh
m+ePW/PM/qTA869ySRK7
=1P1n
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

--===============0924279373085422887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0924279373085422887==--
