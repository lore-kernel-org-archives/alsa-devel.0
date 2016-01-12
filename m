From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: Enable 33bit memory address to support
 4GB DRAM
Date: Tue, 12 Jan 2016 10:54:44 +0800
Message-ID: <1452567284.8331.12.camel@mtksdaap41>
References: <1452499250-5202-1-git-send-email-pc.liao@mediatek.com>
	 <s5hwprgcwv6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwprgcwv6.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "broonie@kernel.org" <broonie@kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>, Hidalgo Huang =?UTF-8?Q?=28=E9=BB=83=E6=AD=A3=E5=92=8C=29?= <Hidalgo.Huang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2016-01-11 at 17:02 +0800, Takashi Iwai wrote:
> On Mon, 11 Jan 2016 09:00:50 +0100,
> PC Liao wrote:
> > 
> > @@ -603,7 +606,10 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	memif->phys_buf_addr = substream->runtime->dma_addr;
> > +	if (sizeof(dma_addr_t) > 4)
> > +		msb_at_bit33 = (substream->runtime->dma_addr & 0x100000000) ? 1 : 0;
> 
> Better to put a proper suffix for the constant over 32bit.
> 
> Or use upper_32_bits().  Then sizeof() check can be omitted, as the
> compiler should be smart enough to know it beforehand.
> 
> 
> Takashi


Hi Takashi,

Thanks for your comment.
I change as below:
@@ -606,10 +606,8 @@ static int mtk_afe_dais_hw_params(struct
snd_pcm_substream
        if (ret < 0)
                return ret;

-       if (sizeof(dma_addr_t) > 4)
-               msb_at_bit33 = (substream->runtime->dma_addr &
0x100000000) ? 1
-
-       memif->phys_buf_addr = substream->runtime->dma_addr &
0xffffffff;
+       msb_at_bit33 = upper_32_bits(substream->runtime->dma_addr) ? 1 :
0;
+       memif->phys_buf_addr =
lower_32_bits(substream->runtime->dma_addr);


Dose this change follow your idea?
Thanks! 

PC Liao
