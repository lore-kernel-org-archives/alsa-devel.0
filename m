From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date: Tue, 4 Sep 2018 16:56:55 +0100
Message-ID: <20180904155655.GJ12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
 <20180904145503.GD12993@sirena.org.uk>
 <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:10:24AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:55 AM, Mark Brown wrote:

> > you get to keep the pieces" territory.  If we really want to have a way
> > of explicitly specifying that some widgets should never be turned on
> > then it feels like rather than have something device and widget specific
> > like this we should instead have a higher level way of doing that which
> > can be applied to any widget, that is something that could be useful
> > especially with things like speaker drivers where there's real potential
> > for physical damage to the system.

> Not sure how that could even look, it would need to be in DT as only
> that layer knows the connections, but then the it would also have to
> have internal knowledge of the widgets used in the driver..

We already have a bunch of DT code that knows about and uses the
external widgets the device has (which are I'd guess the only ones where
this is an issue)?  I was thinking just have a property that lists the
widgets that should never be turned on.

> > Like I said in my original reply I'm also worried that this will break
> > existing boards by causing them to change to a voltage of 0 when they
> > had managed to end up with the default of 2V which happened to work for
> > them.

> Then only time this could happen is if they specified MICBIAS_OFF in DT
> but got the default 2v instead. In which case, yes, the behavior would
> change, but it would also be changing to the correct behavior. We can't
> avoid fixing code on the off chance someone depended on the broken
> behavior, no progress could ever be made.

I'm really having a lot of trouble seeing MICBIAS_OFF as a useful
voltage to specify in DT in the first place.

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOq0YACgkQJNaLcl1U
h9CuhAf/dmux31fp+cI7rFVG+vbv4eJGv2tb02jeXVb0zMA4sOMbcdVzSDdFEkDj
uczuKt63JFcvR/6VsoRhbVy7p1KgGLWH3eswLIPJLltgkMBpXlxzZWck7FpRHswH
JWYa2kYtkygvORR4YNdtSzQWkbDCbhmGkSNriGKJo4tfkY+PLJCLjLohHynktlYt
+Gon0wLd96yTMWWD8UJo9uJCDBdmXefqTd07IKuUFkQYNJThcBIzkSG2COO98VZD
JvvtK97wm4SQW5ZQVNrRrCDB/h6jUrSjZxtqtBLswKYrOQNxbbe4e8tH0Q4aqQCO
4dzcmmQQ0rRNFpaeu5toGpTPycy7ew==
=Ry/6
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
