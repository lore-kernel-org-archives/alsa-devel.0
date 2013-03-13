From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ALSA: ASoC: tas5086: signedness bug in
 tas5086_hw_params()
Date: Wed, 13 Mar 2013 11:09:24 +0000
Message-ID: <20130313110924.GL25610@opensource.wolfsonmicro.com>
References: <20130313053253.GA17674@longonot.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2512783431652636634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C8BF265E22
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 12:09:26 +0100 (CET)
In-Reply-To: <20130313053253.GA17674@longonot.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Daniel Mack <zonque@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, kbuild@01.org
List-Id: alsa-devel@alsa-project.org


--===============2512783431652636634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Content-Disposition: inline


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2013 at 08:32:53AM +0300, Dan Carpenter wrote:
> "val" has to be signed for the error handling to work.

Applied, thanks.

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQF5WAAoJELSic+t+oim9RaEP/R3Ygor7kfC8wck8RrkuK9Ed
FzspzUwTxKDsMKHJ5a3a6L6k1/V8ytTll8lq+4fXLFsu7n5aBwC+FaiXzKfvSUWE
4gK9n9O8t1a+8elFf7iTh6aCjMqOqbcKhricsiafNLDLNq7zc00Ha/7Wh1ljrvLM
JDKHft+UB9gQPN0IJWjXZJID8tYyTssCCV5818e9ESG0f6epJQbkimAUA2t0MbaE
6GfW+WSF0Ivqbucz5zcuKxsMQ2NUuEa1c81u4fd8xe/8vMylkQL/Sx4M+3aP72Yt
BdmNWCjQ3HV6QrgThxco9QDbatMWi4dxK/UdIdr9uwXdBENA1CrBrDeJmPY1b0V1
3t3idR0HJ4KXuIhD9oT1PguiHeX0oQs/5J9TINsWjieLR1reS76YREUqUur4GRQM
Ie/VxFizAGdHLecYjGLJJRl2oASUyYcavnFrze3XMzNV2TIruOUF5ak7lJkBW7Lt
kHp5vcpWQNdrHsltd8Mw1vwXDqzBQy2J6vQnPx/6kV5iyO9awOhyAKJkWDrVOZ/2
J7pkrLbLWgRvugswm4CyeJ4JxxuIbHkQowEDN1gZW0anocI/cpq/3mX6eyiFbXz4
Twy8K8PZGZoX+fx2Ox1RJi5oXgWMR/WVrL3CL4Ys/A001RGeGBimfWGK8KEgGWt4
ZG74jsUu99KrsUBnQfrw
=6MqM
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--

--===============2512783431652636634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2512783431652636634==--
