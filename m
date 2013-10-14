From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: pcm1681: Fix max_register setting
Date: Mon, 14 Oct 2013 15:00:23 +0100
Message-ID: <20131014140023.GY2443@sirena.org.uk>
References: <1381569865.3884.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3418327896804764552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1782610B9
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 16:00:47 +0200 (CEST)
In-Reply-To: <1381569865.3884.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Marek Belisko <marek.belisko@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3418327896804764552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOYT2+aw+EAigp19"
Content-Disposition: inline


--GOYT2+aw+EAigp19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 12, 2013 at 05:24:25PM +0800, Axel Lin wrote:
> According to the datasheet, the max_register is 13h.
> ARRAY_SIZE(pcm1681_reg_defaults) + 1 is 18 which is wrong.

Applied, thanks.

--GOYT2+aw+EAigp19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW/j0AAoJELSic+t+oim9m4oP/RWHDfuLQxxyePNwbWzcfusI
bNjFMye6WaPT39kyXa/tim+bWi9tXk3evk0LTDL9huAC2DTO8NksADipMRg2nrEp
FBjVjK9jiinTxFqZblwNk6c4uMOfIrU+i28m7qrI76P5X4NVhqyRAz2fkUobqkEk
Oh0QR4G4dKYbhdrg5y9sAQNZVIlE6+SE4egZ6NyHGqWtOBhB3YwG6Rd5jjVRAuF4
uwFesCgpcQ2tGQwOkfXFBaMoYFnWQmhj0f9Hioat0g4H8yla5Q4jKUkF/knHdIP+
qTEs3qaDYQPDzJ35yn2ZMslVGRGOIIQ149aFTd0QTNMl1zWiue0ZUJLKoD3w4DCW
ivWRJjHC5xgclPZn3w+B8P4Qjp84K0OzfA+vcPU2W1NtNWsFDEBctWdG5XPtplCl
MYfZ4ExGi6s+iG0PzWrHZPRi2vAfQgNq4pn3JCpKi/XDfnPYgKlaygduDK5Ud0ea
6GIbMoxVbbZJxvpldhz9nA/Oo62ObxHmi7oPSAjBz/8gersBCr5cAmAtWbBIBp8/
JnB9httWtCUiOoE1i9aUa6YyelyCZKJwgT2oHSvo0+TJw5eGmsXRVtku6JMdz9Vv
WgJlcyjwfoo9BHLDuZex2eIx8kmPCqLGqDmXGtf8f/couDDh9PmvOPAtGhdsWej7
rOEMhh07QfOrxdNFhEI1
=VSb6
-----END PGP SIGNATURE-----

--GOYT2+aw+EAigp19--

--===============3418327896804764552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3418327896804764552==--
