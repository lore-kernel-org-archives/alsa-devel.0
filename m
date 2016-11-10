From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320aic31xx: Support for
	tlv320dac3101
Date: Thu, 10 Nov 2016 10:59:14 +0200
Message-ID: <5fb202cb-c85e-ccbc-b146-58628a040e07@ti.com>
References: <20161110075555.7878-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FE43265142
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 09:59:21 +0100 (CET)
In-Reply-To: <20161110075555.7878-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On 11/10/16 09:55, Peter Ujfalusi wrote:
> Hi,
> 
> Adding missing compatible declaration for dac3100 and add support for dac3101.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ASoC: tlv320aic31xx: Add missing of_device_id for dac3100
>   ASoC: tlv320aic31xx: Add support for tlv320dac3101
> 
>  Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 1 +
>  sound/soc/codecs/tlv320aic31xx.c                          | 3 +++
>  sound/soc/codecs/tlv320aic31xx.h                          | 1 +
>  3 files changed, 5 insertions(+)
> 

Reviewed-by: Jyri Sarha <jsarha@ti.com>

For both.

Cheers,
Jyri
