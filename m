From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add SND_SOC_DAIFMT_DSP_A
	support
Date: Tue, 29 Jul 2014 13:04:06 +0100
Message-ID: <20140729120406.GQ17528@sirena.org.uk>
References: <d30e88a9fa8c0e52acb48755a1b6dbd2b9e4bacf.1406629932.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0051439159774596781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 543EA260320
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 14:04:25 +0200 (CEST)
In-Reply-To: <d30e88a9fa8c0e52acb48755a1b6dbd2b9e4bacf.1406629932.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============0051439159774596781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJIW2pRtnvuncvpR"
Content-Disposition: inline


--uJIW2pRtnvuncvpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 06:39:37PM +0800, Shengjiu Wang wrote:
> According to the spec, the definition of TDM and ONELINE_24 for
> CS42XX8_INTF_DAC and CS42XX8_INTF_ADC is wrong. correct them and enable
> SND_SOC_DAIFMT_DSP_A support.

Applied, thanks.

--uJIW2pRtnvuncvpR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT142zAAoJELSic+t+oim97/IQAIodZt4qnzpEYc7VoBD9do/y
pEYNWMMEPxfRriQ/VkdYC8O+DerHoH+VDxQe29v+ZEHS63RiIDoxzFMStEXn0q+p
aq6uDXkxJLe2Oa/GxCJc7HMBDoy3duhsSZ5XzsWk97cCp/BOCU57hk64vvm0urp0
PqGFy4cZZmZdhpvLafd3FsHZRJ6nNfdfm/Ia6LUTv0FcMGMTuBxGy4RlbWNAaHXw
RS/X5j9oxLvFAk0SL3kJr4RmSWc4QfP1pHwv4CHX8Ik1WXQsBNNw9s2uA+8aYxdG
f5oQB0Ep+2TdwS5ZP5t58XgCgQzgcOShwNFN3vdgLj8yqANmp33SfksI44DHuDG1
ogP/LWpcoDC48KOFanSqOLh5SXu6ci7sLqHkx6cHh+CBeo2xZeElJXwjhHoofsAB
tHBL8DaqoLabC7tRvWa3kH1CrpeOXNwvIt8fzR6gBIL5AID7budb34VF0zUq0HZ8
MRmUbpErjvPE7IdcbVLS54XOK2DuNevyblm+qp+hh2yathqz98Ymk2Lq0jyqrxng
FTKjEeIK86TtHijwpY2DtYgBBs0OYafgss05keDI70FCmVcrQSEpkhxyX6CP08BI
zenIn3+pwF3ANyVy1eq6O2Sy1d4gv02z9c3Hy1gFFsyu+5GUTrit2AvyCcUSSaVX
J3V+HwFH96d11vkZ3s24
=2IYL
-----END PGP SIGNATURE-----

--uJIW2pRtnvuncvpR--

--===============0051439159774596781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0051439159774596781==--
