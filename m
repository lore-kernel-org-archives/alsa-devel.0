From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Mon, 1 Sep 2014 13:51:14 +0100
Message-ID: <20140901125114.GV29327@sirena.org.uk>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
 <20140901121753.GC12898@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3593951787274946839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CCB9264F3A
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:51:25 +0200 (CEST)
In-Reply-To: <20140901121753.GC12898@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3593951787274946839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jp4gq2voFtVFKZdE"
Content-Disposition: inline


--Jp4gq2voFtVFKZdE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 05:47:53PM +0530, Subhransu S. Prusty wrote:
> On Wed, Aug 27, 2014 at 09:37:37PM +0100, Mark Brown wrote:

> > > +			spin_unlock_bh(&ctx->block_lock);
> > > +			return 0;
> > > +		}
> > > +	}
> > > +	spin_unlock_bh(&ctx->block_lock);
> > > +	return -EINVAL;

> > I'd expect much louder complaints if we try to free something that's not
> > allocated - what happens if we end up reallocating something quickly and
> > then double freeing?  Better to complain if we hit such a code path.

> "freed" is a block which is passed by the caller to be freed up. Will add a
> comment.

How would that address the problem?  Obviously the caller is trying to
free what they're passing in.

--Jp4gq2voFtVFKZdE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBGu/AAoJELSic+t+oim9VYsP+QFa6yGvF/3a0+q/Dvtfmgdb
Tuyv2AH7JpmVfmhyWOi6nKb+1fZGsr9XNC3OHEqX0cl+aCyafgE7PquHI5bqGfDV
02xHgKnspgK3NnxObKsU5NBjzd9aPmE716TJ3aCZYRenX3kaJpbfg9XCyhk8EAE7
q8Z0fRrtxQF3+6Cu6dTRsVjP5RN0W48wTl5gAawjcV6wxVModesIJUhz1IIBiavF
9reWseA7Jdd99bwGWpSRc9AH91i6nw0XNA7OWQB/DYk1aO+BcVfjViKsH/NW5Tjq
xFXCLd1andJdpL+u53wuw4waHBF6nxRiUzTxZDh3B6NCZxwJpWYtBUqt99mmaehz
iuTgr/qKXo73486y4+8L3cpdcRKMpgwCGGMcCg0rICHH0CbumoublHmHJMZ0UHWK
uKPERiz2faNcQWSTdONVQIvgatU+FaeyaxZqjctjNi7okZjcRYikos2LXYV4tihe
v6hHljs8ewCcxZEsNOP96GJ3xIZOlCjajHYBZxJO7rUQF2HzgirBfJo6d6h4QvVK
5dv9oMI1BSpecvvU5ys97kB+VAbGUNlB3Ft7HhCfMcK61YQQFUfUW8USWID305x9
BOwN7Y5rV8wzI1kRRzm4qBXyItz20e4O6dgwFa45tbWyuYEtRJM4kR9VxtEmOjer
GArhGkWLb1MBOpSCC1mr
=YlxG
-----END PGP SIGNATURE-----

--Jp4gq2voFtVFKZdE--

--===============3593951787274946839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3593951787274946839==--
