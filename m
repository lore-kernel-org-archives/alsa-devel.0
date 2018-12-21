From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Fri, 21 Dec 2018 17:33:45 +0000
Message-ID: <20181221173345.GF4996@sirena.org.uk>
References: <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
 <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
 <20181221105741.GB4996@sirena.org.uk>
 <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2623312514055324709=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 991DE267AC2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 18:33:47 +0100 (CET)
In-Reply-To: <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2623312514055324709==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 21, 2018 at 03:05:51PM +0200, Dimitris Papavasiliou wrote:

> without pushing the changes upstream.  You can see the patch in
> question here:

> https://github.com/raspberrypi/linux/commit/c53a137bd151130e29d7fc43947ac3e579a29ce4#diff-723fa079c49ec85d48e290fe84994b36

That's a change half implementing TDM modes with the goal of allowing a
bodge to force 32 bit frame sizes where that's required to get clocks to
divide out neatly.

> I can apply the patch via merge, so bothering with this is not at all
> necessary, but if this change is useful, perhaps it's worth submitting
> another patch for it.  I doubt this though, as it looks a bit hackish
> to me.

It's useful (that's a genuine issue) but it shouldn't be bodged by TDM
mode but should instead just be done as standard without the machine
driver needing to do TDM - check if the clock rate required is actually
generated then fall back to a less exact frame if that helps.  That way
everyone gets the benefit without needing custom configuration or code.
Basically it's doing the right thing in terms of configuring the
hardware but should be triggered differently.

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwdI/kACgkQJNaLcl1U
h9BVHQf7BfCqGq/37YGOlwYO9xmLl5AiX/k0j0mf0I38rHZnmZD7FK8QXTShn/Sp
XAnIH+Qe9s223nu6LiYw0txH1RdiSYpM7Vl2f00bz0DEdhMxJdqe4xQ6Wt94cXYL
xv5fuavPFuFQEAsuf20WuzwH3QgFqly1a1JwtoaiLfzF0FWj8PCesCwxfEUqH5N9
J/HBMs8m/BRS4ZJzbMPzn3h5cU+PXO6Pn2NaMxpxKInzVpNCOd6O5N+HDPZinor8
BQDocCWzvn4EKlUj43zJpydsIz1vhDSH6b0Ir2v+XQlT0sEYqrtzhmZuz7yYutLD
HEUxDaEAYDH0HphnWeNu4426NCVK3Q==
=jL57
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--

--===============2623312514055324709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2623312514055324709==--
