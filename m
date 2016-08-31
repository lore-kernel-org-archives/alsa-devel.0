From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Remove deprecated create_singlethread_workqueue
Date: Wed, 31 Aug 2016 15:50:59 +0100
Message-ID: <20160831145059.GB5967@sirena.org.uk>
References: <20160830192709.GA16591@Karyakshetra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160830192709.GA16591@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 31, 2016 at 12:57:09AM +0530, Bhaktipriya Shridhar wrote:

> The workqueue "dac33_wq" queues a single work item &dac33->work and hence
> doesn't require ordering. Also, it is not being used on a memory reclaim
> path. Hence, it has been converted to use system_wq.

> The workqueue "post_msg_wq" queues a single work item
> &drv->ipc_post_msg_wq and hence doesn't require ordering. Also, it is
> not being used on a memory reclaim path. Hence, it has been converted to
> use system_wq.

Please send one patch per change, and please address Peter's concerns
about the dac33.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXxu7SAAoJECTWi3JdVIfQFn4H+wd65yBCwkoVMyNOCGoWx3PR
4aJObQ7BfFTdf7SJ9i5Zw1BkmgbswG4ngK4VG0/mXSxugIir8yJ/Y6Lwcre8M+nm
6wDzDq2JEMmwnEmNRFxQ9s7pXKASGoVeluNVI+PXjpg0DstZ+LXDD9Dwn7hp+06u
bfL+BzTY4cvFXtgEdYnknhbeOjjVybhmtgpguYKHdyxjPvYXkgcvdNIpmWret1LT
x6ABfeygRdv/+hvDog7BCfTAYIfzXNpUhfj2XK666BrSAsg9bP6ujqz/O0jWDWb8
1/QdUO6P9LnJdTx3SfTREzSNAmJPlkWXFBM+WzuEiKRE5pOy2/pcut8li6f4XII=
=IYXP
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
