From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dmaengine: Add support for BCM2835.
Date: Wed, 13 Nov 2013 16:30:55 +0000
Message-ID: <20131113163055.GV878@sirena.org.uk>
References: <527D1DDA.2040004@koalo.de>
 <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
 <20131113125111.GE878@sirena.org.uk>
 <20131113133536.GZ8834@intel.com>
 <20131113145441.GQ878@sirena.org.uk>
 <20131113143101.GD8834@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9o1Xi4ZMQ45MudWG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131113143101.GD8834-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--9o1Xi4ZMQ45MudWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 08:01:01PM +0530, Vinod Koul wrote:
> On Wed, Nov 13, 2013 at 02:54:41PM +0000, Mark Brown wrote:

> > Yes, though I think some of the stuff Martin was talking about will need
> > changes to the dmaengine APIs.  He was wanting to reuse DMA lists which
> > currently dmaengine needs to have built up each time.

> Can you elobrate a bit more on what you guys want to do here?

He wants to be able to submit a descriptor to the hardware more than
once to save on the costs of of constructing the descriptor.  I'm not
convinced this is a huge benefit most of the time.

--9o1Xi4ZMQ45MudWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg6k8AAoJELSic+t+oim9+joP/2v+7ur1ArziF81LX0Mb3ujr
fDLROLY/aglhlbTL/giThm+O/wdqmcA2yndlZIrVH5tdIJhGSurwQrkuuFNidL/v
tEu+RbPar9dKcNKJgUHYVNWkh6Yz5JxJkNQj5HV8vgVkG1XSqU82PTCH4FBUJl0l
vErAYNk2gd09dQqZ9xzIiIjbBuFbXVGpfi+VxocGRgwc5L2+NhypGk9n1w/QjcTY
wCFNcodvKg//Y9i4GZzaOoGbAqX7awZYom1LECZrNRJGjkloxDb+1Bcdx2zvAZts
RXxJayHEjF/UHrHoOgSxLm2jtmFo1v9B5H3T4+W/52k8mHMc3B2CmmmKEpTbOsCZ
pOGl9r8vddum+ZGrGdR342pDbcaWb5eVoW3SS+SNAykwAY+MJ/A4jnepLUtsGcrs
yDIXMkb2v1fmFpsu3iCF9iS+ptnzP3xcxsj2m/FVtstncA0AdgsY114BSY7EUI5C
XozE9k5xr653d7k8aQgcEJgdIu7T7Y5lTmR+WLUIaIf8ZvXMTVjISMG7Oe0z93hR
DIuvocD5unnqg5iZffAR792UpMYlW6/UTz0ubLHyDba/HfFdXTjsclT97rKNO9Od
ciiXrsWeH8+BGFjfTTcAY+WnYMMuug7DBWI14zNcNlTm75E3hNg8j/d2iTbyCD7a
AzuzjGapsEAP4zCG+wsm
=o5Dd
-----END PGP SIGNATURE-----

--9o1Xi4ZMQ45MudWG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
