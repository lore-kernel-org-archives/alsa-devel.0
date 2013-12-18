From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be
 mixer widgets rather the PGAs
Date: Wed, 18 Dec 2013 16:19:02 +0000
Message-ID: <20131218161902.GW28455@sirena.org.uk>
References: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131218112739.GH28455@sirena.org.uk>
 <20131218131436.GE11138@opensource.wolfsonmicro.com>
 <20131218132343.GP28455@sirena.org.uk>
 <20131218141423.GF11138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1365231142460046799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A77A261684
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 17:19:05 +0100 (CET)
In-Reply-To: <20131218141423.GF11138@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1365231142460046799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IssJQH/X6nZGf72c"
Content-Disposition: inline


--IssJQH/X6nZGf72c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 02:14:23PM +0000, Charles Keepax wrote:
> On Wed, Dec 18, 2013 at 01:23:43PM +0000, Mark Brown wrote:

> > Not the physical output, the DSP output into the rest of the device.  It
> > would be very surprising if it powered up making noise.

> Regrettably, I don't believe there is a way to mute the output of
> the DSP. Muting the physical output does fix the issue.  I could

So the DSP powers up outputing stuff?  That seems like an interesting
design decision (it might need something to reset the buffers on power
down I guess).

> look at seperating out the physical power up of the core and
> starting the firmware to be seperate widgets, that might also
> fix the issue and would mean the firmware wouldn't run until the
> input signal was clean, but I am not sure if feels that neat a
> solution.

That sort of split is something I'd considered doing in the past anyway
- it would be beneficial to be able to overlap the DSP startup with
other activities so the delays while bringing up the outputs could be
happening while the DSPs are downloading firmware or the firmware is
starting up for example.  You could also overlap stuff with the RAM
startup if that's now taking longer.

--IssJQH/X6nZGf72c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSscryAAoJELSic+t+oim9KggP/AhJyDULd4NXqq39BqRVdrwQ
iNw4JxGRPShGXR8TVcvYZMFNFEnMrrUjUhq5u1YY9Z4VyGWZAvZQellUQGOBns7L
BUaxTzc9k8FEA+l95VmRvVrp7t/vOG4cQGFBxT+uTuiCb06YjklX3dPaQkAFcFyI
Hrw/KNE88fwYJQM/3d6YiQx6GcOJLnqFSbch5gk1n2FuGBgeVQuObSzJ8NDpb4yA
OJPFCOu3dQaopDrfhfPmVKTvZtUbyEMmDHY1rrzpA5t4QHme6V6mc+9O54qlCnSX
U6Je7DSIdsD/DZ4n4v31L6ZkVwmKACbRT+6MOXWDPLd6x/9D4nXDGQlYkUbSXrj3
u2IH4CmZo9by1w8vKP/z5zPV4Q7hyfcsED/TFF8e3jhBh1RVxPEaadwVMglvkabi
rQ6yInwCqU9Fl35l7h5NLVqyfjAd9aDsN22ORyT1mGn+XJmUj8VbNqr/JkxCpIgt
16zAbbiq7zt3uv1yvas0cqtf6ytFGZvFwg9il4kXPsj2HgUSGYlMdHJkp8N+u4gA
U281efDTY7DxLC3O2z7t3LrXZf/xCpaquUC8KizjTX8tA7p9mTKOgBTXE9/hq0R4
xHLkaEaz0A/lwqSoi2fKofVLBEYLdCV0VXts548rgP6p+hI0mWOx7O+MrPNX7JfG
AlopxRJnJo+FpW4z7tDO
=mYiF
-----END PGP SIGNATURE-----

--IssJQH/X6nZGf72c--

--===============1365231142460046799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1365231142460046799==--
