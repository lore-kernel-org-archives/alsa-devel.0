From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 06/19] ASoC: fsl: Don't set unused struct
 snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 08:25:53 -0600
Message-ID: <52B45371.8020808@tabi.org>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id C4DD32657E8
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:25:57 +0100 (CET)
In-Reply-To: <1387545625-19240-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Nicolin Chen <b42378@freescale.com>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Is this new?  There are formats that the codec and the SSI support that 
the DMA controller does NOT support, like packed 24-bit samples.  How do 
we ensure that we never get those?
