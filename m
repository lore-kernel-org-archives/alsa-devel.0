From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add a sanity check before using
	dai driver name
Date: Sun, 27 Aug 2017 15:26:17 +0100
Message-ID: <20170827142617.ddavw3tip2ufaeui@sirena.org.uk>
References: <20170824033411.5788-1-jeffy.chen@rock-chips.com>
 <201708262141.5hey2M3k%fengguang.wu@intel.com>
 <CAErzpmupMr=RZj4yDni3xEp-f+fLBJ2KqnD8GcarMmGOH0JxXg@mail.gmail.com>
 <20170827121900.h6k5ab3lkgvfuozu@sirena.org.uk>
 <CAErzpmvF_N5fskRQe7yv9JsyYXKqG6u5R55B2q5RmAB-i_b7LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3790869444244357741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6610826684C
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 16:26:29 +0200 (CEST)
In-Reply-To: <CAErzpmvF_N5fskRQe7yv9JsyYXKqG6u5R55B2q5RmAB-i_b7LQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, kbuild-all@01.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============3790869444244357741==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sj7yj4tgfgsei4cg"
Content-Disposition: inline


--sj7yj4tgfgsei4cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 27, 2017 at 09:54:09PM +0800, Donglin Peng wrote:
> On Sun, Aug 27, 2017 at 8:19 PM, Mark Brown <broonie@kernel.org> wrote:

> > Please send incremental fixes rather than new versions for things that
> > are are already applied.

> You should send a incremental patch rather than v3 patch, because your
> v2 patch had been applied and caused this issue.

Right, so I actually just looked at this and I think the right thing got
applied as everything seems to be building fine but I could be confused
here.

--sj7yj4tgfgsei4cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmi1oUACgkQJNaLcl1U
h9DMJAf+PTgbDifQIkhnWVlMsgmxvBS3VbUFn0qNeU2b1PHfyp9IYP6IQsdgjIhh
sLcjM5962rEHIJJC2iI0Iv4Eq2Fo6718DIwgqnBxzLhhdjMeFdwW05uvUuoBc9+X
sARAON+zjO7AliIQl2WyOKPwa9EllknCJleKQNX4QadcrwFY5rBCiSAD5gSieuPm
e/tnGkFOe17mcoiD4dcGSlwhse8PAPyHGKMh2cRPKuFklHiTa7IxoPjiPjY/ObTW
vVOvDDNYl0d6bY5ZJJH46Vc6kNCjFVCFJDd7U8gSVFQr1MACuBbQ6Ym6NYhi7oTs
8hrAZgti+a34s9kmgz6VtV5nTd1nIQ==
=bCqZ
-----END PGP SIGNATURE-----

--sj7yj4tgfgsei4cg--

--===============3790869444244357741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3790869444244357741==--
