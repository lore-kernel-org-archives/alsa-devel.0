From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Fri, 4 Apr 2014 11:06:29 +0200
Message-ID: <20140404090628.GD474@ulmo>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <20140331192349.GA3431@mithrandir> <5339C638.5030303@wwwdotorg.org>
 <20140331224520.GF2269@sirena.org.uk>
 <5339F205.50403@wwwdotorg.org>
 <20140331230517.GH2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124915241449175696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1FC26574B
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 11:07:13 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id v15so272596bkz.33
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 02:07:12 -0700 (PDT)
In-Reply-To: <20140331230517.GH2269@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============2124915241449175696==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2014 at 12:05:17AM +0100, Mark Brown wrote:
> On Mon, Mar 31, 2014 at 04:53:57PM -0600, Stephen Warren wrote:
> > On 03/31/2014 04:45 PM, Mark Brown wrote:
>=20
> > > of_match_ptr() is supposed to avoid the warnings that the ifdefs fixed
> > > more prettily - I suspect you'll find that the ones that don't use it
> > > either predate of_match_ptr() or copied something that did.
>=20
> > I believe you either have the ifdef and the of_match_ptr(), or you have
> > neither. The use of of_match_ptr() is required when you wrap the
> > struct/array in an ifdef, so that the struct/array is only referenced
> > when it's declared.
>=20
> > I guess from your response you want the struct/array wrapped in an
> > ifdef, and to use of_match_ptr() when referencing it. I'll go ahead with
> > that; no need to reply if that's what you meant.
>=20
> No, what I'm saying is you shouldn't need the ifdef any more if you use
> of_match_ptr() and that's the more modern way to do things.

But I don't think that's the way it works. If you drop the #ifdef around
the struct of_device_id table and use of_match_ptr() when referencing it
then you'll get a warning from the compiler because the table is in fact
unreferenced. So all that of_match_ptr() really gives you is a way to
omit the:

	#else
	#  define of_match_table NULL

So it doesn't really give you all that much in the end.

Thierry

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPnYUAAoJEN0jrNd/PrOhYzIP/ApZwKbMd3sn/PrBv0n4xgno
ZBV3n21uttRLY/RP1wYdqbKjcgJL9Xec0bW3HkUdscbVDIVn7/oU42vZy+116ofG
cI4mDUgIPIJF7FmOWIsVh5bc+J9a/yyUaBpDarvU8MIHhT5ERJxfNVvAp+u48W7T
fUktwLNrX6wDT3TwiweGIU3rcBn+wMPLeJCtQL5EBkmX55cZVbnu0ipTH7VNBZGb
uc/IEqB5wufAhi+gu0nnMT/MNn3z12awNUwv33O0eJtdT7o+Ewhec1mm7JayO6Gr
tPvCfFVFYKQ4zijGtnuIa9HKl4yEKRdtMI6Lt3NX0NlGU5Kak+c9GKK3sRWlk6Md
bsR4Bi7Wj1g9B9UIsI580nKRC/wSgNpDKGgUTvmTRn8H2xGzirDjQ+OXXY/OASQM
wpN+9xYV8x548AgPJ9EC2XtGuXsfmLu8jSaQEvOtYqhM5qKeGMhhKTX64X6GbCo0
vay31bXcuSbnCB9AE3KS34aVJAa09CmGsqVR5DwWf3P2b0EleU4WMk6T77BGzPfq
+ijRq35XXlVImA+/MTAC924JPKTKYuAHnT/Ac6NIyjay+ueVJ7A0bCmCm3PamaIM
u3+KYSkcWMYOY/4Dq01hCMEE/yVwnzP+n4dKM+rpT44qnCIkZOu9eVVyM/1Xih5m
9+q5fvYjE/AmVVRWaHWC
=Vnhr
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

--===============2124915241449175696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2124915241449175696==--
