From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai driver name
 in snd_soc_find_dai
Date: Tue, 22 Aug 2017 15:02:55 +0100
Message-ID: <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-3-jeffy.chen@rock-chips.com>
 <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q2ooj6hesboci4oh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, dgreid@chromium.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--q2ooj6hesboci4oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 09:24:32PM +0800, Donglin Peng wrote:

> In case that dai->driver->name is NULL, strcmp(dai->driver->name,
> dlc->dai_name) will cause segmentation fault.
> so I think that we can change it as the follows:

We should be already verifying that drivers have a name, we assume one
elsewhere.

--q2ooj6hesboci4oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcOY8ACgkQJNaLcl1U
h9DRqQf9HABKxxKR1wr5MvrVrkZ55Ey6i5VzbpzCaYoa/jfT1HP4gwQ/UNlnWZbd
/DGURWMmc1EIBaCuwcWKI579AY+jCsHyjmEQU36vK407Lo6yuEaDigVLxV5Ffixw
+moEHpHpii8VtT0DekzzFwHau+Vot44qizVvhgCSJ/yYCx1WOAFG0dYmCUSssmcM
a/jZKQRYmBC8aiztClFy2iA8MYKVvCCNqtwu9vVJxadUlKpy/e1RfLl248xYqxpI
gXoCKHSvOwRhq37/Got2MlpftH+cminWwACLw3q1Ds3q37S/541CCAUCT+lRClLj
r/dZ1p3Wr594tJ11IBmU+Ph0RszkMA==
=uQWo
-----END PGP SIGNATURE-----

--q2ooj6hesboci4oh--
