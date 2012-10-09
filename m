From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 2.6.32.y,
 2.6.34.y] ALSA: hda - ALSA HD Audio patch for Intel Panther Point
 DeviceIDs
Date: Tue, 09 Oct 2012 02:55:33 +0100
Message-ID: <1349747733.6336.19.camel@deadeye.wl.decadent.org.uk>
References: <201104201059.57882.seth.heasley@intel.com>
 <s5htydsiw20.wl%tiwai@suse.de> <20121009010734.GA24147@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4254155843665840648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id DAAD026520F
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 03:55:54 +0200 (CEST)
In-Reply-To: <20121009010734.GA24147@elie.Belkin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Seth Heasley <seth.heasley@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ana Guerrero <ana@debian.org>, Willy Tarreau <w@1wt.eu>
List-Id: alsa-devel@alsa-project.org


--===============4254155843665840648==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q8ObYMiR0KgDhiIRDWWv"


--=-Q8ObYMiR0KgDhiIRDWWv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-10-08 at 18:07 -0700, Jonathan Nieder wrote:
> From: Seth Heasley <seth.heasley@intel.com>
> Date: Wed, 20 Apr 2011 10:59:57 -0700
>=20
> commit d2edeb7c6f1dada8ca7d5c23e42d604e92ae0c76 upstream.
>=20
> This patch adds the HD Audio Controller DeviceIDs for the Intel Panther P=
oint PCH.
>=20
> [jn: backported for 2.6.32.y by Ana Guerrero]
>=20
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Ana Guerrero <ana@debian.org> # EliteBook 8570w
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Willy and Paul,
>=20
> Please consider
>=20
>   d2edeb7c6f1d ALSA: hda - ALSA HD Audio patch for Intel Panther Point
>                DeviceIDs
>=20
> for application to the 2.6.32.y and 2.6.34.y trees.
>=20
> It does what it says on the cover.  The patch was merged in the 3.0
> cycle, so newer stable kernels don't need it.  Backported and
> tested[1] against Debian's 2.6.32.y-based kernel by Ana (cc-ed) --
> thanks!
>=20
> Thoughts of all kinds welcome, as always.
[...]

I queued up a whole series of device ID updates for Debian stable, as
they didn't obviously depend on other changes:

cea310e ALSA: hda_intel: ALSA HD Audio patch for Intel Patsburg DeviceIDs
e35d4b1 ALSA: hda: add Vortex86MX PCI ids
0f0714c ALSA: hda - Add support for VMware controller
d2edeb7 ALSA: hda - ALSA HD Audio patch for Intel Panther Point DeviceIDs

(They can be cherry-picked cleanly in the above order.)  But if I've
missed some post-2.6.32 dependencies then I would like to know.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, about L-Space IRC channel #afp

--=-Q8ObYMiR0KgDhiIRDWWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUHOEFee/yOyVhhEJAQoF0Q//Y2c2KIq223Pdq1dxih51imu2bLiOZ/UZ
4y/jKCnZdHNAZci3kTJr7uz46dhrl/SDdwAipwAl7ufl+L8d2LYX6toW2cpU8k8W
4O7BjlKUEG8tB9S5ljSRxi2X26dkaUCw5yhH+6rtxE3s0K5FiakGFUppqCXieS/a
EP9P19QIT3W46BEP1hFZ4I8x1QeKNOSn6VWahbE7j7gRHHih0w0e3eC2/Wc6bntF
w3ya1FNKT4sRjGSFgK+lem4VDHqUXXA3Q0c3uRA95DQaytR9dabHiKpO3xs2zagd
jivPwPwraKPUlvES73G/c6kOBzVc3pR6znJ/MTnsNa+IbvB093I4if07XfnZyZ7v
pp4k9W/9G6Pt51iBVWQk8tusTVSX/a4F0NRM+0H/k6X9qxVJXR0BhkLaYxNFFsmi
UC338ELVydFUIdSQ7P3xoXrlGrwVXbebINC0HJkH5I4Y+GwmZat3L7bXVD7OmvUX
mWMtU4FY6HmuLEu67zb9ZVpRKPfcEmhENBwVAownEi+vgcJs419dUAGg5OZ4ghtt
qQ8afNtC4h6T5fgSut1mC8Lt3zp+DQP8z04+5gMReTS1dJGMnFOW3qg3PA9HWHg0
XkL3KKsOlngL4BYiQk+UiWksABvqpu5YNYG2AQYOwCmnmVxGl8mesCEALI19XK8J
py1JYZ+3H38=
=O/Ln
-----END PGP SIGNATURE-----

--=-Q8ObYMiR0KgDhiIRDWWv--

--===============4254155843665840648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4254155843665840648==--
