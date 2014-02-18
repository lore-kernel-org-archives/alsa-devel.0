From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: adav80x: Split SPI and I2C code
 into different modules
Date: Tue, 18 Feb 2014 10:30:56 +0900
Message-ID: <20140218013056.GU2669@sirena.org.uk>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
 <1392639416-11293-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7841297323593422426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B3742650C5
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 03:00:14 +0100 (CET)
Received: from e0109-106-188-99-154.uqwimax.jp ([106.188.99.154]
 helo=finisterre)
 by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WFZym-0002Y8-Cm
 for alsa-devel@alsa-project.org; Tue, 18 Feb 2014 02:00:14 +0000
In-Reply-To: <1392639416-11293-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7841297323593422426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uUozbLrG2OP+gMtx"
Content-Disposition: inline


--uUozbLrG2OP+gMtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 01:16:56PM +0100, Lars-Peter Clausen wrote:
> There are a few known (minor) problems with having the support code for both I2C
> and SPI in the same module:

Applied, thanks.

--uUozbLrG2OP+gMtx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArfNAAoJELSic+t+oim91nwP/jO7zdFquv9dOhD/yhK0kzAD
4aSw8P+QRL0I2+oeaxY+o83k2pTgh/GXkNRiWTAOyjD0LRVmexhGTjU8zkdL2Z6r
wB9bdh52TtJZKtB65KBPnDfUjJY3jhBJCMD2BMbPxqwTWgbHzgv09yUfI1+KCnPR
oUzN8JWqLbCjgOy3yI1NUba2wCDqpg3pLMf1ZuUoFHevOtx3V5zfw9z7G/0+X5N0
bgB+U2Hs29O+ZTx2nS49x9YDT+eeGl030tImf6wiDQpikjvxGBXvDPHvrWILEixX
iDwZX86YhAxTf8FJtSFR/WZH3JDY8pMGDJ+BwVStAInh5jbx5YH/GYJmFw4OQNGc
H/zNO5Uu2QdbH0vfxsFhrtfZgmAaTsAaNbIsAcoaqFpqQyWb3qatPWceFGjZDPOq
34blNFjXh7iISQ63APqtogGF6niynRr4CUB2/KeaM5Q7ADSYf94LzfjT5R+gluH0
4gGm8SSB259XD7nzxUeqVdS1Za1+heF6YtT3O6oxXr5cLGAjpkX0IY0rjEHjanFZ
0FBzxnVfYZy/nm6DZRAPoJ30VV0wyMLZhhFKsUzLFueKVPtzofbxaMJdJ8qZu7JI
Bakuk6LFm8+KeZCpnhknO0RqfIPktIPcq8pKOk1PnukQW9Zfbwc+lNSWzLicV0N0
8r72jFe2//ryQgg82HFd
=lKTy
-----END PGP SIGNATURE-----

--uUozbLrG2OP+gMtx--

--===============7841297323593422426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7841297323593422426==--
