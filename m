From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Add clocking option
Date: Thu, 28 Jul 2016 14:48:59 +0300
Message-ID: <901be45a-6380-3710-1ee5-e3d192b822e3@ti.com>
References: <1469534710-4006-1-git-send-email-s.mueller-klieser@phytec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F99ACFE5A78B931E62F15510"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AF16266BA8
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 13:49:05 +0200 (CEST)
In-Reply-To: <1469534710-4006-1-git-send-email-s.mueller-klieser@phytec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Stefan_M=c3=bcller-Klieser?= <s.mueller-klieser@phytec.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--------------F99ACFE5A78B931E62F15510
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Please do CC the maintainers when sending patches.

On 07/26/16 15:05, Stefan M=C3=BCller-Klieser wrote:
> The AHCLKX clock output of the McASP can be used as audio MCLK, even
> if the McASP runs in slave mode. Add a DT binding to make this option
> available in a simple-card setup.

In other words: McASP is clock master, but we want to have the HCLK to be
coming from internal AUXCLK and not from the AHCLKX pin, right?
There might be also cases when McASP is slave _and_ we want to configure =
the
HCLK from the AHCLKX ping. Adding new flag for this is not a good idea IM=
HO.

This is simply a workaround for the current simple card and might break i=
f
something is changing in there..

I'm aware that this is a problematic issue. We can not have clock id supp=
ort
in the simple-card and I don't think it is a good idea to hack around thi=
s in
the McASP driver.
I don't see any other way right now then moving the McASP driver to CCF, =
or at
first probably add CCF support to configure the clock routes while still
keeping the ASoC way of configuring the clocks.

> Signed-off-by: Stefan M=C3=BCller-Klieser <s.mueller-klieser@phytec.de>
> ---
>  Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt | 4 ++=
++
>  include/linux/platform_data/davinci_asp.h                       | 5 ++=
+++
>  sound/soc/davinci/davinci-mcasp.c                               | 8 ++=
++++++
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audi=
o.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> index 46bc982..96d6244 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -39,6 +39,10 @@ Optional properties:
>    		 please refer to pinctrl-bindings.txt
>  - fck_parent : Should contain a valid clock name which will be used as=
 parent
>  	       for the McASP fck
> +- ahclkx-en: In case the MCASP runs in slave mode, e.g. i2s SCK and WS=
 slave,
> +             we can still provide the MCLK to a codec PLL using the AH=
CLKX
> +             transmit clock output. This setup can be activated by usi=
ng this
> +             property. Clock master mode remains unaffected.

_if_ we hack this around in the driver I would rather have something like=
:
hclk-source: Source of HCLK internal clock when McASP is clock master.
With a new DT binding header file with defines:

/* Source of High-frequency transmit/receive clock */
#define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
#define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */

Basically my old patches for McASP clock selection but w/o the improving =
the
simple card.
The only change would be that we ignore the set_sysclk's clk_id parameter=
 and
use the private clk_id we got via DT when the dir is SND_SOC_CLOCK_IN.
Oh, and set the PDIR also when AUXCLK is selected for HCLK.
In the DT you would have for your setup:

hclk-source =3D MCASP_CLK_HCLK_AUXCLK;

Or something like that.

But I think in this way we can work around the simple-card posed limitati=
on a
bit better, but it is still a questionable workaround.

I have attached my local patches for reference.

> =20
>  Example:
> =20
> diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/=
platform_data/davinci_asp.h
> index 85ad68f..c878836 100644
> --- a/include/linux/platform_data/davinci_asp.h
> +++ b/include/linux/platform_data/davinci_asp.h
> @@ -44,6 +44,11 @@ struct davinci_mcasp_pdata {
>  	int clk_input_pin;
> =20
>  	/*
> +	 * Activate AHCLKX clock output in slave mode.
> +	 */
> +	bool ahclkx_en;
> +
> +	/*
>  	 * This flag works when both clock and FS are outputs for the cpu
>  	 * and makes clock more accurate (FS is not symmetrical and the
>  	 * clock is very fast.
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davi=
nci-mcasp.c
> index 237dc67..aba888e 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -94,6 +94,7 @@ struct davinci_mcasp {
> =20
>  	int	sysclk_freq;
>  	bool	bclk_master;
> +	bool    ahclkx_en;
> =20
>  	/* McASP FIFO related */
>  	u8	txnumevt;
> @@ -605,6 +606,10 @@ static int davinci_mcasp_set_sysclk(struct snd_soc=
_dai *dai, int clk_id,
>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
> +	} else if (mcasp->ahclkx_en) {
> +		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);

It is safe to set this bit as well.

> +		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
> +		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
>  	} else {
>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
> @@ -1610,6 +1615,8 @@ static struct davinci_mcasp_pdata *davinci_mcasp_=
set_pdata_from_of(
>  	if (ret >=3D 0)
>  		pdata->op_mode =3D val;
> =20
> +	pdata->ahclkx_en =3D of_property_read_bool(np, "ahclkx-en");
> +
>  	ret =3D of_property_read_u32(np, "tdm-slots", &val);
>  	if (ret >=3D 0) {
>  		if (val < 2 || val > 32) {
> @@ -1851,6 +1858,7 @@ static int davinci_mcasp_probe(struct platform_de=
vice *pdev)
>  	mcasp->version =3D pdata->version;
>  	mcasp->txnumevt =3D pdata->txnumevt;
>  	mcasp->rxnumevt =3D pdata->rxnumevt;
> +	mcasp->ahclkx_en =3D pdata->ahclkx_en;
> =20
>  	mcasp->dev =3D &pdev->dev;
> =20
>=20


--=20
P=C3=A9ter

--------------F99ACFE5A78B931E62F15510
Content-Type: text/x-patch;
	name="0001-ASoC-davinci-mcasp-Move-the-clkdiv-IDs-to-DT-binding.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-ASoC-davinci-mcasp-Move-the-clkdiv-IDs-to-DT-binding.pa";
	filename*1="tch"

=46rom 407288736709e922e5ade6803e255d0e52a57e66 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 4 May 2016 16:26:42 +0300
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Move the clkdiv IDs to DT bindi=
ng
 header

Move the clkdiv defines to a new binding header file so they ca be used i=
n
DT files as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/dt-bindings/sound/ti-mcasp.h | 9 +++++++++
 sound/soc/davinci/davinci-mcasp.c    | 1 +
 sound/soc/davinci/davinci-mcasp.h    | 5 -----
 3 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/sound/ti-mcasp.h

diff --git a/include/dt-bindings/sound/ti-mcasp.h b/include/dt-bindings/s=
ound/ti-mcasp.h
new file mode 100644
index 000000000000..03519ab67b44
--- /dev/null
+++ b/include/dt-bindings/sound/ti-mcasp.h
@@ -0,0 +1,9 @@
+#ifndef _DT_BINDINGS_TI_MCASP_H
+#define _DT_BINDINGS_TI_MCASP_H
+
+/* clock divider IDs */
+#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
+#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
+#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
+
+#endif /* _DT_BINDINGS_TI_MCASP_H */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
index 05c2d33aa74d..8753f36755cf 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -37,6 +37,7 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/omap-pcm.h>
+#include <dt-bindings/sound/ti-mcasp.h>
=20
 #include "edma-pcm.h"
 #include "davinci-mcasp.h"
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinc=
i-mcasp.h
index afddc8010c54..10b52d6bdeca 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -306,9 +306,4 @@
 #define NUMEVT(x)	(((x) & 0xFF) << 8)
 #define NUMDMA_MASK	(0xFF)
=20
-/* clock divider IDs */
-#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
-#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
-#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
-
 #endif	/* DAVINCI_MCASP_H */
--=20
2.9.2


--------------F99ACFE5A78B931E62F15510
Content-Type: text/x-patch;
	name="0002-ASoC-davinci-mcasp-Improve-the-sysclk-selection.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-ASoC-davinci-mcasp-Improve-the-sysclk-selection.patch"

=46rom c7ef1ef97266a06591706c82c3e298884202c221 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 18 Jan 2016 15:00:07 +0200
Subject: [PATCH 2/2] ASoC: davinci-mcasp: Improve the sysclk selection

When McASP is master the bclk can be generated from two main source:
AUXCLK: functional clock for McASP or
AHCLK: from external source or internal mux in dra7x family

With this patch it is possible to select between the two source. The patc=
h
is not breaking existing machine drivers since historically the clk_id wa=
s
ignored and left as 0 in all cases.

When output clock is configured - which can be only the AHCLK, we select
the AUXCLK as source for the internal HCLK. In this case the HCLK rate is=

the same as the output clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/dt-bindings/sound/ti-mcasp.h |  4 ++++
 sound/soc/davinci/davinci-mcasp.c    | 34 +++++++++++++++++++++++++++---=
----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/dt-bindings/sound/ti-mcasp.h b/include/dt-bindings/s=
ound/ti-mcasp.h
index 03519ab67b44..86ee4d0d79b5 100644
--- a/include/dt-bindings/sound/ti-mcasp.h
+++ b/include/dt-bindings/sound/ti-mcasp.h
@@ -1,6 +1,10 @@
 #ifndef _DT_BINDINGS_TI_MCASP_H
 #define _DT_BINDINGS_TI_MCASP_H
=20
+/* Source of High-frequency transmit/receive clock */
+#define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
+#define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */
+
 /* clock divider IDs */
 #define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
 #define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
index 8753f36755cf..53d71c5dbe37 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -602,18 +602,38 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_=
dai *dai, int clk_id,
 	struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
=20
 	pm_runtime_get_sync(mcasp->dev);
-	if (dir =3D=3D SND_SOC_CLOCK_OUT) {
+
+	if (dir =3D=3D SND_SOC_CLOCK_IN) {
+		switch (clk_id) {
+		case MCASP_CLK_HCLK_AHCLK:
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+			break;
+		case MCASP_CLK_HCLK_AUXCLK:
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			break;
+		default:
+			dev_err(mcasp->dev, "Invalid clk id: %d\n", clk_id);
+			goto out;
+		}
+	} else {
+		/* Select AUXCLK as HCLK */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
-	} else {
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	}
-
+	/*
+	 * When AHCLK X/R is selected to be output it means that the HCLK is
+	 * the same clock - coming via AUXCLK.
+	 */
 	mcasp->sysclk_freq =3D freq;
-
+out:
 	pm_runtime_put(mcasp->dev);
 	return 0;
 }
--=20
2.9.2


--------------F99ACFE5A78B931E62F15510
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------F99ACFE5A78B931E62F15510--
