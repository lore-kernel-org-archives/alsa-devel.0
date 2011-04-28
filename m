From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V3] ASoC: SAMSUNG: Add quirk to support Exynos4 PCM audio
Date: Thu, 28 Apr 2011 11:45:31 +0530
Message-ID: <BANLkTimjTj=6xENwo2WH7bNhg6iiPYmRBA@mail.gmail.com>
References: <1303967370-18774-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1303967370-18774-1-git-send-email-sbkim73@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 10:39 AM, Sangbeom Kim <sbkim73@samsung.com> wr=
ote:

> @@ -10,7 +10,6 @@
> =C2=A0* it under the terms of the GNU General Public License version =
2 as
> =C2=A0* published by the Free Software Foundation.
> =C2=A0*/
> -
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/io.h>

Please avoid null changes.


> @@ -299,25 +299,34 @@ static int s3c_pcm_hw_params(struct snd_pcm_sub=
stream *substream,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&pcm->lock, flags);
>
> - =C2=A0 =C2=A0 =C2=A0 /* Get hold of the PCMSOURCE_CLK */
> - =C2=A0 =C2=A0 =C2=A0 clkctl =3D readl(regs + S3C_PCM_CLKCTL);
> - =C2=A0 =C2=A0 =C2=A0 if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk =3D pcm->pclk;
> - =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 if (pcm->quirks =3D=3D QUIRK_NO_DIV) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk =3D pcm->c=
clk;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (clk_get_rate(c=
lk) !=3D (pcm->sclk_per_fs*params_rate(params))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_set_rate(clk, pcm->sclk_per_fs*params_rate(params));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync_div =3D clk_g=
et_rate(clk)/(params_rate(params))-1;

The sync_div assignment is essentially unchanged. See below..


> - =C2=A0 =C2=A0 =C2=A0 /* Set the SYNC divider */
> - =C2=A0 =C2=A0 =C2=A0 sync_div =3D pcm->sclk_per_fs - 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync_div =3D pcm->=
sclk_per_fs - 1;
> + =C2=A0 =C2=A0 =C2=A0 }

so this could be moved outside of the if-else block as common code.


> @@ -330,7 +339,6 @@ static int s3c_pcm_hw_params(struct snd_pcm_subst=
ream *substream,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(pcm->dev, "PCMSOURCE_CLK-%lu SCLK=3D=
%ufs SCLK_DIV=3D%d SYNC_DIV=3D%d\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_get_rate(clk), pcm->sclk_=
per_fs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sclk_div, sync_div);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}

Again, this is not needed.


I know I should have pointed these out earlier to avoid unnecessary
revision. My apologies.
