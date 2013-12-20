From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 06/19] ASoC: fsl: Don't set unused struct
 snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 15:04:08 +0100
Message-ID: <52B44E58.4080609@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-6-git-send-email-lars@metafoo.de>
 <52B45371.8020808@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-126.synserver.de
 [212.40.185.126])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E6D26534C
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 16:03:13 +0100 (CET)
In-Reply-To: <52B45371.8020808@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 12/20/2013 03:25 PM, Timur Tabi wrote:
> Lars-Peter Clausen wrote:
>> The ASoC core assumes that the PCM component of the ASoC card transparently
>> moves data around and does not impose any restrictions on the memory
>> layout or
>> the transfer speed. It ignores all fields from the snd_pcm_hardware struct
>> for
>> the PCM driver that are related to this. Setting these fields in the PCM
>> driver
>> might suggest otherwise though, so rather not set them.
> 
> Is this new?  There are formats that the codec and the SSI support that the
> DMA controller does NOT support, like packed 24-bit samples.  How do we
> ensure that we never get those?

No, this is how it has always been. If there are restrictions imposed by the
DMA controller we need to add support for expressing this inside the ASoC
framework. But I think it will probably be more complex than just saying the
DMA controller supports format A, B, C and the DAI controller supports
format B, C, D and then just do the intersection of both. E.g. the DAI
controller probably does not care whether the samples are packed or not if
it only sees one sample at a time, while

- Lars
