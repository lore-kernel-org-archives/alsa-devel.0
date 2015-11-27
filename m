From: Mark Brown <broonie@kernel.org>
Subject: Re: mx28: bad unlock balance detected
Date: Fri, 27 Nov 2015 12:11:26 +0000
Message-ID: <20151127121126.GM1929@sirena.org.uk>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0478501190070402800=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============0478501190070402800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QeIEYJGnsH0eC7HY"
Content-Disposition: inline


--QeIEYJGnsH0eC7HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2015 at 02:18:04PM -0200, Fabio Estevam wrote:
> Hi,
>=20
> Running linux-next 20151126 on a mx28evk leads to the following bug:
>=20
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Using internal LDO instead of VDDD
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ BUG: bad unlock balance detected! ]
> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted

This should be fixed in the next -next, Arnd noticed a problem with his
code.

--QeIEYJGnsH0eC7HY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWEhtAAoJECTWi3JdVIfQ3DcH/3uXgCgdnWNP6Xy1Aj2Bk1M/
syXK+ySkl4KILfZdGDnwUO1DiL9HU45d+QJesu+mjmQymVD9ujmyFWHqs0QhRtma
4l2y4vHGpLfrJeCxYUvMSAwFBvOf3/wT1+cydb6irB+lnczGo2bQPkDjkG3xeH7s
zsWOHcW8cragX65HI4zyGvevVnUeVbR1TJq3x3x9PhBZhyllFyMbLPA/sGQ7aAhd
WM6pKAfVeanlo7uyNZBya05rqE+1GG38E2qeQMj2bzq7G91cfx51cOFD5yuOrHLq
C8OE0f2jX80TxhNWdGSEeVPZqKqRRlV7HFAD1fg70FTn0f2mo4qJzAv6oGIJB4s=
=xcMU
-----END PGP SIGNATURE-----

--QeIEYJGnsH0eC7HY--


--===============0478501190070402800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0478501190070402800==--
