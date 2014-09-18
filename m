From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Thu, 18 Sep 2014 11:42:37 +0530
Message-ID: <20140918061237.GA24663@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4502567371364888969=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB36265141
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 08:38:39 +0200 (CEST)
In-Reply-To: <20140917193706.GU7960@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4502567371364888969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2014 at 12:37:06PM -0700, Mark Brown wrote:
> On Wed, Sep 17, 2014 at 04:25:57PM +0530, Subhransu S. Prusty wrote:
> > On Tue, Sep 16, 2014 at 12:30:53PM -0700, Mark Brown wrote:
>=20
> > > This is returning with the lock still held AFAICT.  I'm a bit surpris=
ed
> > > that we don't need to interact with the hardware if we've disabled
> > > everything, shouldn't this have some effect on the hardware?
>=20
> > > Also the coding style thing with the comments again.
>=20
> > Will fix the locking and comment.
>=20
> > Regarding interaction with the driver, the slot map is cached and sent =
in
> > sst_set_be_modules event. This is sent only when that particular BE is
> > active, otherwise driver will happily cache these values.
> > This is the reason why we don't see trigger to DSP when usermode fiddles
> > around.
>=20
> > In our model only when a particular FE/BE/Mixer/Pipe is active we forwa=
rd
> > the settings and parameters, rest we keep the values  in driver and for=
ward
> > when DAPM enables them.
>=20
> > I think we can add this explanation here at top of this file to help.
>=20
> This doesn't really answer my concern - what happens if we're already
> active and making a change?

Since this is specfic to BE (SSP) port, the DSP FW doesnt allow us to recon=
figure
the slots when it is active. These will take effect next time the BE
restarts.

Yes not ideal but thats something we have to live with!

Thanks

--=20
~Vinod
>=20
> > Power ops in SST takes care of the PM handling.
> > Following comment is already added in the code which explains.
> > "Send the command only if this call is the first enable or last disable"
>=20
> > Let us know if it is not clear enough.
>=20
> No, that comment is orthogonal to the interaction with the DSP which is
> what is confusing.



--=20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUGnfUAAoJEHwUBw8lI4NHHYcP/RSB9e3wogWFMXqitE3yjsyy
1xKh9Narxc2Ytw4FzkSkoY49WEBkUv2dD5l/Ed4gS1sPtYxCGyvm633ypNd0fcUH
g/4G1BbB7E7lqkkV5nnw/aVTTA9HkGpudVtn9OUbqaFYgkZbk2AceQxhtqaJhMnZ
PIkQEUy9jSxBCayAcQIDjBmFJoXB0r6eHK1ztuA0iIK7NSRV3aKFRpb/V2Tms7IS
0cnasRkP8dyuLB4JONwBytZ5sCg1ezw3im9NvVJmklW0zKgwtB55Yf30XtsAYFGX
VoHuRPq+yLB7Aj876IVCZIofiozm8HqsC2d3Qew1xcXIPq9ZzQXnml+3U5ce5h6e
8ba/zI3sgthqXvk0YBJVKbg35upxLMKGWQy46NEgQlJV45TEKQyK1xmMwsKIKWTl
H+2wsuHgA3i7l7nmBWWglZyGiox2EslVsRvf+7ExpuxrkL9PCdzffyGeVmsQlgZA
BMlGhpIbmOZROWjbIfW/zRqnoa4cyEnh7J3bU4NI094QMhycZkpQNKWNVQAcaTUp
qFvy8ieF6Av6Nzusqw30S9c8/mKuhDAE2uUFbLNo1A1SNkAGzVGO4AP80oc4UdEY
CxPSpJL6eT8f5/WPs//L8elr8ONsb0/cCupBfyj0ADHfewEB/fmyG8VdDkCuPWxJ
mrYpMf7HBRN2kZ5AvvTV
=qIgG
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============4502567371364888969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4502567371364888969==--
