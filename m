From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 2/2] ASoC: cs42l52: convert platform
 data config to regmap_update_bits
Date: Fri, 25 Oct 2013 10:07:34 +0100
Message-ID: <20131025090734.GP18506@sirena.org.uk>
References: <1382624947-10678-1-git-send-email-brian.austin@cirrus.com>
 <1382624947-10678-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4517770756473330209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4240C26550C
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 11:07:49 +0200 (CEST)
In-Reply-To: <1382624947-10678-2-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4517770756473330209==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 09:29:07AM -0500, Brian Austin wrote:

> Moving Platform Data config to bus probe and convert to
> regmap_update_bits. This will work nicer when converted to device tree
> instead of having it split into multiple probes

This also fails to apply.

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSajTTAAoJELSic+t+oim91G4P/ReRNHAcu2tgrq9yB3v12nj/
ZED4RcaTZXOSGQWeSbeeczwW4rl6IJne3LGdTYaX1CMyQrNThhG4Ogk6HbV191eL
9TevCQda5rqf0UkgA9qjlGyOOYOJkMzwle/d/pdWfzi1CU56qsutwdFMoHYxsfST
QQfPAXqSTIHv2hcwYyT+2gMY8oabnqvJYk+esjL5kZZ6Tpi6HYkPBMzEAqVgGk85
z3GEuFy5kCoVFUlUh16TPsT5FnDyfvNFxte7hznqTybg9QESdHzEhivDeSXrMPkr
rLlOz5sn2eObeYUVvVNxpL3+E7rOWgO0EGyn5TblMW/c1lc2sfdpcSZdfnCdfr/l
qAWAaL6T5WekPzsl/1bjd/VFgPRQJcLlvXe9if254p+8EqDYU0f7aIRlfqMtz2JZ
Hg0wo5Vc0uvBQdpaVnBzAhUhtddr4v5I+ofvg/MJmWSo4lBEP9MAZc193L8x9pBt
eIY5ExxcpOIASZTT17nPFB7XBK4ZCakNZza0IrvEdkhvsAkexZN59XBAOSPiDlvr
u5H5wmJKX1Vwly6Krcp37kAs6ZoDhBo6V0eSrUVfKejV7OMDYk0OW8qWFQjIbmaE
ZvYHY8SgXB4KpjfXCFqUhaSBxTMGS1+aZufkGL0obQ7FxxKsGLn6nAMhAX/vVHfz
MM6SPoXMV+Tl3Q+S8lHL
=scfq
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--

--===============4517770756473330209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4517770756473330209==--
