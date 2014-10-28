From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Add TDM channel mapping
	function
Date: Tue, 28 Oct 2014 22:52:29 +0000
Message-ID: <20141028225229.GP18557@sirena.org.uk>
References: <1413965499-42914-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1180276925777733278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E4E26045D
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:52:51 +0100 (CET)
In-Reply-To: <1413965499-42914-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1180276925777733278==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTh2KjHqV0X0DOgD"
Content-Disposition: inline


--HTh2KjHqV0X0DOgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2014 at 04:11:39PM +0800, Oder Chiou wrote:
> It is for channel to slot mapping, and it is not only for 8 channels mapping,
> but also in 2, 4 and 6 channels mapping. If we want to use the 2 channels in
> the stereo2 adc path, we need to set the item "2/1/3/4" or "2/3/1/4".

Applied, thanks.

--HTh2KjHqV0X0DOgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUB4sAAoJECTWi3JdVIfQuf8H/j/KXo9qVMgXbsX91H3MRINk
rb7ZZFc6ietDaIqCJSGRL8MuJFH0a/LsGl0jVOOTZy14OW27nrxAoUqgG3yCU+Md
IfYez2kWTzd47DOTIt3dsEObFeQtgYpGmaW/8w7pIFCb8GnnN3IY5Sua1SmybIlX
JLKxHYQr5lO6XDGe2eO4yjcq6F0iTC11Z+2Gfd3pLMxCLOFDweRrACVWj7wJbZmn
Xkprzboncq+1IxfZybD8Nc/LERIOLIl8Hn5h1+ycOLshqNG6J6Fooy7chWMBsTCG
Qu3wO6lRkJdioZy0f5neaoWHN1qsrKrCQ+TGfI/81rrhvzKt34PLTaW3u10CpxU=
=nY18
-----END PGP SIGNATURE-----

--HTh2KjHqV0X0DOgD--

--===============1180276925777733278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1180276925777733278==--
