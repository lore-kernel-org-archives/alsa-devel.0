From: Mark Brown <broonie@kernel.org>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Wed, 30 May 2018 10:24:45 +0100
Message-ID: <20180530092445.GC6920@sirena.org.uk>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5688105110787876417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 154492671EE
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 11:24:46 +0200 (CEST)
In-Reply-To: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5688105110787876417==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 10:35:25AM +0200, Daniel Mack wrote:

> For instance, code for Zylonite does this:

>         /* Add 1 to the width for the leading clock cycle */
>         pll_out = rate * (width + 1) * 8;

> The commit which introduced these lines dates back to 2009 and was done by
> you, Mark. Can you remember what the reason for this was? I've never seen
> sample frames with 17 bits :) This is a setup that we can't generically
> describe through .hw_params() or .dai_fmt() in the cpu dai, correct?

I think it's copied from somewhere else probably, it looks like there's
a bit of code motion going on.  I bet it was just for I2S, keeping the
extra clock cycle for the initial rising edge in the frame but not
actually required.

> So for both 22050 and 44100, the base frequency and all dividers are the
> same, which can't be right. I assume these rates have never been used. I'll
> ignore this and implement the table in the datasheet which should do the
> right thing. Philipp?

That looks buggy, yeah.  I doubt anyone ever used 22.05kHz.

> What we need, however, is a way to describe whether the dai is mclk master
> or slave. Would we add a DT propery for that?

That might be sensible, though the MCLK isn't really part of the DAI.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsObd0ACgkQJNaLcl1U
h9BlhQf+N0pHt+y7nGDtlReg51JvXQqdnK6nb/dWCgDlKvxSo/r6dXyym7yMYYDm
GlIA07yzhQj1mD6QNkJOhZvQX89OSNies6HAJ0zVCskf7WLAFgwwP2kgJtth42+8
wT+7+pZJvtOFGsmQqaqrwyZvx7iyGzwKS3Dywlv7hX+38McdFAV9YrE+6xZluRuQ
0nEbDrrC47jrx1uxpBS9+5xCigWgn+iSVnvWQ0R8KtPSKQedYZjRXw1TdQYl3JWq
G+O85xzmLXnw5sOfxWs8Stc8KK3sx5akHjD8a0wyX5KhXQNjo/Qt1kWCeiQlbHyO
loEg45bnWwfbgWwfuJ+d9NpFPCjgog==
=MBcI
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

--===============5688105110787876417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5688105110787876417==--
