From: =?iso-8859-1?Q?Lambrecht_J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Subject: ASoC: imx dma tx burst size set to 6 and to 4
Date: Wed, 29 Jun 2011 16:57:03 +0200
Message-ID: <4E0B3D3F.10008@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2.televic.com (ip2.televic.com [81.82.194.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 5181B1038F2
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 16:57:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hello,

There is an inconsistency in this code:

/sound/soc/imx/imx-ssi.c:         ssi->dma_params_tx.burstsize =3D 4;
/sound/soc/imx/imx-pcm-dma-mx2.c: ssi->dma_params_tx.burstsize =3D 6;

Datasheet:
This sets the field TFWM0 in register SFCSR (SSI_SFCSR_TFWM0): the =

number of data words needed to set the empty flag (TFE0). Can be set =

from 1 to 8; FIFO size is 8 words (of 24b). And this is also the DMA =

burst size.

Which is best depends on the application (the higher the more efficient, =

but the more risk for a FIFO underrun). I would take 4.

But I guess it should only be set at 1 place, and what is then the best =

place?

Regards,
J=FCrgen

details:

/sound/soc/imx/imx-ssi.c: ssi->dma_params_tx.burstsize =3D 4;
Set in commit
commit 0a93421b6adf8ba127b3eafc4c16e3a14017e2ae
Author: Javier Martin <javier.martin@vista-silicon.com>
Date:   Tue Mar 1 15:02:06 2011 +0100

     ASoC: Fix burstsize and DSP_B format problems in imx-ssi.

     When choosing IMX_DMA flag, burtsizes are set to its default
     value (0) which leads to driver malfunction. Change them to 4.

     DSP_B interface needs additional flag to match DSP_B formats
     as described in several codecs as wm8741 and aic3205.

     Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
     Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
     Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Index in diff:
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 30894ea..bc92ec6 100644

/sound/soc/imx/imx-pcm-dma-mx2.c: ssi->dma_params_tx.burstsize =3D 6;
Set in commit
commit 2c4cf17a52f04fbe929977252d5b8ab81d2c6e9b
Author: Wolfram Sang <w.sang@pengutronix.de>
Date:   Fri Mar 25 16:51:44 2011 +0100

     ASoC: imx: set watermarks for mx2-dma

     They got accidently removed by f0fba2a (ASoC: multi-component - ASoC
     Multi-Component Support). Reintroduce them and get rid of the
     superfluous defines because the fiq-driver has its own hardcoded =

values.

     Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
     Acked-by: Liam Girdwood <lrg@ti.com>
     Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
     Cc: stable@kernel.org

Index in diff:
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c =

b/sound/soc/imx/imx-pcm-dma-mx2.c
index 671ef8d..b2ed764 100644
-- =


J=FCrgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
