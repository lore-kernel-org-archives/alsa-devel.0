From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Wed, 17 Apr 2013 20:45:01 +0200
Message-ID: <516EEDAD.40706@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de> <516E6FD8.5040400@ti.com>
 <516E7DF1.6080905@metafoo.de> <516E9E5E.4090901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-008.synserver.de (smtp-out-014.synserver.de
 [212.40.185.14])
 by alsa0.perex.cz (Postfix) with ESMTP id C449926172C
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 20:46:05 +0200 (CEST)
In-Reply-To: <516E9E5E.4090901@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 03:06 PM, Peter Ujfalusi wrote:
> On 04/17/2013 12:48 PM, Lars-Peter Clausen wrote:
>> This sounds like it needs more than just support for custom channel names.
>> The generic driver currently expects that there is exactly one DMA channel
>> for capture and one for playback (well and in case the DAI link is simplex
>> only either one of them).
>>
>> What are these 8 channels exactly used for?
> 
> We have 7 FIFOs which can be configured either playback or capture. The last
> channel is used for debug purposes only right now.
> Basically we can dynamically configure the 8 DMA channel for playback/capture
> and the mixing of incoming streams done inside of the AESS.
> We have 7 DAIs and we have playback/capture on those (some only have playback
> some only capture some duplex). Right now we have kind of static DMA bindings
> for them, I'm working on a dynamic model right now.

Hm, if you need to re-assign the DMA channels dynamically at runtime it
maybe better to stick with a custom PCM driver. Should I drop OMAP from this
series for now?

- Lars
