From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: fix jack type detect
	error
Date: Fri, 8 May 2015 18:14:13 +0100
Message-ID: <20150508171413.GE2761@sirena.org.uk>
References: <1431064414-27676-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8691068026186224064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67561265DDA
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 19:14:24 +0200 (CEST)
In-Reply-To: <1431064414-27676-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8691068026186224064==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 01:53:33PM +0800, John Lin wrote:
> rt5645_jack_detect doesn't report the correct jack type consistently.
> This patch can make it more stable.

Can you be more specific about what the problem is and how this fixes
it pleased?  It's a bit hard to review based on your changelog.

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTO7lAAoJECTWi3JdVIfQLV0H/2HqHvL0+lmfvbdD3nLWTcyn
SEdmKi197A1K74omdTu074TnD0xggyrVI3Ju+tSXkdOM0wvf5vnbvmlEoLDpCtmO
m6zFSsGTzeVvop1VYDJpEyJzbDQWS4Wd0GA9tDyfzPov28cwvww92ufRcOJV61O8
kopdBMecn7DctPGvHR0PSthhgB25gum0iudglg6EUusc74XoKwDO50Jh3+ob8loa
cFBiuI6e+U4bvUZukHF1ZjeCbbsg5HXJ+gtjj8B+GsvpAzqjRXxvkFUxGerC2DOK
PEzmkIjSFQ+CyGq/uo//pW90xDUUePG8yUVMBMQeBCtVkkZgkRtx7uUQF0nuMsM=
=ylqA
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--

--===============8691068026186224064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8691068026186224064==--
