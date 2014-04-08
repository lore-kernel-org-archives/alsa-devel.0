From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Allow snd_soc_update_bits use
 32 bits register
Date: Tue, 8 Apr 2014 12:00:20 +0100
Message-ID: <20140408110020.GB6518@sirena.org.uk>
References: <1396927090-31714-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2972525703277140013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E70EF267576
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 13:00:37 +0200 (CEST)
In-Reply-To: <1396927090-31714-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2972525703277140013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 11:18:10AM +0800, Bard Liao wrote:
> Change reg's type from unsigned short to unsigned int. So that we can use
> 32 bits reg value in snd_soc_update_bits.

Applied, thanks.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQ9bBAAoJELSic+t+oim9iuMP/jJaPaW1CIDTVuk+EMHljJ75
CdRf2JqHrpglcKFQy9r4bFHEJswrZgvNQSv77JHAbgQ9IhwBuL2awh/T0VAM4rEF
RfU9D/RI+ii/o3nY+bqVVfz4p0qPnQafkMpnqB2PvkBtV2TeCGxvtWRT3xHFVU/9
T0HBgl0HqLrZNUCIQ494CtwmGFyPjAZ+tl6MeJ4TRy0mKJ+VOtOzcmT1cVy3vyOp
eaC5NvbhR7v29M8BvLvvelq3a5Lts796DG4efKpF3l5MTNOpIfmRkRrruougkkNn
mRNvOrgpfglKUVmt7A5OLVtYjxG6I6lokEosFw2/VcAr1iu9ZQ0EqcAUkBifVzC2
DRo97b8HM9N5OGeTYzfwZsDxFiqY24yIfQ0Obqj/gyyFSA7ethUaIMRI7nzgwG/r
qtRvwnoIV0Hvo7clhWGm8dxXoGPIB+CQKmLsTmho/QuzsIakrfp26P2BrDszBi9f
fj/it3IqbQQFr/wG6mlCXoGmZw+tbKb13vxKnajxvyi7jnWvLoheD8+hclG1TBQm
ia5E0WNKa85p/uhRl4J+sgIRMDDWgSZmtv/IBpaZditDLhE80CjDcdMmK8k4lyYo
WN3+jXaLJTyv1IVLdftJ4+0qh0HQ8unPe5X4etKpekd07bp3EC+VX8lDwMND4wP6
LSVFyXMLODSU7aaCP1ve
=LnwJ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============2972525703277140013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2972525703277140013==--
