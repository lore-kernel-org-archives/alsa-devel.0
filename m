From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: codecs: adau1701: factor out
	firmware reset
Date: Mon, 10 Jun 2013 14:09:46 +0100
Message-ID: <20130610130946.GA1403@sirena.org.uk>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
 <1370605987-19290-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8547651150576355009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 18BA02615D1
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:09:50 +0200 (CEST)
In-Reply-To: <1370605987-19290-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============8547651150576355009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 01:53:04PM +0200, Daniel Mack wrote:
> Some runtime-determined constraints might need to be satisfied prior to
> firmware loading, so the actual download and releasing the device from
> reset has to be postponed. Factor it out first, so we have everything at
> one place.

Applied, thanks.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtdAWAAoJELSic+t+oim9CMYP/ie9b12+OsUpNHcH+rOBVbYN
+VkEkLGyl1iCRun1q8Cv8bv3F2w+B3mYtmF5edvgCX83rDxBsXk0tpigq/nW1eKI
yaW+NbecK5Kde7gLs8Ge02S8QUtjExhumNh3A2yx6JkbLGPi4cnHTME9JTycCeFG
eGs6ltwyt3e8kN+czcbf2hGEf6S0yWg0lp3GzfKEtjtiQ92vWUcg3GzcmJGTD1yC
50Ie7Y4I4+nNZWeS/9n9j60PX1MjRkNn6pWaOBgIr/XZnsXvl7C+NtfxgTBgI/lq
lwclSW87hbqTEsrWELetoVD201tzrkXgPz8GcWWIjqtgk0mI0cpuNrEtbXCnwSLZ
OKBmK83AuzHEkMgbhE737K3Y4b7UrFW655/DYAnX4BMBR7ph62qMLqIeAkM1x25B
QHi36sBDberbRoZTHEKFIetMii+GoaVkw9RpPveyIp+0l+8Qk/erw+48VlRERwrJ
BWMjSS8Ijxt8daj9N96+ZctrXyemvDijPPiN50U6hMEFM9XRGBQzNZeTTstZqPvN
zbg7RBzI+oqGqs7UiYEFG8DlZFaaQvdGknl3WY0UOcWOBwuPWDHrdkq0LY2e+Jab
ULXJdFALLTTab6s24zctoRn79BOxkGzBsH/R7ugWbxYR+bFmYoEdhpoZCxY96vdD
bMznoSlqOfs5bUNTQdAc
=CMfZ
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============8547651150576355009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8547651150576355009==--
