From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Thu, 18 Apr 2013 09:30:47 +0200
Message-ID: <516FA127.40606@ti.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de> <516E6FD8.5040400@ti.com>
 <516E7DF1.6080905@metafoo.de> <516E9E5E.4090901@ti.com>
 <516EEDAD.40706@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB4F265E15
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 09:30:55 +0200 (CEST)
In-Reply-To: <516EEDAD.40706@metafoo.de>
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

Hi Lars,

On 04/17/2013 08:45 PM, Lars-Peter Clausen wrote:
> On 04/17/2013 03:06 PM, Peter Ujfalusi wrote:
>> On 04/17/2013 12:48 PM, Lars-Peter Clausen wrote:
>>> This sounds like it needs more than just support for custom channel nam=
es.
>>> The generic driver currently expects that there is exactly one DMA chan=
nel
>>> for capture and one for playback (well and in case the DAI link is simp=
lex
>>> only either one of them).
>>>
>>> What are these 8 channels exactly used for?
>>
>> We have 7 FIFOs which can be configured either playback or capture. The =
last
>> channel is used for debug purposes only right now.
>> Basically we can dynamically configure the 8 DMA channel for playback/ca=
pture
>> and the mixing of incoming streams done inside of the AESS.
>> We have 7 DAIs and we have playback/capture on those (some only have pla=
yback
>> some only capture some duplex). Right now we have kind of static DMA bin=
dings
>> for them, I'm working on a dynamic model right now.
> =

> Hm, if you need to re-assign the DMA channels dynamically at runtime it
> maybe better to stick with a custom PCM driver. Should I drop OMAP from t=
his
> series for now?

I think this would the best for now. However I did tested the series and it
worked with the code upstream.
Later I can revisit this and probably have two PCM driver for OMAP, but I'm
not sure about this right now, I will know more when I have rebased my
AESS/ABE work on top of 3.10-rc1.

Can you drop the OMAP patches for now?

Thanks,
P=E9ter
