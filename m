From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: Intel: bxtn: Fix to store the
 FW/Library context at boot
Date: Fri, 6 Jan 2017 18:14:04 +0000
Message-ID: <20170106181404.iv7zpaceif3svlil@sirena.org.uk>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
 <1483330807-9518-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2313830770473566786=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D832677FD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:14:14 +0100 (CET)
In-Reply-To: <1483330807-9518-6-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2313830770473566786==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aanf4jfnhakfqf2z"
Content-Disposition: inline


--aanf4jfnhakfqf2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 09:50:06AM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> Store the DSP firmware/library at boot, so that for S3 to S0 transition
> use the stored ctx for downloading the firmware to DSP memory.

This doesn't apply against current code, please check and resend.  It's
also odd to see fixes like this at the end of the series after cleanups,
I'd expect fixes to come earlier in the series as they should go to
Linus wheras cleanups just go on the development branches.

--aanf4jfnhakfqf2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhv3msACgkQJNaLcl1U
h9Dl2wf+JkYrq7xB+7FeC9DezhXWpyGADkcIAlkFoG+TIpJXTSvanWNtIq3E/0Yv
qB9tdBIdxoa4yO8cqwWaIuEi5N3rHJXOTkIryZJGUfB1lYAXWEyGzgIoZjErPlNA
aRv/pHRHCLsiOjCkSwte2rXYkawx2Dlrcikw1y5wKy/dG3r5my+vsF41K7Wg3Heu
tbrWMBOZPq2efFF/vHHuLahK3VMhbvVZjVRdU2I1xg3wZZp008Ys1dN7l5+hRMpW
aA6Z/LVspbJb/85Pok+hLEMG1FINR7GUjrndlzwAe9xq30Exxybpp6OaWzGQ1gAY
FuSCDSt8scM4MxlNf8OqsOahatKlYw==
=JhRy
-----END PGP SIGNATURE-----

--aanf4jfnhakfqf2z--

--===============2313830770473566786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2313830770473566786==--
