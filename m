From: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: simple-card: overwrite
 cpu_dai->fmt with codec_dai->fmt
Date: Wed, 12 Mar 2014 17:33:54 +0800
Message-ID: <20140312093353.GH1177@MrMyself>
References: <1394593331-22867-1-git-send-email-Guangyu.Chen@freescale.com>
 <5320280C.6080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5320280C.6080004-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2014 at 11:25:32AM +0200, Jyri Sarha wrote:
> On 03/12/2014 05:02 AM, Nicolin Chen wrote:
> >The current simple-card driver separates the daimft for cpu_dai and codec_dai.
> >So we might get different values for them (0x4003 and 0x1003 for example):
> >
> >asoc-simple-card sound-cs42888.12: cpu : 2024000.esai / 4003 / 132000000
> >asoc-simple-card sound-cs42888.12: codec : cs42888 / 1003 / 24576000
> >asoc-simple-card sound-cs42888.12: cs42888 <-> 2024000.esai mapping ok
> >
> >This is not allowed at all as we need to keep the DAIFMT settings identical
> >for both the ends of the link.
> >
> >Thus this patch fixes it by overwriting the cpu_dai->fmt with codec_dai->fmt
> >since we defined the DAIFMT_MASTER basing on CODEC at the first place while
> >the other bits are same.
> >
> >Signed-off-by: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >---
> Hi Nicolin,
> This patch is an improvement, but in my opinion the binding is still
> a bit confusing.
> 
> How about changing 'frame-master' and 'bitclock-master' to
> 'codec-frame-master' and 'codec-bitclock-master'. We could possibly
> keep the old names as aliases until all the .dts files out there
> have been fixed.
> 
> At the same go we could add SND_SOC_DAIFMT_MASTER_MASK here:
> 
> > /* get CPU/CODEC common format via simple-audio-card,format */
> > priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
> >		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> 
> or leave the masking out all together. Can't see why
> SND_SOC_DAIFMT_CONT/GATED could not be defined at dai-link level
> too.
> 
> This way the norm would be defining the daifmt at link level. We
> could still keep the possibility to overwrite the setting at dai
> level if there is need for that.

Hi Jyri,

After looking at Morimoto-san's mail, I think there might be a better
solution for this issue as he suggested: We may move the fmt from
struct asoc_simple_dai to a common place for both CPU and CODEC.

I'm not sure if there's any defect from this idea, but as long as we
keep DAIFMT settings identical for both dai-link ends, it'll be a
neater way.

So I'd like to pend this patch and wait for further solution from that
topic.

Thank you,
Nicolin Chen


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
