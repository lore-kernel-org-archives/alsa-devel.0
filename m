From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 13:11:00 +0100
Message-ID: <20120329121100.GP3668@opensource.wolfsonmicro.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329111605.GK3668@opensource.wolfsonmicro.com>
	<20120329120933.GA27740@zzm-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589247541167480586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2A19104415
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 14:11:01 +0200 (CEST)
In-Reply-To: <20120329120933.GA27740@zzm-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1589247541167480586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pleSNuEbvnUYtMxG"
Content-Disposition: inline


--pleSNuEbvnUYtMxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 08:09:33PM +0800, Zeng Zhaoming wrote:
> On Thu 2012-03-29 12:16:05, Mark Brown wrote:

> > > +	{"Mic Bias", NULL, "MIC_IN"},		/* mic_in --> mic bias */
> > > +	{"Capture Mux", "MIC_IN", "Mic Bias"},	/* mic bias --> adc_mux */

> > This should be in the machine driver.

> This "Mic Bias" is codec internal controller, Machine code should not
> touch this.

What is it actually doing?  Calling it "Mic Bias" if it's not a bias
source for microphones is horribly confusing.

--pleSNuEbvnUYtMxG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdFFOAAoJEBus8iNuMP3dGzcP/RqAMtHCK6LOJDFy12sDTLZH
HrdA7ZS+ofsNNXqdXs+/lMl0YLdQ2x3yqVlUnyikR2ZJemBg851ePDwLe/Vfp4vS
zDP+qBOvJd/9M+oMQoTvCRhF+ATRch9Kjqg/9sURFtiM2y4S9JgpmkcIbjUCw9GI
12Og67rzBEj62e4ozzDzxeniqzqgDd8RWCeoLMNEeRqOVIShdPsOp/8u0CEtk0dd
YUsfV4UF1Um12AEVgRGBKNHNZQsra29irkEI+cdPtVMGDmVw1k9uJLT/GU0HLjWR
yFrWKZJAahZuQcJm833wmEp0Dma6reRuETPk3U1ojU22nsk+MxU77HL/IyOLVUE2
2WmHcA+p0tn7I7/WoXWaQQpu8JHWAkq2ejDM3f5A7L2EbbJeClLoE0KWKqhMDFpp
Kg9a3kRu3QOrGOdaDBn6Ykgy74vl4eOl7mJgswAwoaqHRf+RkKnrQmOCjlOyj/TI
QJrRKvhX7aA8mhbDK1L2ZCLdXFiyKLpGp0tw/Xp5rwjNODHaJI9xszRV4UpsD61p
fE0tOYyTuy1lTeIPHyvbiVihE04hPruCBjU4cxWw9KJPsw18BhWAEYY8SupGBAjB
Pfs1bSXiE9Hwc40t41DGEDjAFjycFNyJJ31lLhTsTUHb59w++2YN41s296wH2jX5
oa52VZLjmtXaOZnSWglb
=e71P
-----END PGP SIGNATURE-----

--pleSNuEbvnUYtMxG--

--===============1589247541167480586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589247541167480586==--
