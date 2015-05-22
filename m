From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 10/13] sound/core: add DRM ELD helper
Date: Fri, 22 May 2015 13:20:09 +0100
Message-ID: <20150522122009.GK21391@sirena.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xy-0006l8-Ft@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5007001467297377479=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Yr1xy-0006l8-Ft@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5007001467297377479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2015 at 11:26:42AM +0100, Russell King wrote:
> Add a helper for the EDID like data structure, which is typically passed
> from a HDMI adapter to its associated audio driver.  This informs the
> audio driver of the capabilities of the attached HDMI sink.

As far as I can tell people are fairly happy with the implementation
here and unless I'm missing something are definitely happy with the
interface.  If that's the case can we get this into -next?  There's a
lot of interest in HDMI right now (which is great) and this would be
helpful for that, it seems like even if there are issues with the
implementation it would be worth merging as is so we can start adding
users and then do any improvements to the interface in parallel.

=46rom an interface point of view:

Reviewed-by: Mark Brown <broonie@kernel.org>

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXx74AAoJECTWi3JdVIfQWVoH/jcveKvlD11gss44pjGC+m4E
SeKJgqTeMoaqmszVWLGMpGrmqjW7yTHsQ65RGS7P7+A6gDcxAUvtCOB501PljOob
g7Yp6bXg0konqYmWKucRP0+6G46l71p/WYeMdL9+3jxXnY6qF4FEQWwlaMbhjHMP
qgB6XKSFMqL9xp5f9fTnFDISaH6yB1tqBbok7osUvUVjFs4//oOscMtJGnGXeeis
xRaytpp20u62Y4oXYu7Y3f1YAOPIecPoSf84AVVv43oCYfBAayDiypZIu6gxE2XQ
urR1psmYibSo3x0KwWc6ygxNme+WolLxhMI1iRoIfj40EWircZ0J/u0S5qe2ReM=
=2HID
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--


--===============5007001467297377479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5007001467297377479==--
