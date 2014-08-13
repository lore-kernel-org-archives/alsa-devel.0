From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 06/12] ASoC: Intel: mrfld: add the gain
	controls
Date: Wed, 13 Aug 2014 21:03:39 +0100
Message-ID: <20140813200339.GP17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-7-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1469763320514286230=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E20265593
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:03:52 +0200 (CEST)
In-Reply-To: <1407145563-1303-7-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1469763320514286230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HbkTnvMcXUUyEDoc"
Content-Disposition: inline


--HbkTnvMcXUUyEDoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 03:15:57PM +0530, Subhransu S. Prusty wrote:

> +static const struct snd_kcontrol_new sst_gain_controls[] = {
> +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),

Media0 Capture Volume - all the controls here look like they should have
standard ALSA style names.

--HbkTnvMcXUUyEDoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68SXAAoJELSic+t+oim9Q9kP/2LhsO3/t/dHk3O8xjtjHkLi
yY/uCQA2rXBdfewAc73ioNLZkVMJN65sR0kSxe3bxVEGhcOVW/EUqqO6V6JJMVyB
xFQPzN9zRtIr9idS0p9OPj+jHNF00gp7uHjRm5Z89Nb6qFT6qqpSCiI5inwYwv79
NaSUbbdT1EiNXOZypBHzPueZuFxrDMY0NVTmb4gmhvblTIlgifXGrsjSHPw0ZCYn
SBtE9WV5eXKXbv+8yqdaheMM3rLQMI6aldYwe6uRylZMQ6P7JrRc4GDxNy9A6rij
DlBOxTyh52RLWu1eDQ1OTMcDZB6A9UexrnXyyNjfbrQUIL+tq5zb5pn4oZlvSQ+C
pfCLRr5ZL8iroxq+QmF2csiW1y96C/gtxdAT/F0nye1zAYhaDjucpdSRnXHoH4xV
KnMetgoLHkWNUSDZZt2ARoRJaHnKiRYI0O2S+pcgcbOefcdLQE0IjY8LZNE9kWS6
FRkC1+ja2P3vLya9cAWGjoeAVnvnclZit90gZl7LXBbT+7hJqKRJH2eYU9HaqtPa
6wsCt4DQ45mOgZabj2XJu378CMhJ39j1DPbFfXVwpwzQBrjBMGKJMrTjI2koHz2y
iLicP44XlLmImuhDXWrMgpkFGLU/3cqfTTcksw0BxKtPFCQ/rqRTDP6ZzO9Jh2mz
H56PRTbiYRfUD1DpjtL1
=H01B
-----END PGP SIGNATURE-----

--HbkTnvMcXUUyEDoc--

--===============1469763320514286230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1469763320514286230==--
