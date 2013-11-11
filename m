From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] dt: binding: sound cs42l52 driver
Date: Mon, 11 Nov 2013 11:34:15 +0000
Message-ID: <20131111113415.GG2674@sirena.org.uk>
References: <1383855737-8499-1-git-send-email-brian.austin@cirrus.com>
 <1383855737-8499-2-git-send-email-brian.austin@cirrus.com>
 <20131111101621.GB21201@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4760327335611195814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C93D12608C7
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 12:34:19 +0100 (CET)
In-Reply-To: <20131111101621.GB21201@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4760327335611195814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2013 at 10:16:22AM +0000, Mark Rutland wrote:
> On Thu, Nov 07, 2013 at 08:22:17PM +0000, Brian Austin wrote:

> > +  - chgfreq    : Charge Pump Frequency values 0x00-0x0F

> In general, longer but more easily understood names are preferred (e.g.
> "clock-frequency"). This could be "charge-pump-frequency".

I rather suspect that this is the name of the register that gets the raw
value specified written to it - using the register name seems reasonable
for that.

> > +  - micbias_lvl: Set the output voltage level on the MICBIAS Pin
> > +		 0x00 = 0.5 x VA
> > +		 0x01 = 0.6 x VA
> > +		 0x02 = 0.7 x VA
> > +		 0x03 = 0.8 x VA
> > +		 0x04 = 0.83 x VA
> > +		 0x05 = 0.91 x VA

> Is this not something we'd want to change at runtime instead? Why does
> this need to be in the dt?

This is something that would come from the electrical design of the
system rather than something that users would tune at runtime.

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgMC0AAoJELSic+t+oim9P1UP/i5YRR6l3xKA6YSPtKAiGzTk
DpPUVECtgvOjQzU7QRhUVSs2vLpO5kOHkjjvA8mwvZPRRr+Xn+6bXrpweBR6c58M
y6nd9/l2nhivLgo/zCvyBEWtDUCS3D+exKKOLn3GjXMA4wS4g1U7uj7zLhlltien
jsePIILXTojzr14YdidIcwpIb6zBy1uRQe/vhMkYaPKoL4hLgEkTcgJ4jmJBGF6g
4ZjcwJG3b9IzujtbFB9B34UBsA35Y47OEUopktmNc0TCrsy4z+d6+rVFRSUmFkoM
FGzpbG5rHwarQnwi2RaoQdi1GTGzy2L1NF8kP2Kxoq9TYAJkwxxvterk0uE5Wsa1
5X9VAL5C2oXDX3tskwRHdP+dw5wG+wKl7m2hr7jJFeJ5tWm6L2tWZLZnZdVulsXQ
DC4rd+oWbLfiYjdv/hRaGF2mVDhzfkpDHGMYa5RFc9uOHQg+28H11Jdk7KZ2WcC9
LDWRXRcTkhL938zpKpIJxawrnQZBW4OA9R99pXVnvwxeO15qvGR0kxuY+ectcMlF
qUTV50H5PIFVCWWBhSMIceSw//K2ZVmgXTWJLoOmOTmrq/nbMok7dcfHJLX3Abkt
IKugz9zu4XQlozgp/UaLhbxhl3VhiyC1ciOMNTBF9Ao3Lr1Sep9n1dPznQFZWQFe
VZCVyoKagE3bfSKoDpxm
=GrgZ
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--

--===============4760327335611195814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4760327335611195814==--
