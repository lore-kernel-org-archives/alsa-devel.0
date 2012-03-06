From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 13:38:18 +0000
Message-ID: <20120306133818.GV19635@opensource.wolfsonmicro.com>
References: <20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
	<20120306123322.GP19635@opensource.wolfsonmicro.com>
	<s5h4nu17tdn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6252493064875695906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85C63103CA7
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:38:20 +0100 (CET)
In-Reply-To: <s5h4nu17tdn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tabi Timur-B04825 <B04825@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6252493064875695906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="thwsKKN5whlRGe6j"
Content-Disposition: inline


--thwsKKN5whlRGe6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 02:26:28PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:

> > whenever you need to call back into the ALSA APIs.  Though of course I'm
> > pretty sure there's a bunch of uniprocessor assumptions through the body
> > of driver code anyway...

> Not that much actually.  On the contrary, because of the current
> design allowing concurrent accesses, many codes have been written
> rather in too complex and messy ways.  It could have been much
> simplified if we didn't consider the concurrent accesses to each
> substream.

Right, but I'm fairly sure that at least some of the driver code is
relying on uniprocessor assumptions for what it's doing - there's a
bunch of things that can't happen on unipocessor that can happen on
SMP (or preempting) systems.

--thwsKKN5whlRGe6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVhNEAAoJEBus8iNuMP3drNAP+wUzPadUcjVqw88JSn2ZTNJ1
Xr5YFCzRO42kk821cWnLDQJ1Rf1gBWuc6AmgO0uj/LgnDxWGGEyY59T9xCVTxxw+
ZLQZAJKcTuLcnO9yCs4C8DMudJPQoNYqJP7xMewCc3Fjimsbeor05o2xp2qotSRr
5eA09J7YhaDH8Xww1X5f+7harWXsHPzuR49d71I9w7anJsTKnuU/6MRpsvqqSGFO
ntz7itA0imTC3I7/MG+QKxFb+hfYNFdn5uuAcsONd+037hMIG9uJ4xfLTpN0jw75
g+DnwkejV7qq7+9vtOCpGEokqERtINjPXbdJk2qeo45WS6ABZTxStv5JuuTq45cV
E1vRZE5RXItwKAEThBuJgA/m8M59ft7U2BcHRPb9blsvNvXWT0Yp/WYQjHpwEnI5
6oAElrw1HzzPPlQh6kBHYA0tAjfsj1zZ4G5oHPQc5pm5XvFksUL7ns/kpAHYQ6Ac
z7ZBCsavFYwEOmolyav/rolO0cio9MMmS7hJwgLIU0RueNl00ANmCPte/oMDQorh
zMdMf+UycP13FU/7NeVNs3cWaepftPVu14R4CVoIimQhgSfJsXtVUVWeUOHJLF/5
JLLzpDERmtEHCnnJMPq9zjh2OKQnJ6XliHKzuzvTgf9xoOlCHfi8FNC7fGeHDUGw
ZcDN48mKjOPHFVvz5bk3
=+JrM
-----END PGP SIGNATURE-----

--thwsKKN5whlRGe6j--

--===============6252493064875695906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6252493064875695906==--
