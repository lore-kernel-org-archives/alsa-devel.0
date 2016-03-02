From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Add hw_params support for hostless stream BE
	DAIs
Date: Wed, 2 Mar 2016 11:04:48 +0900
Message-ID: <20160302020448.GO18327@sirena.org.uk>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
 <1456224674.6424.22.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0464753480985311601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2074261515
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 03:30:03 +0100 (CET)
In-Reply-To: <1456224674.6424.22.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Guiriec,
 Sebastien" <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0464753480985311601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/knlCKogGKzIgL69"
Content-Disposition: inline


--/knlCKogGKzIgL69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2016 at 10:51:14AM +0000, Liam Girdwood wrote:

> The only problem we have with using a kcontrol to define params is that
> we already have an existing kernel ioctl and public C API to define
> SW/HW params. This would add another mechanism, unless each new kcontrol
> allows modification of a single param ?

It's to an extent a choice between two evils here - if we've got
something that looks like you should be able to play audio through it
but you can't actually play audio through it and need to write a custom
application to control it then how much are we winning in consistency?
On the other hand the mechanisms for discovering and running through
constraints that PCMs currently have are useful.

--/knlCKogGKzIgL69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1ko/AAoJECTWi3JdVIfQBJUH/A+vI2l4NI3NAWsBpmn3nkLM
jkqHA3cUOF+Ds/9IJUGPUwSkeb1QW/BXX84WXYA/VbyX4aHkt5ppcb8E7poJvAtM
NWTzSv9YmfQEI9NO/gEnqqq3cXhmR7GxaNgYYXwAtmPuwaeaC7Z7FZajfefYqmch
VR3j+EWHyadLQxds7QCBgItU0KzIkF4mKmcyrJGMELAqUesN2xCh8LSEShKurrcI
PgyIkb5wEtkb00WuYfGF21Qw4V9VQYdlnzfaPXOgDgYOPOI/IdpBxiq+jNZLVpzP
hKQp3rH2/46XH3xxRvjZjidVoJFvLCN61uSKhFHPFLG+IDOgLtNLPbVgTEYKz7k=
=EjDf
-----END PGP SIGNATURE-----

--/knlCKogGKzIgL69--

--===============0464753480985311601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0464753480985311601==--
