From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Wed, 13 Jun 2012 13:17:43 +0100
Message-ID: <20120613121743.GN4545@opensource.wolfsonmicro.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6697214555435455504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Chao Xie <cxie4@marvell.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6697214555435455504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Content-Disposition: inline


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 06:04:36PM +0800, Zhangfei Gao wrote:

> These patches provide mmp audio support under alsa via dmaengine
> Support platfrom pxa688 and pxa910
> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
> pxa688 (mmp2) use mmp2-sspa.c
> pxa910 directly use pxa-ssp.c
> mmp_tdma.c is under dmaengine framework

Applied 2-4.  I'm not seeing a direct code dependency between this and
the dmaengine driver in patch 1 (or review of it from Vinod yet) so I'm
expecting that to go via the dmaengine tree.

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2IThAAoJEBus8iNuMP3dx5EP/iCAdLl6oEKkz5m+F53tA0m2
rgZ00gtYuci3TxvwX0CLOh41Zav48MfNolG1Y5UtNxGRRZpVluEy3GEPu5ypDt6w
paHaiA3PE3lSTm3A0mKba/wwrU+2jcmlJg99JoTkacwgr2mkwaxX/bSBvtaxViuE
PzhRDH299Y5AJNWuOBNELKCHxq+5uvwfaNZcZVW+5mzUxz4S/wGikXVvWrYUQQPh
kvAoPoFuMkujvx1EsuYurhncSPlL5+TAsHbsQ/VUWEWuf79jo9aEbW7CHCOLWit7
NW5BkHQqSCD4469AzbsJXjE67eV/P0LVFPZ63e+kRNRRBdiuR5LlXb5NBVmKtHF4
HBmSi3FROHZtgDx7z0Ol5cM6j3HdxLE0yTi5eakW8avR2tc0q1w5MlM08tFwCSs7
oQDUPqNLtyRjN4qF2+8j5FvU38dacYtLv2zYYwRnqGp11wJchYRLFSXCkaD9w1nv
n/JYjmFtcCE8KJu+bkpyV6jaSCQuyI1SVz3pbdpaUcNX21VNcZJLH2+HClwEtq1H
sGEeQIRviTg/bENlzBMI5m0moBa75k1e/xXJaJMaHc9hskQAhynQLtaPxC5HII1j
tz8DEYDvHwlD9qm54EbCbS8vVdta3+in2GLm+zbO+MBcJMTIoVltZ8wR8zfjcOTm
/wScJrfV4AIdQv/HRWrk
=2glb
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============6697214555435455504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6697214555435455504==--
