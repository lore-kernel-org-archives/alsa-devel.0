From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Wed, 11 May 2016 18:15:06 +0100
Message-ID: <20160511171506.GQ6261@sirena.org.uk>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk>
 <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk>
 <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk>
 <572FFCA7.8030604@nuvoton.com>
 <20160509163528.GD3458@sirena.org.uk>
 <573152EB.5090906@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3509510322264903342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 645362607C8
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 19:15:14 +0200 (CEST)
In-Reply-To: <573152EB.5090906@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3509510322264903342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aNvCJ41Feu8IgPyB"
Content-Disposition: inline


--aNvCJ41Feu8IgPyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2016 at 11:18:03AM +0800, John Hsu wrote:
> On 5/10/2016 12:35 AM, Mark Brown wrote:

> > Well, the machine driver has to cope anyway.  What's not clear to me is
> > if the device *has* to use the internal clock when doing accessory
> > detection or if it's just lower power.

> If the codec only does accessory insertion detection, the driver can setup
> it and doesn't need any clock. That can make lower power. But if the codec
> wants to do advanced jack detection like mic or impedance, the driver needs
> the internal clock to setup auto detection. Thus, when no headset connected
> yet, we use the solution without internal clock for power saving. When we
> want to do advanced detection, we use the solution with internal clock.

I'm afraid this still leaves me none the wiser, sorry.  If this
switching to the internal clock is essential to the device operation
then I'd expect it to be made transparent to callers so it should
happen transparently rather than appearing via set_sysclk().  If it's
not and it's just a performance optimisation then erroring out is
definitely excessive but if the optimisation can be implemented
transparently then it might be nice to do that.

--aNvCJ41Feu8IgPyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM2iAAAoJECTWi3JdVIfQLZ4H/0SH9kKZFewLoenp392A48sI
bivXsge/GOI13T2TncYv2U5PK5lMId/Qlamejx3IaAn0OX3tZgPBc5fPU/Mgcuqb
K2TdYhbEQvclty8qm5KPmhxwU/jPZMRuABUuDZck7NUluDVjLafJ/g3Eu49pNUJa
U5ylE16Y6NdAaFHEhtHsj3qY+aojcsfXGmdK3wasWd2GAJVNRNVvnUcJT2rrcDlM
oIs5SGdTw4XaGdFu6+V6JYeF0uXDAcjuVnRqBCTqXr2CEKWm8brz+D8N84xD25kJ
9XjY7bLbOG3UD4/l2v1+ypKYFuPLMedYGyqQjmJoHULGTU9M5LJxom4y8ij0VIs=
=4h+y
-----END PGP SIGNATURE-----

--aNvCJ41Feu8IgPyB--

--===============3509510322264903342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3509510322264903342==--
