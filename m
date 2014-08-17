From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: odrodix2_max98090: Make non
 exported symbols static
Date: Sun, 17 Aug 2014 09:32:11 -0500
Message-ID: <20140817143211.GK14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3569307818420321011=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 052DF2651E4
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:32:30 +0200 (CEST)
In-Reply-To: <1408285102-24538-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3569307818420321011==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:18PM +0200, Lars-Peter Clausen wrote:
> odroidx2_drvdata and odroidu3_drvdata are not used outside this module so make
> them static (and also const while we are at it).

Applied, thanks.

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8LznAAoJELSic+t+oim9VBMP/iUYKiKc/Gva+Zo2n88NLyP7
DjQxLse+3Vt/7yu+S2GFUH5qXM9PO33cfUHWNfMBPPAG1JwikzpLkh1XGDHw6nhX
YCEsffQv6mwohCYxx/Ck7i7cOW28jOvRMdRBcubfYMJVeqUg0uzA08g9Hb1xpyez
xktjot9L04CY4btIFIKWFWV3LxXXSrxuaxBA8/16MmxpbZbtH5xLFvshgnRjwXDx
XS1Zqml+QNRlHcWp6Mxx8NP9MWi0zJoxW3gV9mseE55tG5jkXJv6fHqyS/jr7QeE
6E0nfDTViLOD69L/CpjNz0Mgz+sCru/HGrHBr51/VUAKOHz+Dcl/cIZTKLWErQtg
Bp5QVwUAcnn0R9MPq0B+yFG6LFFV0ynUe+mKse7cmi8/HsccX8oyTC4iWR0kQWgV
XHP3HJH5j6GbOYxm2dWbnBaugKgrtTXCL47+8f1cB3zauU7/pYz1qnML6y/FRd0/
ajUw3hWgwJDaxvrIF3FQcV4upAuulvytgh13y6WqD7tI7DJbr3YlHoqfSw0dgbqA
qwgWxy22u1kCy+49BRvPlY/hn4pI0ghggLAKW6LZeWRucm6RMD2/zdca8Pmgh8Qr
BeJftF4U3Q0sqNGuUow5TjZYEQKsnXe4mAXMPpKOH0fjNz0myPiiIoQQ416f+uvy
Dio8zI2lSwtiZQArfZgH
=dSv0
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--

--===============3569307818420321011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3569307818420321011==--
