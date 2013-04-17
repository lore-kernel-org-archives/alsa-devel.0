From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Wed, 17 Apr 2013 15:06:38 +0200
Message-ID: <516E9E5E.4090901@ti.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de> <516E6FD8.5040400@ti.com>
 <516E7DF1.6080905@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FFE261666
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:06:45 +0200 (CEST)
In-Reply-To: <516E7DF1.6080905@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 12:48 PM, Lars-Peter Clausen wrote:
> This sounds like it needs more than just support for custom channel names.
> The generic driver currently expects that there is exactly one DMA channel
> for capture and one for playback (well and in case the DAI link is simplex
> only either one of them).
> =

> What are these 8 channels exactly used for?

We have 7 FIFOs which can be configured either playback or capture. The last
channel is used for debug purposes only right now.
Basically we can dynamically configure the 8 DMA channel for playback/captu=
re
and the mixing of incoming streams done inside of the AESS.
We have 7 DAIs and we have playback/capture on those (some only have playba=
ck
some only capture some duplex). Right now we have kind of static DMA bindin=
gs
for them, I'm working on a dynamic model right now.

So one IP (one driver) which can request 8 DMA and depending on the stream
(DAI in use) we pick one of them to be used.

-- =

P=E9ter
