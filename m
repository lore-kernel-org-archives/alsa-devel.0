From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM
	runtime
Date: Sat, 20 Apr 2019 22:54:07 -0700
Message-ID: <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBB46F801D9
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2019 07:54:12 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id f6so4394956pgs.8
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2019 22:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-3-daniel.baluta@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> Turn off/on clocks when device enters suspend/resume. This
> helps saving power.

> @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sai->bus_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +		if (ret)
> +			goto disable_bus_clk;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +		if (ret)
> +			goto disable_tx_clk;
> +	}

The driver only enables mclk_clks for I2S master mode. But this
change enables them for I2S slave mode also. It doesn't sound a
right thing to me since we are supposed to save power?
