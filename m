From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Wed, 16 Oct 2013 07:47:32 +0530
Message-ID: <20131016021732.GU2954@intel.com>
References: <20131014161003.GC2443@sirena.org.uk>
 <20131015164408.GQ2954@intel.com>
 <20131015192636.GW2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1353416588799305588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C3881265054
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 05:10:48 +0200 (CEST)
In-Reply-To: <20131015192636.GW2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1353416588799305588==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2013 at 08:26:36PM +0100, Mark Brown wrote:
> On Tue, Oct 15, 2013 at 10:14:08PM +0530, Vinod Koul wrote:
>=20
> > I want to bring the attention to DAPM framework bugs. Somehow recently I
> > stumbled on quite a few occasions of DAPM bugs and the best part was th=
at the
> > fix was already availble upstream, ported to stable later version than =
I had or
> > NOT ported. Mark, can you pls help by ensuring the right fixes are mark=
ed to
> > stable so that users dont get hit by it!
>=20
> Any specifics?  I'm generally very conservative about DAPM changes in
> stable because I don't want to break systems that are currently working
> by luck - giving people a reason to worry about stable updates isn't
> good.
I understand your point on that :)

On 3.4  was hit by DAPM sync bug as DAPM update gets triggered without hold=
ing
lock in few places, after realizing the problem I sae the fix was availble
mainline, clearly this should have been marked to stable.

commit 4edbb34577c98297f958f131e093a150b9f3226f

ASoC: dapm: lock mixer & mux update power with DAPM mutex

Both snd_soc_dapm_mux_update_power() and snd_soc_dapm_mixer_update_power() =
can
be called internally within DAPM core (with DAPM mutex held) and externally.

Provide some wrappers so that external users of both functions do not have =
to
remember to hold the DAPM mutex.

Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Similar now on 3.10, I have this patch which was marked to stable :) but no=
t in
version i was using.

commit: 2d49b5987561e480bdbd8692b27fc5f49a1e2f0b
regmap: cache: Make sure to sync the last register in a block

regcache_sync_block_raw_flush() expects the address of the register after l=
ast
register that needs to be synced as its parameter. But the last call to
regcache_sync_block_raw_flush() in regcache_sync_block_raw() passes the add=
ress
of the last register in the block. This effectively always skips over the l=
ast
register in a block, even if it needs to be synced. In order to fix it incr=
ease
the address by one register.
The issue was introduced in commit 75a5f89 ("regmap: cache: Write
consecutive registers in a single block write").
Cc: stable@vger.kernel.org # 3.10+
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@linaro.org>

> There's also sometimes some dependencies with development work which
> doesn't help.
And thats why I am not yet talking about DPCM as thats new and few issues n=
eed
to be ironed out :)

--
~Vinod



--=20

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSXfc7AAoJEHwUBw8lI4NHSQwP/2/+fY38vv6QGxluVroq4lFG
CxN8/fBkRLyDWoHNcIz3aVucXpQqGln2Z5T1xiCvCmb1XAe3sJ/Fc8vsd1q5bT5S
4s7vPRMG+CD4w0daVi1HDl2/e1LEemEl68GNJxtSlKl55alFqeeWzzWr0AbAsaHy
nluQf8C0t/Q2a+FeFWtE0moRJZ7MW39J43X90KKyxKY3VgNx9CmFhruY+YRW6vW+
83Mw83GZiGQ5RxoZtvmD3BOQX59vi0G9DlXio3dgRm0MWnPy2KDnMVj33QJsa9Ug
VbPhj+wm/dZesengXp/qhU2ByJToUsHomuXVmUtjPZI+amc3Y0Gu0nZjCQJXT7eh
70jmKOijFeCbUIByjBtVkAMDPSASSN3w/kPL/kotnBM69VImUEdmXOblpT8aLlXk
b6gII2UpUZCn92ltlDEGItESnCeYcR1oXtB8X9Iu6lP3yVvt8Vye7fm7eRJ1VcRw
jCPLuTC9vhp7B1OjYkg26iko4ThEnRUMOabDrmANh3mHDUEzqt4tnyO5Rn3thrb0
vmceZXsydhKI7bh8wkIHz/CcQhHJle7IcfdjkSvlNo7Si4g1E9/DPf4OpB8/qJAy
z4D+xuyjX7HZJ0HNpQPKRcaak1TcCB1Pn+www3RzSUZWb3jVRL7Y5625x/ED0xjF
cAnb+VyM7orO6Gh7M41z
=nK+f
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

--===============1353416588799305588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1353416588799305588==--
