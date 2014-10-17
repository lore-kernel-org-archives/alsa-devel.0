From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/7] ASoC: Intel: sst: Add IPC handling
Date: Fri, 17 Oct 2014 15:53:14 +0200
Message-ID: <20141017135314.GQ1820@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-5-git-send-email-vinod.koul@intel.com>
 <20141017120918.GH1820@sirena.org.uk>
 <20141017115524.GS1638@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5673017184040392004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E497261B02
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 15:53:30 +0200 (CEST)
In-Reply-To: <20141017115524.GS1638@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5673017184040392004==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Content-Disposition: inline


--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 05:25:24PM +0530, Vinod Koul wrote:
> On Fri, Oct 17, 2014 at 02:09:18PM +0200, Mark Brown wrote:

> > Shouldn't this be a dev_err() or something?

> Not really.

> We get response from FW which cna be short or long. In former there wont be
> anyone waiting as all blocked ones are large.
> We cant distiguish between the two thats why we log debug message here. If
> its real then finally the message will timeout and we would see that as
> error. Yes this is limiation in IPC.
> Putting this as err makes log very noisy :(

OK, perhaps a comment explaining that the firmware generates lots of
false positives might be in order?

--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQR9FAAoJECTWi3JdVIfQLhAH/iZ8cIQF2CMj6pgW8M8wEpL0
QD/qHoTrA0mZ8ecRvIPIf28EJQHLFWjyVC5eb92snrW3lKyRZZJa9/19bS4JIblQ
tTAnGlAe0BeIdcvW1pQX+kPOvvn2LrWu2RpqTTdi0are6lIjTHfpiS5e5S8l0fDK
dEfRH8PTzza3AdO/sjjxE+Qjb7e56Hya0yK6Gi8r3dhHLaFd1ZU+f5a0p8zdI/eo
tU+64WIdpZmvCzQ260Z2csbKPP/Ua91STlOWzkievvPYRY2mUlYsNFbwSkvqgtox
3lHU4+RGlAeIVmxjXBG0ivkg2c0S2Pcxfav4u4BDpwnl19+G5vxAbKbwAgZ5vO8=
=3eo4
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--

--===============5673017184040392004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5673017184040392004==--
