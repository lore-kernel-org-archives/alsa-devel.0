From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 13:43:10 +0000
Message-ID: <20120307134310.GK3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6449805109369217429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82CA524354
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 14:43:14 +0100 (CET)
In-Reply-To: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin PAI <nitinmpai@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.comm, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org


--===============6449805109369217429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 12:15:07PM +0530, Nitin PAI wrote:

Adding a CC to Liam.  *ALWAYS* CC the maintainers on mails, I know you
followed up adding Liam but you still missed me off.

> In my project I am feeling of need to have generic_codec.  This will
> provide the required codec_dais for the usecases like

> -HDMI/SPDIF where there is no codec involved.
> -For audio over MOST, where CPLD/glue logic is used

These still need something to say what the capabilities of the device
are - ideally users could just specify the part name and not worry about
that stuff.  If you look at how thin the drivers are it's really not
clear to me what we'd save here, though if someone did the work and it
looked useful...  Another option is to just embed all the data
structures in a single driver which binds to them all and selects the
right data structure based on the probe information, that might be
useful.

> -For complex audio DSPs connected which will be mostly programmed in the
> user-space.

These will need in kernel drivers, if only to export the interfaces
required by the application layer to userspace.  They'll also have
difficulty integrating well with the power management without an in
kernel representation of the device, especially for bypass cases like in
call audio.

> -SOC manufactures who would like to ship their drivers without having to
> know what will be the final codec that will be present in the system.

The CPU side drivers have no dependency on the CODEC drivers, these are
integrated by the machine.  The SoC vendor can easily ship drivers which
will work with any CODEC which works well on Linux.

If you actually mean machine drivers it's not really possible to write a
generic machine driver which will actually work for modern CODECs,
especially those used in smartphones and tablets, the clocking
architectures are far too varied and flexible for this to work usefully.
This is before you get into things that are genuine hardware choices and
need to be enumerated at runtime, and of course most modern devices will
require software to power them on so you need to match them up with the
relevant driver to do that.

In general pluggable reference boards really need to have some means of
identifying the connected boards if they want to support running with
different setups without recompilation.  For example, the Wolfson
reference systems have ID chips on each board which are queried during
boot to allow us to instantiate things based on what's physically
connected.  We can swap boards over and have a single system image boot
successfully without software changes.

> 4) Any other ideas ?

I don't think you've fully thought through what you're suggesting, it
doesn't seem practical for most things.

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV2UmAAoJEBus8iNuMP3dpZkP/iL7u/FGBFmn+IXDloJ7hrnT
MuPsGBkc8vsw2ci54YkBB9WTudLMcFe2QhMaLAZBychGKxbDG9uSlGjM5NpWivtR
tTeTq9rT/8MKfaYGlbYoUFHi0Q9Iamymm7xyx8iGlxfCGO15tQlAr2UIoqK5lN4q
B3GnsTAxiiazMfYphDN6RXUGriGn3dW58IQjPLlW369iu/ze9L3moliMK1ckMllP
MTZQW0BVnHMu4BEDdGS5LEBaOwL8lSfnGsFEMe8Db7vICeZx+GmlpbHYWdD7ZFaq
Fc9ARbqqnN0UPU3/roolbazV2UwdD07Fm+1alrtDWTfsSr/92ZDDkAY4/uyC6VT+
rCVVxgbS3yBIpIaEefAe/tpxqkbVXY39VFu62+qf4ufeN+WiMJJ2B8U7qrrIqvW2
5n7qQty6bOWu2YrdNw81jiPaYTcnZX7Dvl+2GIaSnPpzDiIY1MLsDzJsD+97OkfY
5ShZgHm5XP74FJhO5Qs5BdUQlM86QzbntKuuFc8GyvQ4HyLKECktkqLc8YLSdDWi
8518EWVdjSulpUS9P+Deav2SKGoOQxijz/gzIYp/oyXzpfd/K9pDHKQrgeaHqscf
cDTSqwUuJ2g8nltu96Rju8T5waVWUDEnYWgryEI2H0rYSwS+E+XweVh3jFYECigX
cxORRwdE3IbwKOGuayx3
=Gl79
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--

--===============6449805109369217429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6449805109369217429==--
