From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 1/2] ARM: pxa: spitz: register
	spitz-audio device
Date: Tue, 28 Oct 2014 00:43:28 +0000
Message-ID: <20141028004328.GN18557@sirena.org.uk>
References: <1414173005-20967-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4598999357636426733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8398261582
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 01:43:50 +0100 (CET)
In-Reply-To: <1414173005-20967-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============4598999357636426733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vrIGRKnBmQs2THAk"
Content-Disposition: inline


--vrIGRKnBmQs2THAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 09:50:04PM +0400, Dmitry Eremin-Solenikov wrote:
> Register spitz-audio device to be used by ASoC driver to bind ASoC
> platform driver. Currently old 'soc-audio' approach is used, which needs
> to be replaced with proper device.

Applied both, thanks.  If there's some issue with the arch/arm stuff I
can easily drop this or tag that commit for cross-merge.

--vrIGRKnBmQs2THAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTuawAAoJECTWi3JdVIfQ7tsH/3jePtOPjeqJo6weyEXVg1GT
9BFxiVaOVc7JKkNx3sa6Fwom/Ux8XvpgfwKpXapLs+3ys71c0qtFCIMYwPcaOaX7
4+Mx7mQ0lBS4Mry5wBty02QiMEqZdg568lzTav5O6XdgG8DRyVblchL3va0BNK7Z
qG4bdOLlCs+h2WNl9imIz+4MUp2/dYn2dnUekGGjFKYmJm/Vf/4Q/z1ivd8SHvu9
BY/cTv/VcNz5BWoHesQHPedahZb1YcKyuUnEmJ+YFAOpBxQd61yHuYywDeTRc3qT
pH4c50tqEJ89I16AZ2yKfOq6QuIyMD1bCZ89pJdtmZaftkjKFJmdphdLRWKqSCo=
=4C/8
-----END PGP SIGNATURE-----

--vrIGRKnBmQs2THAk--

--===============4598999357636426733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4598999357636426733==--
