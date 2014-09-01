From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Mon, 1 Sep 2014 15:41:34 +0100
Message-ID: <20140901144134.GY29327@sirena.org.uk>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
 <20140901121753.GC12898@vinod.koul@linux.intel.com>
 <20140901125114.GV29327@sirena.org.uk>
 <20140901135702.GA14646@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1784339840116421981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5950726566E
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 16:42:08 +0200 (CEST)
In-Reply-To: <20140901135702.GA14646@vinod.koul@linux.intel.com>
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


--===============1784339840116421981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8znkWhb8vS+si4n"
Content-Disposition: inline


--e8znkWhb8vS+si4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2014 at 07:27:07PM +0530, Subhransu S. Prusty wrote:
> On Mon, Sep 01, 2014 at 01:51:14PM +0100, Mark Brown wrote:
> > On Mon, Sep 01, 2014 at 05:47:53PM +0530, Subhransu S. Prusty wrote:

> > > > I'd expect much louder complaints if we try to free something that'=
s not
> > > > allocated - what happens if we end up reallocating something quickl=
y and
> > > > then double freeing?  Better to complain if we hit such a code path.
> >=20
> > > "freed" is a block which is passed by the caller to be freed up. Will=
 add a
> > > comment.

> > How would that address the problem?  Obviously the caller is trying to
> > free what they're passing in.

> sst_create_block() which allocates the memory and sst_free_block() which
> frees the memory are called in a synchronous way. A single thread who is
> allocating waits till a response arrives, if that response is valid then
> after processing the response the sst_free_block() is called to free up t=
he
> memory. So the double freeing will not happen. Does this address your con=
cern?

No.  You've described what happens when things are working and
everything is operating correctly and there are no bugs in the kernel,
the goal with error checking is to provide robustness against the
possibility that one of those things isn't true so we can tell what went
wrong more easily than if we get memory corruption.

--e8znkWhb8vS+si4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBIWbAAoJELSic+t+oim9tKoP/2+AlY6njJ1WUERHkB8HUi3s
dS+yjxwSLyNBwCW//ImL4IfbzGQAsY06VB+M5f/I+U7sEm89YUpnqj+kdW9aFTfv
Qw/JCWjNIsrSyAhDp2I0OcwOgpRLTTd/MhWUjZY8rFbkvZOp9hnmK+vjUH4kanzt
SF5UvvDNiuZbpdXnhztgvBHpYfok5yA5+u7k+wesy6Ek/u0s/Wo/3FeMoVIXa9So
mPCKNhg9dA/Knu1l4YLR9yN5qIOVUerRPk66wyT/cXNJdSRf+D4C0rVZB72tQAGP
ZRQtbR8NxO00w/Rq3hCjLY6HvPqWB9gzv5fStTsFDKZZsbUO/fKkxNtoTJrMxvsJ
qxWWtm96q+1ZjioMpdM4OaZQiSE88MhLuwntvyjzvTH4Gm224oRt1j12DXsBL/bs
yNNFPoQxdOnlMIlwyLbcz4sgrbhGJJCHPWm76qZ8dhTOchz1tjKe960Y7gjTCtJN
JVlwtplM6LjAIFqS3VQlmZjh5DSifSSD1p6coFV8PbK3EXvOlZVNhQQeTnTihBW9
bSkxb5kAk4fmB48QSQA8VD4zEPyfVl40+6UOT1tYDF02IdMyx8rBjw3WIw79XSab
3GxteSmHT8dYMrak/XO1FGDA12bA8YU3UTQnuDapWEr37MG8Bdaw7kwVVyU9V0Cr
FWecLntAsUZjy1CnWJR0
=tI4U
-----END PGP SIGNATURE-----

--e8znkWhb8vS+si4n--

--===============1784339840116421981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784339840116421981==--
