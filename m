From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 13:33:05 +0000
Message-ID: <20171115133305.vh6cszha753spc2j@sirena.org.uk>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
 <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
 <s5ha7zn69e7.wl-tiwai@suse.de>
 <20171115121648.jjbs4jdpjoyhkbqo@sirena.org.uk>
 <s5h4lpv65s6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7412206093971378517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33EF2266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 14:33:17 +0100 (CET)
In-Reply-To: <s5h4lpv65s6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============7412206093971378517==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aejtx35tonu6jaox"
Content-Disposition: inline


--aejtx35tonu6jaox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 02:16:41PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > I'd say either just all the individual machines like it was or all the
> > SoCs.  If it's the SoCs it prevents people making really tiny configs,
> > though I'm not sure who cares.  If it's the machines then you get a lot
> > of options but I don't know that this is a problem, it's not like end
> > users are routinely configuring their kernel.

> It might sound contradicting to my previous statement, but the number
> of selections itself isn't a big problem.  The problem is rather that
> multiple options have to be selected for reaching to the point to
> enable one feature on your machine.  So, I agree that these two

Right, just finding what you need to enable to enable a given option.

> representations would be suitable, and the usual solution is the
> firmer, to expose *only* individual machine drivers as selectable.

It's definitely the most conservative thing to do, unless someone has a
strong reason to do something else I'd probably go that way.

> (Or, at most, we can have kconfig entries just filtering in addition.)

Yes, that'd not be quite so bad but it's still adding to the set of
things you have to grind through to find the option you want.

--aejtx35tonu6jaox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMQhEACgkQJNaLcl1U
h9BI8gf/biBKqKR1t3YVAgVeAJSCQhnxpAysPmuZTWAlQMaGU+k2vVBIfYAyuFqn
+OmrlPG9DSjB5kio9pv909bhcV1Gc3ebXn6SbJSImauDBtaP/ILw6GbfrHQkJq7X
jY2OqYrxw+61AJMD8tBNe5LD37gtIp8G+p/gMxGIzuL+/Uatz00lF8N/aQ3QfphS
hy/T7yR9F81cjxIhqZN27e4vaoD1GWjINE2R4xOhS40fOAK+7/oAYywyMtdVcZTv
jgQZvIp+ybLQwX7vmvNdroOmvLxK+ekvtnBY1ozrV4VtgIm7bovCWj6EmIC3n+Aq
6l4umzTMScxv1C529RBaSFyFlqYy6A==
=wjHu
-----END PGP SIGNATURE-----

--aejtx35tonu6jaox--

--===============7412206093971378517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7412206093971378517==--
