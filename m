From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: n810: Convert to
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 2 Dec 2013 11:14:57 +0000
Message-ID: <20131202111457.GK27568@sirena.org.uk>
References: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0061774670743868306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 116ED2610CB
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:15:00 +0100 (CET)
In-Reply-To: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0061774670743868306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W302I+VHGNbNYdEm"
Content-Disposition: inline


--W302I+VHGNbNYdEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 30, 2013 at 06:05:28PM +0200, Jarkko Nikula wrote:
> N810 audio driver has stopped working at some point. Probably when
> OMAP2 was converted to common clock framework since now call to clk_enable
> dumps the stack trace in drivers/clk/clk.c: __clk_enable() due
> clk->prepare_count is zero.

Applied, thanks.

--W302I+VHGNbNYdEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnGuuAAoJELSic+t+oim9pwYP/2l8LPDy6uy0JPCeCev+At09
zTTpy+ft8m+Qc9ae6eRiCSr3O33TETz3qCgO5Ykk+Mxq4JI/whKYwDeQwNvvsHK4
uOqU/LFmpoQMWLrZ6asRUIqabQnUO9BoB8h6IH4kB1KWqFiZbF+4jfVVVu58OLmv
MT6TS3bSCe69esFi0N97JWu+eVTuzwOXK8fw53LzuTEtWagPvUpg8nKQ8otGvE2U
gSGfEwzzyyqz/HUdCExp4mMIswz7eduZWcGc9ckhmcQl9ymE/Ek7yHk6/s8Nr4gD
TV0EUnqO8Hmf7qoCl2whMd0IElhnpyWtfB005glJCByGfzVIxRmC6u+mSdFJQ7z1
y5BeGyWm4+YN+gR1PYrLhe8Kb7J8XR8+qVjkXVyuTFXofCwiqUN2ueOUsTRZo+uA
HRNXfqkagpv/IJvjZRsfMXDdtYcp9iJDYk/KlgsEIObZUwFSAjAHvfa5DxVtSDfL
lIuLYV1p25g47NvBzAq8ZrHgCS4y8E5PqFy8hQe2rDT2PxK5QLRQyDZJ2ABK9hM9
J/4QIPuWlaSIyHHiUf1dbv1FY0o2ZvX0LGPM0xApq00huuK7gicVaoCt0s4eRpx/
vJjPyinYdShnSNbU2u82iJFStZ/gE+Uo2GyjdH1zrX0H9oUZwgOZFivKNNIBsRjL
WipObBvuttLFWDP/jQ0O
=SAiA
-----END PGP SIGNATURE-----

--W302I+VHGNbNYdEm--

--===============0061774670743868306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0061774670743868306==--
