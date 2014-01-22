From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/8] ASoC: simple-card: simplify code
Date: Wed, 22 Jan 2014 19:06:14 +0000
Message-ID: <20140122190614.GV17314@sirena.org.uk>
References: <20140115113551.0eb13409@armhf>
 <20140115165137.5fec601b@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CROkWtElhX9+YmA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140115165137.5fec601b@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--5CROkWtElhX9+YmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 04:51:37PM +0100, Jean-Francois Moine wrote:
> The DT values are copied to the non-DT structure before being moved to
> the card structure.
> Set directly the DT values in the card and move the non-DT copy to the
> non-DT sequence.

Applied, thanks.  Every patch in this series seems to have the same
subject line - please don't do that, it makes things harder to work
with.

--5CROkWtElhX9+YmA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4BajAAoJELSic+t+oim9oJUP/36y2RnsohSJvR4JIx+YrQ29
acY2v4b0MCUda0SjNBoZo69eHPOAOML5XTTSWc28Z0m0luZL6Jon/ZWilVW6Mret
A4tAmWxPfqFCnhonP6dzo8iFN3KQX91wNlNrIo9FsbNQeU/37vuHSU+O/h9CqxlJ
UGkKdXCVM4ozw97ocrUWq0UpZrvihXZ3tCrMxCltceAm/it9Bp7Q+JiWti3J4E9Z
rdteE/VTcGWJ/Q2UY3Qm6wuEYXYrrCF6vwNMdgZp9Gf5Q6cpiKVnOaXnl96hRITQ
VmqfyXRSTZgGKzYS47FEZaxWhtEaCthngsUiOVPGZFyQPNQl2GsUPLXan2TpPBht
nl9CAC6cHrx07uvuLts2aC7ay4lrJsnmKr5JaPSCFPq5ufJteJDi43oolL0dYKjR
xr5XPQ93hM2AQXBEbnU3qxz+4w03psNu1TgtYUUuo20Ayb5QQC26Q0x0H5p43Ngc
MXbpBpISYXWjLGR41znMeifROrIJ8OcB6EWTfldDOEuIzcgk3d5EZXht5aec3Hhs
6IiqsjQtoCmGg19uWJD7ty2E0srYvz8/K2Fi7sWsPsMW4AGfqit0vs8dst64zZ0N
J5vpSiMqlfULtpi7JmXZuphngIxx12kELLGoiFPi6TTQgBjkui/RTGbKB0bQL1Ts
8bK5gLJbKdp/cnHZcAGr
=PR2l
-----END PGP SIGNATURE-----

--5CROkWtElhX9+YmA--
