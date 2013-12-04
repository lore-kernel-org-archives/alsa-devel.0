From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement
 symmetric_channels and symmetric_samplebits
Date: Wed, 4 Dec 2013 10:42:30 +0000
Message-ID: <20131204104230.GD29268@sirena.org.uk>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
 <20131204072702.GE8609@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8249171659806284782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A64AB2625D3
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 11:42:34 +0100 (CET)
In-Reply-To: <20131204072702.GE8609@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============8249171659806284782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:27:03PM +0800, Nicolin Chen wrote:

> Sir, shall we also implement these two to other drivers like codecs?
> I know this symmetry is a new feature and might be still immature.
> By implementing it might bring some side effects. But meanwhile, it
> would also allows us to engage more people to test it, although myself
> have done a branch of tests with different user cases on my platform.

> Or we just wait for people engaging by themselves?

It makes sense to roll it out, since it's in the core if there is a
problem we only need to fix it in one place to fix all the users which
makes life easier.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnwcTAAoJELSic+t+oim9Xy4QAIWP6FbvgVh8Utw+PUNowHOp
NELcvB32ZsJfyos1dDs7IZfrnzvUW9lXcecTcx8PnPn0dryL08SkVV96ezalsPH5
DbcV8aAPKdRc3vYSKZAXB7W8b6sRgvLkOVJPS8Kqi7B6d0WcvWPfoE0Pn/J1sbxs
p9sIKE5Q6UwHcmxgKRo/PinZnTxot36bGSVFglxXpEcwIR4EBv/TxURMgDX0FV6P
kvlZrcOJti29WYsaSw/V9JHvIeRKnmQIKnZY+xN8ucxSpb2dmm3oeHwof/ci8BUi
iXPmMuhJnwcjH3OdiL19pwr1HHq311SHOFFsmmOTqGYX8BUTdjQSLgHVk/OdvV0w
QnLDfuK4LXqrA0ki5vqzw0ME4JU7vxRl2y/lG+QpQqSzIOXuuwy65aJ+MfiyD76g
HEZyvjcvacVhsuKOfnpe9MKU7CxxkkOIcb2IZI+S0K9jfBEjRA0brFX/hqMJLhke
PRkk6Leee5KfV9PmGIR9k2sQlqfbqxaF42HGwREpha5UOQAg+fm9oWgXt6Brk99X
LaVBIOX/cTZfhMqlfTWO5qwY58A72QzqNm8dJBqUKx05XtAEZJ2j0y12+N6Lu2vc
SW3o6ORBCckXGA5A8KywEzoca7eC1rcMxK1j/3VpS0aR+fN336HZyyWWDup3cKqO
XvZ9aGF4a1xNFpDmcpV0
=ufv+
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

--===============8249171659806284782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8249171659806284782==--
