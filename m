From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/intel 41/42]
 sound/soc/intel/boards/bytcr_rt5651.c:325:2: error: implicit declaration of
 function 'rt5651_set_jack_detect'
Date: Mon, 30 Oct 2017 19:12:59 +0000
Message-ID: <20171030191259.moycxzwx44xfngyn@sirena.co.uk>
References: <201710270442.UI1o2xEl%fengguang.wu@intel.com>
 <CAL9uMOFjwVX21wRJ8Ze+fv2YAv3Cq+njf37kAV1OnwAcf3WvHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2643264671271090208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CCA7E266CED
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 20:13:00 +0100 (CET)
In-Reply-To: <CAL9uMOFjwVX21wRJ8Ze+fv2YAv3Cq+njf37kAV1OnwAcf3WvHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2643264671271090208==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wn3oy2dscvurygpb"
Content-Disposition: inline


--wn3oy2dscvurygpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2017 at 09:48:06AM +0100, Carlo Caione wrote:
> On Thu, Oct 26, 2017 at 9:21 PM, kbuild test robot

> >    sound/soc/intel/boards/bytcr_rt5651.c: In function 'byt_rt5651_init':
> >>> sound/soc/intel/boards/bytcr_rt5651.c:325:2: error: implicit declaration of function 'rt5651_set_jack_detect' [-Werror=implicit-function-declaration]
> >      rt5651_set_jack_detect(codec, &priv->jack);
> >      ^~~~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors

> should I ignore this? It looks like the kbuild robot is angry for the
> missing declaration that is added in a different commit on a different
> merging branch.

That one you can ignore.

--wn3oy2dscvurygpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln3eboACgkQJNaLcl1U
h9DkpAf/XP5atPNTXoIilQHOtxFsSyWDXk6Y+xG4vRMk+KhvCsCiTHleGaokbkbW
zF1GyzZU68c17+NjQIT3i1kfhpyg/zYvNxG007puFIgQHiNRAW1C/rr1XAWjmc4g
w+4QFJMJ1Hi22WMn2+aR34lRjN6PjaJvrYdL5sep7CoMlG1arwq/zxxTG2ATXaWx
n+xaa1+RiZzS5Zsm/iv6YiLu/btrMydI7U/AtUJtmgEYL74U48/msRKyL0vprPW4
HYCiDhhFQ/4pp84HBABJixC0J6jSJX5lw/DkcJw8pczPfY7o6sYISAxmVKY2wg16
fdAkkAjlGn9/db4e/sLERsZLncc0uw==
=baDA
-----END PGP SIGNATURE-----

--wn3oy2dscvurygpb--

--===============2643264671271090208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2643264671271090208==--
