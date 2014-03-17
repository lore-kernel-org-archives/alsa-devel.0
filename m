From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/4] ASoC: davinci-mcasp: Assign the
 dma_data earlier in dai_probe callback
Date: Mon, 17 Mar 2014 16:44:16 +0000
Message-ID: <20140317164416.GS11706@sirena.org.uk>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753834194992232666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D130261A22
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 17:44:27 +0100 (CET)
In-Reply-To: <1394808168-32608-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1753834194992232666==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="58yjuNbz5lCTNNJH"
Content-Disposition: inline


--58yjuNbz5lCTNNJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 04:42:48PM +0200, Peter Ujfalusi wrote:
> Set up the playback_dma_data/capture_dma_data for the dai at probe
> time since the generic dmaengine PCM stack needs to have access to
> this information early.

This is OK but depends on patch 3.

--58yjuNbz5lCTNNJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyZdAAoJELSic+t+oim9t1UP/iHbLTB6tH9z9pKNcS4mjLvt
OGju/BG3Kwtg0gLVPxXn6Xpjmnev9dbMEOLq+QmzxOxQv5PM8wJF+gkWYKSrvT8W
5FTrpHUHqyEMqKp5ZrTXGdSHWWIu183uAHBKrWtXStlaMAdmgw9+zTqNQ7depvfC
XUoB8/jvgB0VojVvuWMFbtvjAh5HLdst98BtfTX+dIUnPK6zNLMTseYYV7r6fDmT
N6pWu6SfAXJOGg1mh7e+tS/avP9aHxwQGaY+AaNdsYoLFMhd2HDp925ST4G0Zkpg
6tTihmbMfQzHOMuIUhrLwo19sM+ibOqARL5Idd5iQxOzb4cXgxDJfQmls4Q88QW0
kSNPuPzWLlq6wrDW/iw8cwozsw1T/v4e/4UPYKjzXIXJNIvbvbYc8wECMsH9ejeg
NOuKREEO2QUox8zHWEroT9H68rf2zG7ejYrC2NpHhktif7gteiVObo3moF7TxFbB
QQcAs2vBYAMRpEbXjIYLwcy1Fcs3m/v8o2xfGYV0MlcGHPHCEyYGvH7dm6b2+sJc
yft4p5v5a3jhg8OxPpI3BE8kSOAMdofLvfsf9+8Zcz9RzwNSE8y4f72VG8stt651
4ZIhGyvnW9sO7+2tjdnVds+szemeJvOxsB6zB5dc1/J/pKEvQ6ZAkxdRVUthbkKu
vsYUMmjPNJ/fWPVh7bFO
=j+2+
-----END PGP SIGNATURE-----

--58yjuNbz5lCTNNJH--

--===============1753834194992232666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1753834194992232666==--
