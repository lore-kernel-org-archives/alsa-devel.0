From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: rockchip-i2s: fix master mode
	set bit error
Date: Sat, 13 Sep 2014 09:35:01 -0700
Message-ID: <20140913163501.GH7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568863-21723-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0543667748544550916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE8E261A64
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 18:35:30 +0200 (CEST)
In-Reply-To: <1410568863-21723-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: huangtao@rock-chips.com, alsa-devel@alsa-project.org, heiko@sntech.de, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0543667748544550916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YWfczjhUm04al3kG"
Content-Disposition: inline


--YWfczjhUm04al3kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2014 at 08:41:03AM +0800, Jianqun wrote:
> Fix error format set to I2S master or slave mode.
> Test on RK3288 board with max98090.

Applied.  Since this is a bug fix it should be one of the first patches
in the series so that it can be sent to Linus as a fix, bug fixes should
go before any other patches.

--YWfczjhUm04al3kG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHI0AAoJECTWi3JdVIfQ4/EH/RDS9OC2Y7QhShmNh8uAqSKB
v6LWC0PYNnyRTxNtp5k1Ck5ZsXqO6lv6O0320nPMF6YpkWSjzb9vDfTUULt8mkMm
qI/HrghJgGhkfBwDtILp0qUKwI/mUZxr+v2uXEOCJdp9xySTmAgaVkfSfLTpOsIH
zJX32HHicVHsfkvBeb4OGlGAXqMNUgoPcGAdfGT2BGj9I4qsGOe+MBTnSAkexA2H
9YMqwMPOicJnTZ+EjKlEptEu0PMbGbl2drkaSIID6E003tzCcr+EY7hR80++EJoP
oMJIqOCM1rTvQNFlfMagC4YwgjzzlXku0fVbQXH32CQ7c7vNfuLNkJhLTx4Ygbg=
=yeZ6
-----END PGP SIGNATURE-----

--YWfczjhUm04al3kG--

--===============0543667748544550916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0543667748544550916==--
