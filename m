From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register
	volatile
Date: Mon, 11 Jan 2016 16:52:18 +0100
Message-ID: <5693CFB2.3090301@maciej.szmigiero.name>
References: <56770FE1.4060202@maciej.szmigiero.name> <5692CE43.20708@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 797FF2604BE
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 16:52:30 +0100 (CET)
In-Reply-To: <5692CE43.20708@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Zidan Wang <zidan.wang@freescale.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Timur,

Thanks for review.

On 10.01.2016 22:33, Timur Tabi wrote:
> Maciej S. Szmigiero wrote:
>> +    regmap_write(regs, CCSR_SSI_SACNT,
>> +            ssi_private->regcache_sacnt);
> 
> So I'm not familiar with all of the regcache features, but I understand this patch.
> I was wondering if it makes sense to write the same exact value that was read previously.
> Isn't it possible for the WR or RD bits to change between fsl_ssi_suspend() and fsl_ssi_resume()?

These bits are only set in fsl_ssi_ac97_{read,write} which then wait 100usecs
before returning. This should be enough for SSI core to finish the relevant
operation and clear the bits again, so theoretically they shouldn't be set
outside these functions.

However, if AC'97 register access is done concurrently with suspend or resume
the read / written reg data might be corrupted.

It looks to me this is indeed possible since SSI PM callbacks are set in its
platform driver struct but ASoC core only calls PM callbacks in snd_soc_dai_driver
(which SSI driver don't set).

If I am correct with this reasoning then these callbacks need to be added to
snd_soc_dai_driver but platform driver ones should still be provided in case
the driver is loaded but the sound card is not yet registered.

I've CCed Zidan since he originally added PM support to this driver.

> That is, should we be doing this instead?
> 
> u32 temp;
> regmap_read(regs, CCSR_SSI_SACNT, &temp);
> temp &= 0x18; // preserve WR and RD
> regmap_write(regs, CCSR_SSI_SACNT, (ssi_private->regcache_sacnt & ~0x18) | temp);
> 

Maciej
