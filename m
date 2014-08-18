From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 05/12] ASoC: Intel: mrfld: add bytes control
	for modules
Date: Mon, 18 Aug 2014 09:25:33 -0500
Message-ID: <20140818142533.GA14537@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140813200012.GO17528@sirena.org.uk>
 <20140818053609.GD14041@vinod.koul@linux.intel.com>
 <20140818101514.GA29250@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2878586125579204651=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A11265AD7
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 16:44:21 +0200 (CEST)
In-Reply-To: <20140818101514.GA29250@vinod.koul@linux.intel.com>
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


--===============2878586125579204651==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eP8xGX2lG1UwfyBj"
Content-Disposition: inline


--eP8xGX2lG1UwfyBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 03:45:15PM +0530, Subhransu S. Prusty wrote:
> On Mon, Aug 18, 2014 at 11:06:09AM +0530, Subhransu S. Prusty wrote:

> > > I wouldn't expect an info call to be allocating anything - why is it
> > > doing that?  It's not looking at the alocated data except to see if the
> > > allocation succeeded.  What happens if someone manages to do a get or
> > > set without having first done an info and why aren't we doing any
> > > allocation on initialisation?

> > Will move after control initialization.

> As I have to initialize the params, and if it's done in probe after
> control creation, it's required to iterate over the controls list and
> match certain pattern to find the control and then initialize. This doesn't
> look elegant. Instead I would prefer adding an init callback in the control
> to do this operation. What do you recommend?

Something like that sounds reasonable, or doing it when writing to the
control - the point is that info() is a terrible place to do this for
the reasons outline above.

--eP8xGX2lG1UwfyBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8gzaAAoJELSic+t+oim9rZAP/1fSQcgjM8CZ02L/i7qiCpdl
N4szEN8cJKo94zllkRpVuUiMzhtwXy0zrXVgI9hYTI5y7jcCqbfoSZxzJSw/H4YY
QA+baDhXURdjLBR6bmFgcvs/iB8X9WH79Yf0XW+FjLT714lvIxZLt130pXqbNv0r
6FxEYfiLAXx7KBwF6RhU3AS60fe5YO+FlbpjVmoXcDgI/74f+LofyEa2YiNGK9kx
c8cXI9A0arD0ycJf+RaMgNgoANM0ZuH5ryykxHfL8X7RHlrgIgl9v/YmyyTPubIX
McgpEk+6BvnxF1obxAVwxvim8GJjoutk0uGXr23s5MaxpY4qB2mgDHSMIWWkaZef
F4KzNOtli64LHC8gWzpHz7eKHrm27hLhwZjN036L737IIdVAW4eYQk0QmPtFsPn9
EVw49vcAqHoaq9eX0JRCRDrXiZ2awHmyjGnc1uDsni1c/ikgJvCFfyJ6GnnQ9/Wk
tdJmlcd7AU/FiW992C3ij89rEnQfgdlkvPwkgQfIH+/n8vroL2dS+s97FA57cp0g
kl0ybGQWHl4Fb/a3vWBxGj0ZM442w/S76Nm6fPtDm4AWAjrnkwrxV3CXefAyDZwG
Iqn+gLwaf7fyz7PXiCYbHNMRM2xbsWB5DVV+rGdd7I79Aozj53ccWF6eTRvLMdW/
YeCTPMWpdbe+95WOqOAn
=WcOq
-----END PGP SIGNATURE-----

--eP8xGX2lG1UwfyBj--

--===============2878586125579204651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2878586125579204651==--
