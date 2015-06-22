From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v4.2
Date: Mon, 22 Jun 2015 11:30:34 +0100
Message-ID: <20150622103034.GQ14071@sirena.org.uk>
References: <20150622092616.GN14071@sirena.org.uk>
 <s5hmvzs6p4v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0251968027570912650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C91261A84
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 12:30:42 +0200 (CEST)
In-Reply-To: <s5hmvzs6p4v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0251968027570912650==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lKJrrayK576VIMG2"
Content-Disposition: inline


--lKJrrayK576VIMG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 11:58:24AM +0200, Takashi Iwai wrote:

> In addition to rsnd-card.c, I get a compile warning as below:

> sound/soc/mediatek/mtk-afe-pcm.c:1035:12: warning: 'mtk_afe_runtime_suspend' defined but not used [-Wunused-function]

> And, looking at the code, it seems calling runtime suspend in the
> following way at probe:

>         pm_runtime_enable(&pdev->dev);
>         if (!pm_runtime_enabled(&pdev->dev)) {
>                 ret = mtk_afe_runtime_resume(&pdev->dev);
>                 if (ret)
>                         goto err_pm_disable;
>         }

I'm confused, where's the call to runtime suspend?

> I'm not sure whether this really behaves correctly, especially when a
> kernel is built without CONFIG_PM.

Could you be more specific about the problem you're seeing?  If runtime
PM is disabled pm_runtime_enabled() will return false and we'll run
through the resume path during probe() instead, otherwise we'll runtime
resume whenever we need to use the hardware.

--lKJrrayK576VIMG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVh+PJAAoJECTWi3JdVIfQJxcH+wU1kJCdNQft4sbsXECr4hwP
pDvHAHqj5QaJjhIif8INoib3LFsuDfZZXMyOJETLm1bv/U1y1M4YdFx5mnndoKEO
PkPos5gNdFWghAXQCem52AIrhEPzMauGMpnb96gA5dBoJMFpanLfUvDt62etmYFr
ryrVkMe02v/0QsYIf6P0M+2bShXkCe0biEDnyruo7vy1tsDSSClf+M9Oml7Cures
MUu9q4AFJrmjso2uadk2WrTvFXGcUTXZZJAaUIrapOIRRivsSJ3N7cx2IdlLYnum
KPjEG6xd+vo12JV2fG2Zs2O8SwAvPhXUCcLE3QPSV0fASjnxEOgxY1unL2rxUAg=
=GxTx
-----END PGP SIGNATURE-----

--lKJrrayK576VIMG2--

--===============0251968027570912650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0251968027570912650==--
