From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: Intel: sst_hsw: remove kfree
 for memory allocated with devm_kzalloc
Date: Fri, 17 Apr 2015 14:31:49 +0100
Message-ID: <20150417133149.GD10513@sirena.org.uk>
References: <1429191978-25839-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7175989787287229656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71298260578
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:34:23 +0200 (CEST)
In-Reply-To: <1429191978-25839-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, jarkko.nikula@linux.intel.com, pawel.piskorski@intel.com, han.lu@intel.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============7175989787287229656==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 09:46:18PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.

Like Yao said a fix for this has already been applied.

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMQtFAAoJECTWi3JdVIfQ2BwH/3aYz9PyzaCoyuWIt9jNkqrL
yAQvNTgrULtghihzhujhCbw1fiyRiw9FesQ7I45H+6nTp+r7tOYkd2Jv/T7qtSyV
0xdRl2q5WuMln3TWXW8nFJmNao7NgNJqXvQCCEx2TCZMI8bghUKY+Nje+H4q1HSM
yCosZVW6UY2PnAuXLt/TgnOwRyp72MhxNYSHZUX9gxpwjKPLflk0AULuIfLtOcJZ
rGYgmecVB9WC4gvXaPkBY6KHvk2XdfWThwXEpWyzMZ77sU8589fFid+0NfGPQZ+G
y9ZIZGjPUV/gm3Oqxn+UpmHEpgwxlHrYEJSl7YG7R7PegrWAi+LkmGnBRuHPl/Q=
=+gPO
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

--===============7175989787287229656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7175989787287229656==--
