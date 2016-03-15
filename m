From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 15 Mar 2016 10:44:34 -0700
Message-ID: <20160315174433.GA5911@Asurada-Nvidia>
References: <011ce146f58a54dda8d8f6ef1c494f92550443bc.1457510037.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id CC5B7261492
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 18:44:30 +0100 (CET)
Received: by mail-pf0-f174.google.com with SMTP id u190so37590782pfb.3
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:44:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <011ce146f58a54dda8d8f6ef1c494f92550443bc.1457510037.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2016 at 04:18:19PM +0800, Zidan Wang wrote:
> This is an initial imx-wm8958 device-tree-only machine driver.
> The sound card driver support three dai link, HIFI, VOICE and BT.
> We can configure the cpu dai from device tree, if present it
> will create corresponding sound card subdevice. So at least
> one cpu dai phandle should be set from device tree.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
> v4->v5: support set dai link name and stream name from device tree.

> +++ b/sound/soc/fsl/imx-wm8958.c
[...]
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
[...]

I don't think you need these two any more.

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
