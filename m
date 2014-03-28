From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3 v2] ASoC: ak5386: add regulator
	consumer support
Date: Fri, 28 Mar 2014 11:21:02 +0000
Message-ID: <20140328112102.GY30768@sirena.org.uk>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4271481905379697392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98CD1261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:21:16 +0100 (CET)
In-Reply-To: <1395952936-10670-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4271481905379697392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="npbjE3dh3wBH6WIP"
Content-Disposition: inline


--npbjE3dh3wBH6WIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 09:42:14PM +0100, Daniel Mack wrote:
> The chip has two power supplies, VA and VDD. Enable them both as long
> as the codec is in use.

Applied, though you need to update the DT bindings too.

--npbjE3dh3wBH6WIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNVsbAAoJELSic+t+oim9QVUP/35UK5vvpmf/wcfhoOVAA6YW
VNwiPd+0sOgcMPNaKm6XN0F0ht5lppLquaXUmhVVCv/kGlJdy3pLKvSiQqqA5naJ
qjutA/zZglostaYPoBz05/ttwMPKoYVn3N7nOh2KYcwhDPcMRa/j6xTe9zec/JKy
Hw3kH3gW7EtZRRprebMvyqHmCfY6JW8nHKud4CXr8CuoTVsx0Nkx2Sn5iXSs5uWY
rGOeJgeM7FIOP0vT1DL/LDR2f1OUzifN6ThcGfJ/EK+r9aoyf6LZVcPYbmYUy9VF
Ed6zyp6hDH7JGclBm64QrwGUoQzBO+fy3is7R5BQ05Y8DVQeebVQfFyLAKLgZLit
WwsmSVrzjymWR8kllGtxCbtM/BNSyAfpwshs8zYMlHyNipcGPt5RoyfP4UehRHxh
T7GEb95yvExMMuiCmdgs8NoNshw4v27UX9O4qWxuapYx+9vaxHW3Y2dDEQH+GMJm
uOK5cZY7zQWG0BpfJLxDjjAnftCgAZCzsFDiPsc3jIReVtyKGQZ9OuTg8oQoeOsl
lMl/0zNQvIV3N6xmJJ8AlhvOlaY0kLUvI+30LW6ehzAaDxAvctjA0CL54wdk+UVG
kEG6rDdEs9AQEs15T+9vwUeflGmzbSErsi8QBqvLifV07RiDiaNuPdbv/t8F/YiM
mGPs7UuMDhGJgvlqq/qz
=+g43
-----END PGP SIGNATURE-----

--npbjE3dh3wBH6WIP--

--===============4271481905379697392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4271481905379697392==--
