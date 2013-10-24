From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Thu, 24 Oct 2013 10:51:18 +0100
Message-ID: <20131024095118.GH31415@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2565926223748336746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C7AE126160D
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:51:25 +0200 (CEST)
In-Reply-To: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2565926223748336746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2013 at 03:33:56PM +0300, Jarkko Nikula wrote:
> This patch adds alternative way to specify DAI links by using ACPI names.
> ACPI name here is considered to be used as an alias for device name during
> DAI link binding time.

Did anything happen with the idea of making dev_name() use the ACPI
name?

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaO2TAAoJELSic+t+oim9GTgP/24PrwPlLoxmOfCeYLaGb+Ln
NQ1zjxa+2doNNpvHV0/QH0FUtA6Rf3uyUu0Ifh98bZivPmvhkki9LY0Ov6qA6P/3
UuRFzZEPpqPAP6x9U07TDjrWs4y9WVpKkPekuUOMZnn+BdxmDbmz7d1f+EvfoBvi
2zL0vmq4ezRkkSWhZzfPzUN82CyOeuvKi2o/ffRckXTgbZBG3c70AzUfrvqGMDls
tDKLxdMc6nTRUOv+0zqLFBmI5EQxT51A00+nUknu/tC1gplD8MGGuegeWS5Zwh7D
/myL3T85qv0BbrxfsUJJK+dfMlLjKlDxF5R3VCdDUNHdBiUmRGtmKsMAE/w6HA6s
D9SNnrdsry0BDMZ8RPW0AtBZAqPwVX60YPVTtxB0aal7jugcf/XiU8N6R3zMUYXj
kK35qhTTZXqLXpM+sk58ioNR7qP8G6+wzNIjBAypXO2lDbFhkBbAoLkFNHkR2D97
E14FiYwD4QmrmeF6BviDUaD5MpiqtJ2sHDusSEyDdwCD9ZWHnZvSsPvbrmBmny0H
Qp1Zro0/6pnzs/7LhPmyPzfr2h0+VmXp1kTpixY/xBwSRZYTZ2z6KbUKK3lFmnD8
8xbePFtZSyof/FgvEpF91ysrWS28Ves7Th0lGFEiwOBmAu9ARK+ndJfKELR3J/Nv
tZxylTNnrLi/v8aeBL4G
=AVqC
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--

--===============2565926223748336746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2565926223748336746==--
