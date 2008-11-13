From: "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH 0/3] enable HDMI audio output for HDMI monitors V2
Date: Thu, 13 Nov 2008 10:05:46 +0800
Message-ID: <20081113020546.GA23861@zhen-devel.sh.intel.com>
References: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153300786=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <20081107062338.158523355@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Wu Fengguang <wfg@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-gfx@linux.intel.com" <linux-gfx@linux.intel.com>, "xorg@lists.freedesktop.org" <xorg@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org


--===============1153300786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2008.11.07 14:23:38 +0800, Wu Fengguang wrote:
> Hello,
>=20
> We can now enjoy music on HDMI monitors that are attached to Intel G35/G45
> chipsets with the following X.org intel driver patches
>=20
>       [PATCH 1/3] introduce i830_hdmi_priv.has_hdmi_sink
>       [PATCH 2/3] enable Intel G45 integrated HDMI audio output
>       [PATCH 3/3] enable Intel G35 SDVO HDMI audio output
>=20
> _and_ the corresponding ALSA patch posted at
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012158=
=2Ehtml
>=20
> The patches are tested OK on Intel DG45ID board, HP 2230s notebook and
> ASUS P5E-VM board.

Pushed xf86-video-intel patches. Thanks!

If you have HDMI output with intel graphics chips, you can test this now.

- alsa patch is within above mail, or get it from
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

- after loading snd_hda_intel, 'aplay -l' should give you a list of devices
  that contains Intel HDMI device. Use that device for PCM. Current supports
  G35/G45/GM45.

- build xf86-video-intel git master to enable HDMI audio within video drive=
r.

>=20
> Since the HDMI audio requires both audio and video driver support to func=
tion
> well, I'd like to provide an overview here.
>=20
> 1) driver components:
> 	A) ALSA: audio driver (the above link)
> 	B) Xorg: audio output enabling (this patchset)
> 	C) Xorg: EDID/ELD information (patches to be submitted by Ma Ling)
>=20
> 2) summary of the feature sets:
> 	- basic 2-channel audio:
> 		(A) is required, (B) is mostly required, (C) is not needed
> 	- 2+ multichannel audio:
> 		not tested yet; in theory we need (C) to get HDMI monitor's
> 		speaker allocation configuration; there are also bandwidth
> 		constraints that should be coordinated between audio/video
> 		drivers in the future.
> 	- non-LPCM audio:
> 		not tested yet; need more work in ALSA code.
>=20
> 3) summary of the work flow:
> 	- basic audio output: (A) and (B)
> 		- ALSA HDMI driver: enable pin out and unmute
> 		- ALSA HDMI driver: fill audio infoframe and enable its transmission
> 		- Xorg intel driver: enable audio output
> 	- ELD info for advanced audio capabilities: (A) and (C)
> 		- Xorg xserver: get/parse/store EDID extensions
> 		- Xorg xserver: transform EDID into ELD
> 		- Xorg intel driver: feed ELD to hardware
> 		- Xorg intel driver: set ELD-Valid flag to inform audio driver of new E=
LD
> 		- ALSA HDMI driver: response to unsolicited response triggered by ELDV
> 		- ALSA HDMI driver: get ELD from hardware
> 		- ALSA HDMI driver: parse and show ELD info
> 		- ALSA HDMI driver: update hardware capabilities/constraints
> 				    according to ELD (TBD)
>=20
> That describes my understandings of HDMI audio, comments and discussions =
are
> warmly welcome.
>=20
> Thank you,
> Fengguang
> --

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkbi3oACgkQsQQaM014GCdrAgCeN0Zw/cDyMfEcaCinJKDfRUFd
OIsAn0tZiLfMVNiWYPo3vt58g7bcU2LQ
=4VWX
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--===============1153300786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============1153300786==--
