From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V3 1/3] ASoC: fsl_esai: spba clock is
 needed by esai device
Date: Tue, 24 Nov 2015 17:02:58 +0800
Message-ID: <20151124090256.GA17516@shlinux2>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
 <20151124083344.GA14109@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 539242614A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 10:06:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151124083344.GA14109@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org, broonie@kernel.org, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 12:33:45AM -0800, Nicolin Chen wrote:
> On Tue, Nov 24, 2015 at 03:03:28PM +0800, Shengjiu Wang wrote:
> 
> > @@ -469,6 +471,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
> >  	ret = clk_prepare_enable(esai_priv->coreclk);
> >  	if (ret)
> >  		return ret;
> > +	ret = clk_prepare_enable(esai_priv->spbaclk);
> > +	if (ret)
> > +		goto err_spbaclk;
> >  	if (!IS_ERR(esai_priv->extalclk)) {
> >  		ret = clk_prepare_enable(esai_priv->extalclk);
> >  		if (ret)
> 
> Just like for extalclk there is a IS_ERR check out there, there
> should be one for spbaclk as well. Otherwise....
> 
> root@imx6qdlsolo:~# aplay /unit_tests/audio8k16S.wav 
> [   29.956250] Unable to handle kernel paging request at virtual address fffffffe
> [   29.963491] pgd = edd98000
> [   29.966278] [fffffffe] *pgd=afffd861, *pte=00000000, *ppte=00000000
> [   29.972615] Internal error: Oops: 37 [#1] SMP ARM
> [   29.977327] Modules linked in:
> [   29.980410] CPU: 0 PID: 755 Comm: aplay Not tainted 4.4.0-rc1-12414-gcc8db17 #250
> [   29.987899] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [   29.993738] task: edece780 ti: ed26a000 task.ti: ed26a000
> [   29.999156] PC is at clk_prepare+0x18/0x38
> [   30.003268] LR is at mark_held_locks+0x70/0x98
> [   30.007720] pc : [<c0568714>]    lr : [<c006f42c>]    psr: 600f0013
> [   30.007720] sp : ed26bc60  ip : 00000003  fp : ed26bc74
> [   30.019204] r10: eebe4d9c  r9 : eeb2e00c  r8 : eeb2e00c
> [   30.024435] r7 : fffffffe  r6 : eeb2c500  r5 : eeb2d0c0  r4 : fffffffe
> [   30.030966] r3 : edece780  r2 : 00000001  r1 : 00000001  r0 : 00000001
> [   30.037502] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   30.044643] Control: 10c5387d  Table: add9804a  DAC: 00000051
> [   30.050395] Process aplay (pid: 755, stack limit = 0xed26a210)
>

Will fix it in next version, and send it out later.

best regards
wang shengjiu 
