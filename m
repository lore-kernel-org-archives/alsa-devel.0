From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rt5645: Redefine format config
	for rt5650
Date: Fri, 27 Mar 2015 09:51:13 -0700
Message-ID: <20150327165113.GF1743@sirena.org.uk>
References: <1427458749-821-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2667318012628441474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11B0C2612CC
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 17:50:44 +0100 (CET)
In-Reply-To: <1427458749-821-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2667318012628441474==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2015 at 08:19:06PM +0800, Bard Liao wrote:
> rt5650 and rt5645 use different register bits for format configuration.
> This patch modifies rt5645_hw_params and rt5645_set_dai_fmt to support
> both codecs.

Applied all, thanks.

> I am think if we should use different codec driver for rt5645 and
> rt5650. In fact, they are different Die. What do you think?

Well, it depends on how big the differences are for software really.  If
they are mostly register compatible then it's just going to be a few
differences and the same code will work for both with small bits of per
device code.  If there are too many differences then you end up with
more code handling those differences than is shared and it becomes
better to split the drivers.  Right now this doesn't look too different
but I don't know what other changes you might need.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFYqAAAoJECTWi3JdVIfQLMAH/jZAoVeLkW1l2Z3bx0o90hxn
BBZnvzS3IBssmyqR26JV3rGADXT85xc5nrja+EtZtZoSzLsFHQRQegzAVFlNZskF
KAtp0f7uGeSCVUzXH+Wm4ni8YYRtj19LGJJknxY6p4RyetIWUu5FZd7HEG7QQSL2
+GyVdDKxC2nJ8sa+kqrXLWI53joosR7WuChZ8bDUeMJ+1wkDqbdqeO/QqpSmUmYV
KGu43/N3t0WQHK19BUK9fUi9tNKWXcZmHFeqwQAt4fFKVaSw9gQtQxB5C79cOzA3
nsJiVD+r2crtwJDdkWKQJFMQ+tyHicGeI5JKX33YmX62/Qm2spIwwLfbTZZUPNs=
=A9bv
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--

--===============2667318012628441474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2667318012628441474==--
