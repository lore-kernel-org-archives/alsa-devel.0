From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/3] ASoC: fsl_esai: spba clock is needed by esai
 device
Date: Tue, 24 Nov 2015 00:33:45 -0800
Message-ID: <20151124083344.GA14109@Asurada-CZ80>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 03:03:28PM +0800, Shengjiu Wang wrote:

> @@ -469,6 +471,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
>  	ret = clk_prepare_enable(esai_priv->coreclk);
>  	if (ret)
>  		return ret;
> +	ret = clk_prepare_enable(esai_priv->spbaclk);
> +	if (ret)
> +		goto err_spbaclk;
>  	if (!IS_ERR(esai_priv->extalclk)) {
>  		ret = clk_prepare_enable(esai_priv->extalclk);
>  		if (ret)

Just like for extalclk there is a IS_ERR check out there, there
should be one for spbaclk as well. Otherwise....

root@imx6qdlsolo:~# aplay /unit_tests/audio8k16S.wav 
[   29.956250] Unable to handle kernel paging request at virtual address fffffffe
[   29.963491] pgd = edd98000
[   29.966278] [fffffffe] *pgd=afffd861, *pte=00000000, *ppte=00000000
[   29.972615] Internal error: Oops: 37 [#1] SMP ARM
[   29.977327] Modules linked in:
[   29.980410] CPU: 0 PID: 755 Comm: aplay Not tainted 4.4.0-rc1-12414-gcc8db17 #250
[   29.987899] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[   29.993738] task: edece780 ti: ed26a000 task.ti: ed26a000
[   29.999156] PC is at clk_prepare+0x18/0x38
[   30.003268] LR is at mark_held_locks+0x70/0x98
[   30.007720] pc : [<c0568714>]    lr : [<c006f42c>]    psr: 600f0013
[   30.007720] sp : ed26bc60  ip : 00000003  fp : ed26bc74
[   30.019204] r10: eebe4d9c  r9 : eeb2e00c  r8 : eeb2e00c
[   30.024435] r7 : fffffffe  r6 : eeb2c500  r5 : eeb2d0c0  r4 : fffffffe
[   30.030966] r3 : edece780  r2 : 00000001  r1 : 00000001  r0 : 00000001
[   30.037502] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   30.044643] Control: 10c5387d  Table: add9804a  DAC: 00000051
[   30.050395] Process aplay (pid: 755, stack limit = 0xed26a210)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
