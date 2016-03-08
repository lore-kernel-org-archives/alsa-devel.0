From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4] ASoC: imx-wm8958: add imx-wm8958
	machine driver
Date: Tue, 8 Mar 2016 09:40:18 -0300
Message-ID: <CAOMZO5B3XVXU=eT2BYVXhxfN2WmnnkuUV73bv3nnz5CbMZHVHw@mail.gmail.com>
References: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B71592606CF
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:40:19 +0100 (CET)
Received: by mail-ig0-f174.google.com with SMTP id z8so16397625ige.0
 for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2016 04:40:19 -0800 (PST)
In-Reply-To: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 8, 2016 at 3:27 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> This is an initial imx-wm8958 device-tree-only machine driver.
> The sound card driver support three dai link, HIFI, VOICE and BT.
> We can configure the cpu dai from device tree, if present it
> will create corresponding sound card subdevice. So at least
> one cpu dai phandle should be set from device tree.
>
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
> v3->v4: remove the dummy cpu dai, support set cpu dai1/2/3 from device tree.
>         When cpu-dai1/2/3 present it will create croresponding sound card
>         subdevice. At least one cpu dai should be configured.
>
>  .../devicetree/bindings/sound/imx-audio-wm8958.txt |  56 ++++
>  arch/arm/configs/imx_v6_v7_defconfig               |   1 +

The change in this file should be a separate patch and it should go
via Shawn's tree.
