From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Sun, 17 Feb 2013 18:11:45 +0000
Message-ID: <20130217173015.GD1583@opensource.wolfsonmicro.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
 <20130213131917.GF5062@opensource.wolfsonmicro.com>
 <20130215071000.GA23031@oma-dev>
 <20130215121727.GD22283@opensource.wolfsonmicro.com>
 <20130217063725.GB23031@oma-dev>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2456974947431368877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 542CA2625E2
 for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2013 19:11:53 +0100 (CET)
In-Reply-To: <20130217063725.GB23031@oma-dev>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Omair M. Abdullah" <omair.m.abdullah@intel.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, lgirdwood@gmail.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2456974947431368877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 17, 2013 at 12:07:25PM +0530, Omair M. Abdullah wrote:
> On Fri, Feb 15, 2013 at 12:17:27PM +0000, Mark Brown wrote:

> > It sounds like all you're looking for here is a better debounce
> > algorithm, for example one that delays for a bit then starts polling the
> > GPIO state at a higher rate and declares a result when the GPIO state
> > doesn't change for a few polls.

> We are using a polling mechanism in our system to check the jack state a few
> times. But what we observed is that we always get a bounce.

If you're already doing that then this is at best redundant and at worst
will make things worse if you do happen to hit a case where you don't
see any bounce for some reason.

> Also, we do have a system where we are using the snd_soc_jack_gpio code for a
> codec interrupt through a GPIO line, like Ramesh mentioned - even if it is just
> for re-using the software debounce mechanism. In such cases, the interrupt would
> be triggered on one edge only. Maybe that is not the original intent the of that
> code?

What you're describing does not sound at all sane, the GPIO jack code is
there for managing GPIO jacks not for providing a generic debounce
mechanism for interrupts.  I'm not sure how you'd actually go about
doing this...

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIROuAAoJELSic+t+oim9n2oP/1ODlIvKE13x1/6LZ7H3CgPa
pNvLeQQaRBylPT2zXh7+NnqVrW+peHuFRy4QCmFjKgc7V0glxk/FlRrAj74XpoH8
PLBJ5jaDTHc1Hd3LN3llHjJHiZbh8AlLAP25yClLevCfyJtr8ux6YxF30cKkBK93
Jie51Z3FDfdzN/EyK+QmKXA0Yk3sgXJ4yWKo3r5zFuNBVZs/X2NeZZ6CLjAJGROl
osUozVF0SmlrDkApU8Vg8cY7vJZH3NdRyzGj3Xha6O5UXKU/NW+Hv7epSfBveTjq
8Q6XXSF3K9KQrusCoFuucYprHi9DdIC9FIPbj4xUdK3KXIVN8dUTBNv55Elwbi9A
qPVos7zxGxbtVqzE4PlVx84hceGvYeTng3ndwKuJ9pua/hlGQfutzZ9tOdzvrBVL
tn7kpWDGld3p+tGD4jyPRYWimCMGtZF/Npcr/eMTBLam9Ub2Y+jJUZTmlHynv7aE
Z/u18wr5d2OShhlsiae7OqUlbtKzd9XQ1HoT1LaMWV2ezgVN7LWtcWrp6/efvV1c
xTdc3FSDOz5RXrHcShsZaYNbCUuuK9FmMgeHz9dRbDxPfIUS6vSCFe2cXQm5BKeO
ty1eYq689XplCEFSyOIbUSBNvaiIYJKcbYgJ7D3+JXlHEU0bMZY2855VTuga3Va+
CLNURDqodscCDOX+/kBF
=FjQQ
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

--===============2456974947431368877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2456974947431368877==--
