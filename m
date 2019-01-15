From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2 4/8] ASoC: imx-audmux: change snprintf to scnprintf for
 possible overflow
Date: Mon, 14 Jan 2019 22:53:28 -0600
Message-ID: <a3168303-05d9-0ef7-f33b-2b1e3db6da47@embeddedor.com>
References: <20190115032727.GA6440@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115032727.GA6440@1wt.eu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>, Silvio Cesare <silvio.cesare@gmail.com>
Cc: linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Dan Carpenter <dan.carpenter@oracle.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org

Hi Willy,

On 1/14/19 9:27 PM, Willy Tarreau wrote:
> From: Silvio Cesare <silvio.cesare@gmail.com>
> 
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
> 
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
> 
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
> 
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
> 
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 


You are still missing some people and mailing lists:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback sound/soc/fsl/imx-audmux.c
Timur Tabi <timur@kernel.org> (maintainer:FREESCALE SOC SOUND DRIVERS)
Nicolin Chen <nicoleotsuka@gmail.com> (maintainer:FREESCALE SOC SOUND DRIVERS)
Xiubo Li <Xiubo.Lee@gmail.com> (maintainer:FREESCALE SOC SOUND DRIVERS)
Fabio Estevam <fabio.estevam@nxp.com> (reviewer:FREESCALE SOC SOUND DRIVERS)
Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Mark Brown <broonie@kernel.org> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Sascha Hauer <s.hauer@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Pengutronix Kernel Team <kernel@pengutronix.de> (reviewer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
NXP Linux Team <linux-imx@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
alsa-devel@alsa-project.org (moderated list:FREESCALE SOC SOUND DRIVERS)
linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
linux-kernel@vger.kernel.org (open list)

--
Gustavo

> --
> 
> v2:
>    - adjust subject line
>    - added alsa-devel & Mark
>    - added acked-by
>    - added reviewed-by
> 
> The patches in this series were sent by Silvio to the security list
> to fix a minor memory disclosure issue after this article was published:
>                                                            
>    http://blog.infosectcbr.com.au/2018/11/memory-bugs-in-multiple-linux-kernel.html
> 
> 
>   sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index 392d5eef356d..99e07b01a2ce 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
> +	ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
>   		       pdcr, ptcr);
>   
>   	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   				"TxFS output from %s, ",
>   				audmux_port_string((ptcr >> 27) & 0x7));
>   	else
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   				"TxFS input, ");
>   
>   	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   				"TxClk output from %s",
>   				audmux_port_string((ptcr >> 22) & 0x7));
>   	else
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   				"TxClk input");
>   
> -	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>   
>   	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   				"Port is symmetric");
>   	} else {
>   		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
> -			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   					"RxFS output from %s, ",
>   					audmux_port_string((ptcr >> 17) & 0x7));
>   		else
> -			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   					"RxFS input, ");
>   
>   		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
> -			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   					"RxClk output from %s",
>   					audmux_port_string((ptcr >> 12) & 0x7));
>   		else
> -			ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   					"RxClk input");
>   	}
>   
> -	ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>   			"\nData received from %s\n",
>   			audmux_port_string((pdcr >> 13) & 0x7));
>   
> 
