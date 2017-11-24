From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Fri, 24 Nov 2017 12:39:21 +0000
Message-ID: <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392422233751152289=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B40BD266B0A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 13:39:22 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1392422233751152289==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqqtsri5neu4dark"
Content-Disposition: inline


--wqqtsri5neu4dark
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 03:51:19PM +0100, Ricard Wanderlof wrote:

> I'm studying a hardware implementation where an S/PDIF receiver is on the=
=20
> same I2S connection as codec. Essentially, the S/PDIF receiver echos the=
=20
> I2S capture data from the codec unless there is a digital input signal=20
> which it can lock on to. For playback, the I2S output from the CPU DAI=20
> goes directly to the codec.

I take it this is a TDM setup?

> I'm a bit at a loss for how to model this in ALSA. I know it's possible t=
o=20
> have multiple codecs on a card, but those cases seem to be either separat=
e=20
> codecs for the left and right channels, or separate codecs for capture an=
d=20
> playback. In my case the playback codec is always the same, but the=20
> capture codec can switch between the two avilable input methods (more or=
=20
> less automatically if the S/PDIF receiver is so configured).

The capture CODEC is the problem here.  If we had digital domain stuff
working well then we could model this easily enough by showing a
loopback within the S/PDIF chip but that's not there yet.  As it is it
sounds like the easiest thing is just going to be to ignore the S/PDIF
CODEC in software and fudge things by telling the SoC to read the TDM
slot that it is sending on.  That way the regular CODEC will get set up
normally and the S/PDIF device can transparently handle the switching.

--wqqtsri5neu4dark
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloYEvgACgkQJNaLcl1U
h9AQjgf/WDPoVK2vCf9bgw5KaSFAR0p4eH0SYNAhCnaLOjs/60DmuNXioQOI8nnp
SwPCiFtsnsrY5R5WwnMlRpyk+u8erb2FH6RLQiWsXH0eMQTKPviOMynq2DRImtb9
JSKjP/9roxWzK30l7Lf8tnMYCg2GkWgrCCV8GUG7kQtqvi5NjxsS/RMVZVuLjemq
vVHsNO4viH9FVYkrOZlB+PfdF4EaxfSKEjyqA+GteEvOf8xMwjHGE+8FJPrO+ldD
YpwTwWGfx8tBVknkFmoFHUNjZuEUnnP3vpT8ULJaQy3DEhJunVtH52Y7LsfuqfvM
FJphJsZY155LStfHBgE6BmxEnzmg2w==
=e9eD
-----END PGP SIGNATURE-----

--wqqtsri5neu4dark--

--===============1392422233751152289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1392422233751152289==--
