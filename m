From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2] ASoC: simple-card: overwrite
	cpu_dai->fmt with codec_dai->fmt
Date: Wed, 12 Mar 2014 11:25:32 +0200
Message-ID: <5320280C.6080004@ti.com>
References: <1394593331-22867-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2A126086C
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 10:25:40 +0100 (CET)
In-Reply-To: <1394593331-22867-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org, moinejf@free.fr
List-Id: alsa-devel@alsa-project.org

On 03/12/2014 05:02 AM, Nicolin Chen wrote:
> The current simple-card driver separates the daimft for cpu_dai and codec_dai.
> So we might get different values for them (0x4003 and 0x1003 for example):
>
> asoc-simple-card sound-cs42888.12: cpu : 2024000.esai / 4003 / 132000000
> asoc-simple-card sound-cs42888.12: codec : cs42888 / 1003 / 24576000
> asoc-simple-card sound-cs42888.12: cs42888 <-> 2024000.esai mapping ok
>
> This is not allowed at all as we need to keep the DAIFMT settings identical
> for both the ends of the link.
>
> Thus this patch fixes it by overwriting the cpu_dai->fmt with codec_dai->fmt
> since we defined the DAIFMT_MASTER basing on CODEC at the first place while
> the other bits are same.
>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
Hi Nicolin,
This patch is an improvement, but in my opinion the binding is still a 
bit confusing.

How about changing 'frame-master' and 'bitclock-master' to 
'codec-frame-master' and 'codec-bitclock-master'. We could possibly keep 
the old names as aliases until all the .dts files out there have been fixed.

At the same go we could add SND_SOC_DAIFMT_MASTER_MASK here:

 > /* get CPU/CODEC common format via simple-audio-card,format */
 > priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 >		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);

or leave the masking out all together. Can't see why 
SND_SOC_DAIFMT_CONT/GATED could not be defined at dai-link level too.

This way the norm would be defining the daifmt at link level. We could 
still keep the possibility to overwrite the setting at dai level if 
there is need for that.

Best regards,
Jyri
