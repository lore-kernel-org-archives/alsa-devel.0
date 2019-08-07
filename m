From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 3/5] ASoC: fsl_sai: Add support for SAI new version
Date: Tue, 6 Aug 2019 18:40:35 -0700
Message-ID: <20190807014035.GF8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-4-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-4-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Mihai Serban <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 06, 2019 at 06:12:12PM +0300, Daniel Baluta wrote:
> New IP version introduces Version ID and Parameter registers
> and optionally added Timestamp feature.
> 
> VERID and PARAM registers are placed at the top of registers
> address space and some registers are shifted according to
> the following table:
> 
> Tx/Rx data registers and Tx/Rx FIFO registers keep their
> addresses, all other registers are shifted by 8.
> 
> SAI Memory map is described in chapter 13.10.4.1.1 I2S Memory map
> of the Reference Manual [1].
> 
> In order to make as less changes as possible we attach an offset
> to each register offset to each changed register definition. The
> offset is read from each board private data.
> 
> [1]https://cache.nxp.com/secured/assets/documents/en/reference-manual/IMX8MDQLQRM.pdf?__gda__=1563728701_38bea7f0f726472cc675cb141b91bec7&fileExt=.pdf
> 
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [initial coding in the NXP internal tree]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [bugfixing and cleanups]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [adapted to linux-next]

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

One small request that we can do with a separate patch later:

>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
>  	unsigned int fifo_depth;
> +	unsigned int reg_offset;
>  };

I think we need a list of comments for the structure defines.
It might be okay for the old two entries but reg_offset isn't
that explicit any more.
