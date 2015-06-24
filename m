From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl: Add dedicated DMA buffer size
	for each cpu dai
Date: Wed, 24 Jun 2015 07:34:21 -0500
Message-ID: <558AA3CD.3070802@tabi.org>
References: <1435055033-12608-1-git-send-email-shengjiu.wang@freescale.com>
 <20150624070037.GA2926@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id C1D932616EF
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 14:33:55 +0200 (CEST)
In-Reply-To: <20150624070037.GA2926@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
>> >As the ssi is not the only cpu dai, there are esai, spdif, sai.
>> >and imx_pcm_dma can be used by all of them. Especially ESAI need
>> >a larger DMA buffer size. So Add dedicated DMA buffer for each cpu
>> >dai.
>> >
>> >Signed-off-by: Shengjiu Wang<shengjiu.wang@freescale.com>
> Acked-by: Nicolin Chen<nicoleotsuka@gmail.com>

Acked-by: Timur Tabi <timur@tabi.org>
