From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 14:24:47 +0000
Message-ID: <20120307142447.GM3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6277762262842059206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDB76244C9
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 15:24:49 +0100 (CET)
In-Reply-To: <CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6277762262842059206==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 07:45:24PM +0530, Nitin PAI wrote:

Don't top post, and please don't do things like reordering content.

> The usecase for the DSP was specifically for automotive where there is no
> power requirements and the audio functionality is always on.
> The programming of the codecs usually from the userspace.  However ALSA is
> used  for ease of using the alsalib for its various functions (applicatio=
ns
> standpoint).

Even with automotive there's *some* power limits and obviously the power
control also includes things like syncing startup of the algorithms with
the data path=20

> >>The CPU side drivers have no dependency on the CODEC drivers, these are
> >>integrated by the machine.  The SoC vendor can easily ship drivers which
> >>will work with any CODEC which works well on Linux.

> The problem with just writing the machine driver and shipping it is,
> without any codec driver the cards wont be enumerated.
> Having a thin codec driver to enumerate the cards and ship it will help.
> (from debug and development standpoint).

Well, yes.  Unless someone writes a card driver the CPU driver won't do
anything useful but then without the card driver you've no idea how the
system is actually wired up and the chances of it doing anything useful
are close to zero.  There's no getting out of the machine driver.

>  >>Another option is to just embed all the data
> >>structures in a single driver which binds to them all and selects the
> >>right data structure based on the probe information, that might be
> >>useful.

> Are you suggesting to have this in the machine driver?  I didnt understand
> this, please clarify.

No, obviously CODEC drivers should be handling by CODECs...

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV2+nAAoJEBus8iNuMP3dA40QAJTZ2lAbK2I2A2YXXFiGETBK
uUiyj1oMydfsh+glBnR3biHepFaX9NDSZr6HPp0muw6pAqau0zTK3fr5EHMTKSWl
OGmhxnZfiuKUIS7gGCjLgprl70LFic7Q4K85D2QVMTLdyNKHzbm9U2zFaErXXrTb
LzQlfFovivcJF6wszxZRiTjnS9do795OOFhL+d27+M4Zs9k+8WfdcXZKV8eMeZVH
gxwVbqPORWLqYNFmGgBr//1/XS8UWg7M+C20bTOXERclqENqAK5HtJ21RwyRNPjN
6wcxV/tqpZZmNrbdIOJRn5a2+XnwzFYhU4Bq/Xt3jZ8QCjujKpWR8KzDwEvOt0Tx
xGS9w4FKrJIBwgZcEAUuyXe0+Pvxv/vV4rWiC64lr2Clkifxg/849RN1NSHiMsZZ
3Rt7dgu99ge77fZxCtEVW4u4X/NO2PWP+d7jSxzz77Wjs2MzfsNhmNWTbRWC577z
ESJNNZqDZukjPRgHnVlgRrZUFBKxUDkXkr/5j4w5ai7bI0fUCvagO8kJmdXbtE65
J/Bb2hGWy+z+2hzJwx5Rwfmpv50a8iVDzylqtXjwtxkEdsEsGm0YiByLumKp8Q7J
OnQMQcFByworsq8CktDm4TUhVtAsr0cUjNO3QqHVSc2V17v+PUIWWiWlbdHi9tEj
AYZqlBVqhQ4Qr/YULHdG
=dlB6
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--

--===============6277762262842059206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6277762262842059206==--
