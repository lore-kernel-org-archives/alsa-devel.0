From: Mark Brown <broonie@kernel.org>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 23:12:44 +0100
Message-ID: <20130601221243.GY16790@sirena.org.uk>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
 <20130601210534.GU16790@sirena.org.uk>
 <201306012342.21418.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8278122670428267670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 641C5265579
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 00:12:56 +0200 (CEST)
In-Reply-To: <201306012342.21418.marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8278122670428267670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OEa2bCMk+rg6xBXy"
Content-Disposition: inline


--OEa2bCMk+rg6xBXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2013 at 11:42:21PM +0200, Marek Vasut wrote:

> Each of the SAIFs has only one direction, the question Fabio probably wan=
ted to=20
> ask is where he can fix the SAIF caps so they report only one direction i=
nstead=20
> of both.

Only specifying playback or capture capabilities ought to do the job.
Looking at soc-pcm.c it rather looks like things got broken during the
soc-pcm stuff if they ever worked for CPU side limitations here.

--OEa2bCMk+rg6xBXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqnHYAAoJELSic+t+oim976oP/01njUJ2sfssA5hZtt1LoPbi
YEpO93iYB3PVYZ6JzW3m5AJJI0eMimHkh9j1nQo52+DM3YjmdDFbneVON8GgoXr1
jHng3dvfRatr3nVChLvYSL5qVhuglhkKvDDMDsX6dCX24R/T2Z9tedBBfVuSRVfv
KYsNPMc+Ywn+7HDHJFjhfo/0DVSVJ46bht+6wu0uXXcza2icJrOuVzTsjfKgU277
GJBvbqiHyetpo0s13kLoMdqv2fsAF+7dDs9+5sAuthatn9AIwkS+DofSghIljvT9
dWwUIQKOAAuPFLCPAXcDzjlUxtKpw1AayypCjjAPke+r3KejWj4ocfMUcBuZ7XHx
CRj46EcvzZ/z0LndDQyDzoqpwxiOmTTrWDfz/bKnzaBjBM/Jzsjuk/4F+I6QGg/I
cugo+LNnrB4GFy7OYbN+OXq4HuTyqzRXkfFOkuZhMUTbvDc1Aa1uVUji5rLCWP0W
mxhSW/SGEVDuCMYMAVGGb2Um+48hDE541uT/8ixawTrCsJIcrnejMiW4YYmqnmat
o0JqQa2ePlF5OLguzdQQwHLqUeCL70RhfULHV4SoIv9B+8yFgQgpeMekbRY8iEVw
oOGgVMcFalj5swSfxwZab4Tx+73pmDLEVDPgj2ncjgcfqjK+Do7fUjAvhcqP7ZOi
Pm8K8pdWMzArjTOSCcsv
=bszG
-----END PGP SIGNATURE-----

--OEa2bCMk+rg6xBXy--

--===============8278122670428267670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8278122670428267670==--
