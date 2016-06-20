From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Mon, 20 Jun 2016 17:14:29 +0530
Message-ID: <20160620114429.GP16910@localhost>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <5763DC72.1060200@metafoo.de> <20160617121548.GI16910@localhost>
 <20160617123156.GO26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4933449780604757965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A80C26507F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 13:37:55 +0200 (CEST)
In-Reply-To: <20160617123156.GO26099@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============4933449780604757965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Content-Disposition: inline


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 01:31:56PM +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 05:45:48PM +0530, Vinod Koul wrote:
> > On Fri, Jun 17, 2016 at 01:18:10PM +0200, Lars-Peter Clausen wrote:
>=20
> > > Why and why is this something that other cards do not need to do?

Other systems do not have a DSP sitting and need to redownload code which
takes time and results in card being resumed even when the platform is not
ready.

The logs are indicating the snd_soc_resume() is triggered even before the
platform resume has returned which needs to be avoided.

One of the ways to ensure a dependency for PM is resolved, we tinker with PM
callbacks here to ensure the platform is ready before resume is inoked here

> > When card suspends, the DAPM suspend closes the widgets, which translat=
es to
> > we sending IPC to DSP for tearing down the pipelines.
>=20
> > So we need the platform to be suspended last and resume first. This way=
 the
> > snd_soc_suspend will tear down pipelines and snd_soc_resume restore tho=
se
> > back.
>=20
> That doesn't answer the question - this applies to any control
> mechanism.

Thanks
--=20
~Vinod

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZ9cdAAoJEHwUBw8lI4NH5mwP/2TThz7CYtj+z5tZFvzmQbkC
MtivVXa7ze+VEyfcX810sOc2amvUV4CUQCtsbA6XswJukF/eFJ52EeugFWZYS4nO
pv1M+I7Ix38F5rF8YV7rgWpbvDaa74Y8efvrgnsAnikUxnSoo2G0g/K5oDQ0//Dh
DKjfDikZvZazQPlJ3tQwD/bdkqVl5jQXcZTB7/hUXIURNb6jtC28kzjDFBO0yRgf
WQWD80ABopk+7GyiCuyuIm6MEfQepcbTmr98kXWJHNx04F4vcoqP8UEmUicU5g6p
8pzllb/087c3sT8GcHqktzLf3Du9oN0X0njhsmqBnyhEIx2Sc7zwHlsTRebjn0Sk
XDn5h8Q1c5EJrheeeJbUFdDV+qqrw7XDvp5+at7mcOQlen7M3AgSgN9vNbtFORY2
l2yPJRVNnlVORNH/Z/AcmzKR+Ks4dLt0Z+YhnDaUe5vE2agT1JnSOb+YvNPyqix7
DFdUAGMCBgXtyrp149MS23XMRqPrTDyFxD4p4lnfT9WC6CTdM74mgQWPSDRncgi3
YwMp+VIEfVNhdTmy2jLTGG9hCwlR8sYn6sXPPayeAtU+6AvcW6TPuQGT27kbohtQ
PdoDLcHXdV2DP3kLwoNNjvoPxS9FVCybEX5JXk5as86Q57ZFX+jkv3lLju+Pubtx
pUpKkYO55ogs8RDhZajJ
=Qr/7
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--

--===============4933449780604757965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4933449780604757965==--
