From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Thu, 3 Mar 2016 10:40:58 -0800
Message-ID: <20160303184057.GB19755@Asurada-Nvidia>
References: <9b1b024d840efa5e4b2af200a1522f22a54a85ce.1456986762.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B438E2655A6
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 19:40:43 +0100 (CET)
Received: by mail-pf0-f174.google.com with SMTP id 63so19423741pfe.3
 for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2016 10:40:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b1b024d840efa5e4b2af200a1522f22a54a85ce.1456986762.git.zidan.wang@freescale.com>
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

On Thu, Mar 03, 2016 at 02:42:42PM +0800, Zidan Wang wrote:
> This is the initial imx-wm8958 device-tree-only machine driver working
> with fsl_sai driver. This sound card has three dai link, HIFI, VOICE
> and BT dai. HIFI dai link will support codec master and slave mode.
> VOICE an BT dai link have dummy cpu dai, and just support codec
> master mode.

Still dummy?

> +++ b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
> @@ -0,0 +1,49 @@
> +Freescale i.MX audio complex with WM8958 codec
> +
> +Required properties:
> +
> +  - compatible		   : "fsl,imx-audio-wm8958"
> +
> +  - model		   : The user-visible name of this sound complex
> +
> +  - cpu-dai		   : The phandle of an CPU DAI controller

One of my previous suggestions was something like this:

cpu-dai1	: The phandle of an CPU DAI controller for AIF1
cpu-dai2	: The phandle of an CPU DAI controller for AIF2
cpu-dai3	: The phandle of an CPU DAI controller for AIF3

> +	data->card.num_links = DAI_LINK_NUM;
> +	data->card.dai_link = data->dai_link;

Then, rather than hard coding the total DAI link number and creating
useless dummy links, you may create the links dynamically according
to the presence of the three properties above.
