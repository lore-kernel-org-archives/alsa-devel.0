From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE
	internal
Date: Mon, 27 Apr 2015 21:22:43 +0200
Message-ID: <553E8C83.4030604@metafoo.de>
References: <1430131465-17991-1-git-send-email-lars@metafoo.de>
 <20150427182801.GX22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C253260415
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 21:22:44 +0200 (CEST)
In-Reply-To: <20150427182801.GX22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 04/27/2015 08:28 PM, Mark Brown wrote:
> On Mon, Apr 27, 2015 at 12:44:25PM +0200, Lars-Peter Clausen wrote:
[...]
>> This patch makes the FLAG_NO_RESIDUE internal and no longer allows audio
>> controller drivers to manually set the flag. If a DMA driver against
>> expectations does not support reporting its capabilities for now the generic
>> DMAengine PCM driver will now emit a warning and simply assume that residue
>> reporting is not supported. In the future this might be changed to aborting
>> with an error.
>
> I'm not sure it's ever going to buy us anything to error out on stuff,
> it's not like the no residue case doesn't need to be supported anyway
> for controllers that just can't do it.

I'm not too sure about it either. Since it is prone to race-conditions by 
design we'd ideally eventually drop support for the fallback period counting 
mechanism in the PCM driver altogether and instead the period counting would 
be done at the DMAengine layer. At the DMAengine layer the period counting 
can usually be implemented without any race conditions and other DMAengine 
clients will also benefit from it.

A good start might be to emit a warning when we have to do this in the PCM 
driver to at least make sure that new platforms do this properly.

- Lars
