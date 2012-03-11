From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Sun, 11 Mar 2012 12:55:59 +0000
Message-ID: <20120311125558.GG3233@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
	<1331316853.3789.4.camel@odin> <4F5A55DE.8020609@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2509418867870542995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4194D2414A
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 13:56:03 +0100 (CET)
In-Reply-To: <4F5A55DE.8020609@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <b04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2509418867870542995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 01:11:26PM -0600, Timur Tabi wrote:
> Liam Girdwood wrote:

> > Can you switch on the mutex debugging kernel config here.  I've just had
> > a quick look and the WM8776 and its not holding the codec mutex or
> > calling snd_soc_update_bits_locked() so it must deadlock via another
> > path.

> Enabling the debug options didn't reveal anything, unfortunately.

The major difference between your two boards is that CS4270 doesn't use
DAPM while WM8776 does.  Though if one of them were going to break I'd
really expect it to be the CS4270, obviously non-DAPM CODECs are a real
corner case (to the point where I think you're the only active user of
such a device) and certainly all Liam's TI reference systems have DAPM
CODECs so this is really surprising...  I wonder if PowerPC mutexes are
less forgiving here?

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXKDYAAoJEBus8iNuMP3d8zYP/3ZDBJe+Fwq77oH4bCQpQve7
ds9WImaJXFhQv+8C6lotsfPzv28DrR1ig3JXr9vx2HjojVNXyEI5y/DUYJXyJT4X
C+DdhAlW/uJnStkAXQeLlEATgtTf9zLJ6tzYodFgBEn3O3jKf7x3cKtvhfAh5Oub
xiBXhXLcg4aqJ31wBIBEmyRN+CaIVYmUzcz/vslzZRtUo435uTK53Etg33OMfqoG
iua5kNXUqygwWix9mJedpGafGVjNfyqoVYAWDiB7dTf/C31Fk8EcB3AVktvi+ux5
042TfiWj+tUbZWp1YvFXghEfCkKo8liFsD+8BR9rWW9Br5x3CkRyTnmRMIaoRNCX
o8MqdFCbIm9zQisc0wn5He3OAMoG0MJVNVAwNHzKpiKZUttj38qFWL88sySQP6mR
W+SPVUUwFy8GZhu8r1MuYCdiLk9O+GhIpPu+nQMhYQQclSh66/XcfSN4unHGbpUG
Q9vqHSHPgVROcpOc3f3Fxd/LWwm3e/OAN7xJhMLiS/h3GSj9EW53TCltD+HemBTv
7d50uOb5T7QS+e8iOBwm5uz7A/g9G9o13jIG/qR2V/71v66WlsEdq5JelTUZyDrc
5HgfgRT8buE9qck+aOH7DpmstA4lEdVOVdHSED448fq7Ce9zRap/SNAMXNlHQr8a
0JklmywR0s17Ny8xBbOv
=a4FO
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

--===============2509418867870542995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2509418867870542995==--
