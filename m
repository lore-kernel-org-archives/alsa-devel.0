From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add Merrifield machine driver
Date: Mon, 3 Nov 2014 21:28:56 +0530
Message-ID: <20141103155855.GA1870@intel.com>
References: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
 <20141031171127.GG18557@sirena.org.uk>
 <20141103050158.GL28745@intel.com>
 <20141103120750.GD3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0334201908082961885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A7E902604F6
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:58:18 +0100 (CET)
In-Reply-To: <20141103120750.GD3815@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0334201908082961885==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 12:07:50PM +0000, Mark Brown wrote:
> On Mon, Nov 03, 2014 at 10:31:58AM +0530, Vinod Koul wrote:
> > On Fri, Oct 31, 2014 at 05:11:27PM +0000, Mark Brown wrote:
>=20
> > > > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
> > > > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
>=20
> > > Two buttons both reporting the same key?  Might be worth a comment.
>=20
> > Okay loooking back I am not sure why we added two here, let me check and
> > clean this up.
>=20
> I was assuming it was because the tolerance desired on the button was
> wider than a single detection range on the device so this was ensuring
> that the button was reliably detected.
and thats is the changelog i found from our old kernel tree. So will add
this coment here...

--=20
~Vinod

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUV6Y/AAoJEHwUBw8lI4NHnYIQAMMvf4NNmjO2ua9Ha6GQ7P8/
KMB/Adl2kkf4pSLcfKTiPIzbCbox6Tic2YjtQKI5/GbhavufUlFVcbRDQiJ9rxjg
oh1McxCQXrJ8KKY7JSG9RLb3YK0nBCj9YwS7fal0E6j94YteCBzz2X2Isdpn53gb
KeIK01V6HyBvV/zo8Y5PrWa9g0wIJAbvQs+uTN0WGMMu50jNuW1ENvEptBGaxLcd
9zhR/Vm5GFQoq3VyMXz6sMbLyvFEgQqGp8Rcxm+9duIkz9lwoMP9Uqp15gX4mujc
bVsDJGGPSbssG4zfMKaoMztkRrR38RiN7PkveS5I/mTN4GfjIndgH7IpvCwTo2R2
cM5+NlrZAdDl6RN6GJcP2vUTCeovhHOf2h63xZs4wwrp5CmxYeRy47kYE2dCZRLw
XfNy700bEQaScpmzgJ0/FS49Iozr0b68U53uNKsfLY9aUiUMn2aCpBje1t1wZ1tl
K3E+wJ5j0Zwr6K+Tz1+y5NmfoZslrdD2Y7S9vQJ6+yy6qNo4YKm3LugcTK6gxpJg
+wtFnGFgsjtW1vTujbeieJ2VXLsO0RjX1wXl3jkCbJwaSRIpe3Jt4p3vrzlc8ylJ
h77AmYAZgremMeWLoBi5ST1YWIAffjAyD6T3Tg0MmdyIya/9LLwVHgunQO+rSxLy
MIphy9yxPaRkzKXhAxOV
=Pi6A
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

--===============0334201908082961885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0334201908082961885==--
