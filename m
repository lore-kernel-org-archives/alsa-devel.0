From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai driver name
 in snd_soc_find_dai
Date: Tue, 22 Aug 2017 15:21:11 +0100
Message-ID: <20170822142111.zlosryhkyi75htod@sirena.org.uk>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-3-jeffy.chen@rock-chips.com>
 <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
 <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
 <CAErzpmsg9fi0-ukHG13-dy2r02892h+oPXmtsusCbu-xLzazFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6apki3taflv3xvuq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErzpmsg9fi0-ukHG13-dy2r02892h+oPXmtsusCbu-xLzazFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, dgreid@chromium.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--6apki3taflv3xvuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 10:15:32PM +0800, Donglin Peng wrote:
> On Tue, Aug 22, 2017 at 10:02 PM, Mark Brown <broonie@kernel.org> wrote:

> > We should be already verifying that drivers have a name, we assume one
> > elsewhere.

> But I can't find any codes that set or check dai_driver->name in
> function snd_soc_register_codec or snd_soc_register_component.

We should fix that then.

--6apki3taflv3xvuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcPdYACgkQJNaLcl1U
h9A77gf/XSS0s9fUUdiWXihLx8CQtL3uUO/Q388wF/LaECfQUlvkHfVOa4SXfgiG
No0pQfYSpC8sI/GZxZWOWKE/UGZ/qJg1ezHMM3VFlysy4MkgiOxqK2UyJpLxGxVM
x8kUrdohqoZLTdIGvbYGVVYLYvUShmiNDxZsgRk0HF4OmpZ3NZgduQj2hvJKDuK9
MzgwvwfLxc4VVkEDErl4ClS7AGN6YmjJy1qVy3gJtSXb32IxU4VfKDE2g8YngOZf
gNXA3GzKKvbMjpyMET485ipavv3YAK79RkTLkmDWr8AJlx8lFcZ46zaW3TUEflVb
t70YoxRBF0sFI14Lj/hWAxjbZfL8ag==
=HmHS
-----END PGP SIGNATURE-----

--6apki3taflv3xvuq--
