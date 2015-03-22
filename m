From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: remove misleading DMA error
 messages on Baytrail platforms
Date: Sun, 22 Mar 2015 16:30:24 +0000
Message-ID: <20150322163024.GH6643@sirena.org.uk>
References: <1426883494-13640-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7370142330977839822=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC13726501D
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:01:48 +0100 (CET)
In-Reply-To: <1426883494-13640-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7370142330977839822==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 03:31:34PM -0500, Pierre-Louis Bossart wrote:

> Those error messages are misleading, there is no error since the DMA
> is explicitly not configured for Baytrail.
> Add a test to remove DMA error checks when DMA is not configured
> and return silently.

A bit surprising to have no DMA but OK, applied - thanks!

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDu4fAAoJECTWi3JdVIfQBroH/13OX5CLovbaujRKRz2xHNJL
xyng/nd5FUVLeJjWCRZfC8LqUavGKyDjdCGz0mKuH9/MEnSbvi2QimsDJ8Z5WDy+
Ov6AjfI3q3Izn4HUXiq7+AphNpKwra1AoJxJePIL1C7W0a4gx1vZifuwv6SDntVB
GEvMChUKcTGyADunl1+kXHieRjGxSq3HPoOyawh6xEJcHpP+oAL+UVbNuIUt8O03
mSQbL41o6yVNZuwbfdAmwV3YeahUd5AkWBy0A9RCruFjQ+aTuSdKGODIhnyVXMHl
+JGiPGt+h3lUIrk6MyQR8NLdldRMoVOo5Garl61Rz16HOGxtpMUISnQmmWyg1pQ=
=XX5w
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--

--===============7370142330977839822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7370142330977839822==--
