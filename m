From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Tue, 3 Jun 2014 11:14:33 +0530
Message-ID: <20140603054433.GX21128@intel.com>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <20140601192649.GQ5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0768759485207422999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 808EC26528D
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 08:02:11 +0200 (CEST)
In-Reply-To: <20140601192649.GQ5099@sirena.org.uk>
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
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0768759485207422999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2014 at 08:26:49PM +0100, Mark Brown wrote:
> On Thu, May 29, 2014 at 03:33:36PM +0530, Vinod Koul wrote:
> > The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So =
when DAPM
> > triggers the widget, the DSP needs to know the kcontrol values and pass=
 on to DSP
> > firmware, so export these for driver use
>=20
> I have to say that I share Lars' concerns with this one, especially for
> the set function (which doesn't quite gel with the description above) -
> it may be that this really is the best solution for the problem but it's
> not entirely clear what the problem is and like Lars says there's some
> other stuff in play here.  If there's something that the core just isn't
> doing that any driver trying to do similar things is going to want we
> should fix the core instead of requring drivers to do work.

I don't disagree to the concern but as things seem to be today we need these
handlers. Yes with the componentization work by Lar's this may not be requi=
red, so
I guess we need to get the componentization series done first and then revi=
sit
this topic.

In parallel we are trying to test bits to see if we can do away with this
assumption. Stay tuned...

--=20
~Vinod

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTjWDBAAoJEHwUBw8lI4NHKNUP/0USfvdiZL6hSfLGi9WWxbeq
jayQyu4gxDUWrtxD5+q72ZOro8gPm2Or1q6Cboc4zcQVM0TQKPKYFp3cz9d1IqMx
OPysuVxy0xt9wCl9mgzKlq0t7mGuloPe0Wd46acHFLTJLfq6aNaGSwXQNnTgK6eZ
OytTC4loicOKpRzCzuJYYVcIs5Z72UAZjXT0RnrWLs4EJTzX/rNzM/t7M4FOdSQ8
//sLinQWjr5eZg/57pJg82KN8mwF79YCLucSd/FzW1VOKPKoKZugKEq4TZPNUI8D
ZftNNGAf21EA8uL93SWgP2f1NUEWYRQbGG50JIM2gk3EIKan4W9ha3Cxw48UMY7q
W6l8J277QrnTiC4blbupAYfUqxwryP8OdMrPjC1DM8K1WQAGrIHCDk6cuOvWygp1
crgnW9P5vhaG7MwLScfw/QlSzjA2jES8J/4T2kD4oCAFKh+1T/7f7/o1aKSMRJI3
e5ECg4721ivfnaW5xdl456r5oaq4NhFEQvkPZHuApUgfeKlPTbQyopYU9MmVvIKG
v8FqgQCWOFbfUarDGU/VRmQmvGVr7XwpU24ceocXSq7oHj1uZ7SBS2SUpuGpb5zP
t/Hon9OCmakKdTs8NSTWwTHJa0P0nJQkMgodOnh0CjK8iNvf4J97z9vj6guWZ/b9
Z5KI0L6pf8ixZELWzYhW
=yAFX
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--

--===============0768759485207422999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0768759485207422999==--
