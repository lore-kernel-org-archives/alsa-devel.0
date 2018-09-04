From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: tlv320aic31xx: Add
 headphone/headset detection
Date: Tue, 4 Sep 2018 16:52:31 +0100
Message-ID: <20180904155231.GI12993@sirena.org.uk>
References: <20180904153619.2199-1-afd@ti.com>
 <20180904153619.2199-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7380146473009269928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A092676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:52:31 +0200 (CEST)
In-Reply-To: <20180904153619.2199-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7380146473009269928==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:36:18AM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This doesn't apply against current code (even -next) - please check and
resend:

$ git am -3 --signoff /tmp/fnord
Applying: ASoC: tlv320aic31xx: Add overflow detection support
Applying: ASoC: tlv320aic31xx: Add headphone/headset detection
error: sha1 information is lacking or useless (sound/soc/codecs/tlv320aic31xx.c).
error: could not build fake ancestor

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOqj4ACgkQJNaLcl1U
h9CxMAf/THZWb0/SH2oJMu2w92+xy94natUzhfHOQ41peMsly/Fzmf18Qt/gvGcp
FryEEJJW9Fq4cqX8UFR2oy5YxdJZT7CuR7POKZ6Cq/TuA7A7fP9LK9tHA1mE5YWP
q3ExUgdxQJ5kRmF50t2lbp95LqZgRK7dXjEtqiLgdo1X2uAyyEkHlnuu/WQ6DxmD
KVmrVFTpai6txY5j46dCamqOn8zsyBFoMLJ69hWdFw5XqJYvcla8c2VKtoleIsZS
aK2RvcGjdRs5epsGkP5gis7DJ7dXkRbt4cpVHu9tg+J6C4Iqjz8v1bU1GE22EdW6
Zc16ylStjAWBlzbDkfZPtpth16XgEA==
=ONEw
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--

--===============7380146473009269928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7380146473009269928==--
