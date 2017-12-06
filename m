From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove
	platform data
Date: Wed, 6 Dec 2017 12:45:40 +0000
Message-ID: <20171206124540.GC1827@finisterre>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3856274686195257838=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DB05266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:45:44 +0100 (CET)
In-Reply-To: <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============3856274686195257838==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 03:20:19PM -0600, Andrew F. Davis wrote:
> On 12/01/2017 07:26 AM, Mark Brown wrote:

> > The advantage being...?  Not all architectures use DT or ACPI so it's
> > not clear that this is a step forwards in itself.

> Simplifies the code in several places, and you don't need to use DT or
> ACPI, it probes just fine anyway you normally add an I2C device.

> All we are dropping here is the platform_data way of specifying mic-bias
> voltage, which if you are wanting to do that in an out-of-tree board
> file, then I'm sure you can locally modify this driver to use your
> wanted voltage setting by default.

Then if you want to upstream the driver you'll have to add the platform
data support again.  Like I say not all architectures have anything
other than board files.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon5nQACgkQJNaLcl1U
h9B+TQf/brnfRo19q/TU3Y08GPvz7yfXRbIwVLgew91B8scsnueoO9O4CQhGIkkh
r7tEUgCXPm1BajKproRNIBzs+/MXlQCg7hF4kUikqndeEy7ngOR9yMbtQDRqeUFl
g9F9V+W3HI7iaZl04/4YV2LUikOUSyv2C/JNXeogaR8WIgLcc22zJrC/gr6XQuXW
r3pm8so/JZp8CVJPViWsI8WiMXaNk9inZCh4Ho9L4Ow+OAxXR8J78/y/1Na6mdGH
f6akDT++Qrane/Y/Z9UkiISP5m251LOo15NTMk9A6SDQBWsMycFZQWNffPgI2PL3
2dB44JTA+H7p8xwDfA7tiVKFKrnhng==
=kn4o
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

--===============3856274686195257838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3856274686195257838==--
