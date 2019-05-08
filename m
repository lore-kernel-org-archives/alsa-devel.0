From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Wed, 8 May 2019 15:45:37 +0900
Message-ID: <20190508064537.GN14916@sirena.org.uk>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6181793911783392965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB967F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:45:50 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6181793911783392965==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQj5ySmgPRE3FKMj"
Content-Disposition: inline


--rQj5ySmgPRE3FKMj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 01:39:59PM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> > On Wed, Apr 17, 2019 at 11:40:28AM +0000, Derek wrote:

> > Please fix your mail client to word wrap within paragraphs at something
> > substantially less than 80 columns.  Doing this makes your messages much
> > easier to read and reply to.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

> > > > The ones here with comments look an awful lot like they're system
> > > > specific config which should be left up to either platform data (or
> > > > DT/ACPI configuration) or done at runtime (like gains).  Some of the
> > > > others like the pads configuration might also fit into that.

> > > We don't open the DA gain setting for user at runtime, so have to set
> > > a default level in the init list.

> > That's not the way Linux drivers generally work...  is there some techn=
ical reason
> > for that or is it just some kind of policy decision?

> Maybe I could add a gain control for the user and set the gain to safety =
max level in init list for speaker protection.

The maximum volume can be limited with snd_soc_limit_volume() but if the
limit is for the speaker then that's machine dependent anyway.

--rQj5ySmgPRE3FKMj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSexAACgkQJNaLcl1U
h9Ce3gf6A8IJRSIzjna/z/sBSwfgjCYef/wy6qNfyOI2SiYcD0f1LXUkazcQJEMx
85zW3YlLLYExDQgYSxGILENwhOUPWmur1y+8z0tqxTMMUcMq7nHaOMczKG+SgPEa
WFKf2VSgLJogCxQ9UKdDWxzNSzSTwITkPoosiuVaSiacppik9RLgQLyI3aBBqfvn
AIP90oh1sebFUdTsAryvnIJ5F0xnPWw2Pf6jur+iUZK4qOyetLXvUu39GxiRtO9n
GZv3y/7hdgk3dLBNNZSyP6X+7tgbgwJb9U9GouNy/X0OoUEwgV1VlVUtjUdN92pr
c6rkIWF+7HIL4kRWUYZ7OVN/rSZzcw==
=y9wN
-----END PGP SIGNATURE-----

--rQj5ySmgPRE3FKMj--

--===============6181793911783392965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6181793911783392965==--
