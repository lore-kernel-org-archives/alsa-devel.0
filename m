From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/12] ASoC: kirkwood: Remove
	ARCH_KIRKWOOD dependency
Date: Tue, 29 Jul 2014 20:35:58 +0100
Message-ID: <20140729193558.GL17528@sirena.org.uk>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9093949010713425313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7854F265483
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:36:18 +0200 (CEST)
In-Reply-To: <1405028192-9623-5-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, alsa-devel@alsa-project.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============9093949010713425313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fvimixt8NQMDp5GN"
Content-Disposition: inline


--Fvimixt8NQMDp5GN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2014 at 11:36:24PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in
> mach-mvebu. Remove ARCH_KIRKWOOD since ARCH_MVEBU is sufficient.

Applied, thanks.

--Fvimixt8NQMDp5GN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1/eaAAoJELSic+t+oim9jLcP/R0X4M7uV7hMNMCI486SXc+8
NeQy6R7rX8g7DNvNWanDOTzcTR0aJTswEgyqAlyU7nS41qFg8K+c3g6WwpJGZg/m
cN/C5JWInaepnPkjyBeGGIzcOA3qbKTaqBzbLAMLtBnd4+USGYcV0HKACQuFYWpm
D8VLmuVjihgCLvviK3AnqmVI9netqlaltkYCHTziflQEM7L+nDelt9wEfj0cp9to
ZlpOu8jyHEkRRhZLCczAgbRnRINoU+MjnshzjzMt/ZR2tMaLyuaRXx4wfBSbi6WX
Jsj+6vz0ajnYC/Ml/5zAOOd1Qgg0hAgTZd12rocfxJZWHjLHc8dqW1VBHNPnd2vh
1RqBtVM3U2l/ZxXV5WoCk51VxkbZwl9CZp9tsOklKDWqnpg6VkuiMqQC14kqineg
IOXR1oVOVLMJ9yhnOXvfywyXxV6aKzM4M3YuuFnyMCu2qAFeUVC096E+HVXLRURh
DGRSSZJ3Asm2yhCx+T/Bg4Z97gRTJCF8UYfXIhiz3QvE9YsQi8tFBx6R8sQfN+Az
v1jogG7sjPnxcUetP9inBcAd/7o56vJQszGfW50MriGMdfai+B4G41fP0gAnmWcz
CEjig25Qo+BS+Nn/8i1z4Ppcj5vx9kLge1FQPmYBhHhSpKfrAvQcMqbDO3A4Iuju
SB2amUGI7t8N0DMZODhn
=pkF6
-----END PGP SIGNATURE-----

--Fvimixt8NQMDp5GN--

--===============9093949010713425313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9093949010713425313==--
