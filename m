From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: mc13783: Add devicetree support
Date: Tue, 7 Jan 2014 11:08:12 +0000
Message-ID: <20140107110812.GU31886@sirena.org.uk>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
 <1388907515-18975-5-git-send-email-shc_work@mail.ru>
 <20140106132841.GV31886@sirena.org.uk>
 <1389015981.978548720@f170.i.mail.ru>
 <20140106151227.GW31886@sirena.org.uk>
 <20140107110053.1e353a58ac661c7c64860fe3@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409618163465274481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A704B2616FE
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:08:19 +0100 (CET)
In-Reply-To: <20140107110053.1e353a58ac661c7c64860fe3@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1409618163465274481==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xZUUYh/FQdxVAVy5"
Content-Disposition: inline


--xZUUYh/FQdxVAVy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 11:00:53AM +0400, Alexander Shiyan wrote:

> So, we need codec phandle.
> The codec is probed by MC13XXX MFD core, and codec pdev not contain
> compatible string, but we should associate our codec with DT.
> if ASoC core wants to use codec it will try to find it by of_node.
> Maybe my opinion is wrong, fixme.

The fact that we happen to use platform devices inside Linux to split
the MFD between subsystems isn't something that should leak out into the
device tree representation, this is a Linux implementation detail.  The
card should be referencing the root node for the device in its binding.

You're also confusing the idea of using an of_node for something with
putting it into the struct device; you should never need to modify
what's in the struct device to use the device tree data.

--xZUUYh/FQdxVAVy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+AZAAoJELSic+t+oim91ZkQAIbQlZQBeKSsCbLKhnFPftsR
Vn/oUOw5CpT5+StCPdA+zY6Y336gXWd5LFUV98mVjV3KdOijhPgmjgKorp5o7hBx
qdtPEDJif051oZwDisMdbPMqCNA9p1KMJMtF9bK461ysfGajrag+G6kh9EUt/Q30
jec69bgZqD4pmdOpv6OaEm1iwGx1u1hnc2T3UCFoW4q3Amw9ttFDPwr0wWVktupu
DIsHZBg21/RIGHPZs60C33w6InogZEZcRztzcmr6FXuim1uX4q6AgNY/Vvt8RQ9w
aKTn8B2D4t8aNeEIG/QjEkV4wQzp8NSnV8lZ6AE6igUvVHoZLCT7o2j9c/9qEMyr
g2ZEhOiDH1/Cy0E19/PFrtw4e8rUy7CcU/uFMvcJLtAj7rEpk384t3otbviKxbV/
NBjo8TspEeQQ+ev6fOgmrAUFK5we0cvmKQrP2i4fmT+7jD6waouSYVvpFoo7vt0m
d15B4pBBB5RmZyxmyzEYS7r9wxAPQif7AvZLf7GWBFEN4W3tKEY8vMnM+96dypmW
v1YgMimae2KBOWM/esjaP6imtjrPVWxEgqJeWlbtEFcCHB2dXJ5ZazOOb4Eqg5U7
yRVsVr/fY5xrYmr56LlbepozhCoQ/qzqIinM9ANvGArewz5ktPViDZGC3lBHBmqZ
UtFha+EdJ7D53E1BGsEY
=d3Ux
-----END PGP SIGNATURE-----

--xZUUYh/FQdxVAVy5--

--===============1409618163465274481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1409618163465274481==--
