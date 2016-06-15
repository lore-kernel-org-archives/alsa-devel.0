From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/6] ASoC: sgtl5000: Fix regulator support
Date: Tue, 14 Jun 2016 23:12:03 -0300
Message-ID: <CAOMZO5D5ZhGUTViDRyEwJKxRbjOBvv+Pf+MWxgOAPhewVGghUQ@mail.gmail.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
 <20160606231453.19377-2-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 43AB5261490
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 04:12:05 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id e5so1453986ith.2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 19:12:05 -0700 (PDT)
In-Reply-To: <20160606231453.19377-2-clemens.gruber@pqgruber.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 8:14 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> From: Eric Nelson <eric@nelint.com>
>
> Regulator support on SGTL5000 is broken because the VDDIO and
> VDDA and VDDD should be powered on before enabling MCLK as
> shown in Figure 4 of [1]. This requires moving control of the
> regulators from the codec block to the I2C block of the driver.
>
> The bulk of this patch consists of swapping the codec device with
> the i2c client. The new field num_supplies in struct sgtl5000_priv
> is used instead of ARRAY_SIZE(supplies) to handle the special case
> when the internal LDO is used instead of external VDDD.
>
> Note that ER1 in the SGTL5000 Errata document [2] suggests that
> all designs should use external VDDD.
>
> Since the internal LDO can only be enabled after I2C is available,
> there's no benefit in treating it as a regulator, so this patch
> removes the regulator structure surrounding it.
>
> Instead, a single block of code in sgtl5000_i2c_probe() performs
> the initialization sequence in section 2.2.1.1 of [3] and page
> 26 of [1].
>
> References:
> [1] SGTL5000 data sheet
>     http://cache.nxp.com/files/analog/doc/data_sheet/SGTL5000.pdf
> [2] SGTL5000 errata
>     http://cache.nxp.com/files/analog/doc/errata/SGTL5000ER.pdf
> [3] SGTL5000 Initialization and programming app note
>     http://cache.nxp.com/files/analog/doc/app_note/AN3663.pdf
>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
