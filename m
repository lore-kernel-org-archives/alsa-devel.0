From: Jyri Sarha <jsarha@ti.com>
Subject: Re: HDMI codec, way forward?
Date: Mon, 19 Oct 2015 16:10:32 +0300
Message-ID: <5624EBC8.1010105@ti.com>
References: <5620E482.6050507@ti.com> <562100EC.4030701@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E575126580B
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 15:10:38 +0200 (CEST)
In-Reply-To: <562100EC.4030701@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, =?UTF-8?Q?Russell_King_-_ARM_Linux_=e2=80=8e?= <linux@arm.linux.org.uk>, "lars@metafoo.de" <lars@metafoo.de>, Jean-Francois Moine <moinejf@free.fr>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 10/16/15 16:51, Arnaud Pouliquen wrote:
>> After reading the ELCE Audio mini conf minutes [1] I gather that HDMI
>> audio was not discussed after all.
>>
>> My conclusion from the Lars-Peter's latest mail [2] related to the
>> subject is that the wind is currently blowing slightly in favour of my
>> version of the hdmi codec [3], or at least not in favour of Arnaud's
>> version [4].
> Based on previous discussions and lack of feedback from DRM community,
> This make sens for me.
>
>>
>> So how should we proceed? Are we still waiting for some feedback from
>> DRM/video side?
>>
>> There was not too many clear suggestions to my latest patch series
>> [3], so I do not see too much point in sending yet another version of
>> that series.
>   For me, some points need to be clarified:
> - Do we need the abort callback. Is there a uses cases that makes it
> mandatory (some timeout mechanism already exists to stop audio...)
>

I am not currently using the abort_cb my self, so it can be dropped as 
well. Is should not be needed for codec DAI implementations, as long as 
the CPU-DAI is the i2s master.

> - Does trigger is needed when CPU-DAI is master on bus?
> Otherwise how to inform HDMI that I2S bus is no more clocked? I'm not
> sure that mute is sufficient for all hardwares... For instance for my
> hardware CTS parameter is hardware computed based on I2S L/R clock.
>

The most of the codec drivers do not implement the trigger callback as 
the stream start and stop timing is usually handled at the CPU-DAI. 
Codec is just prepared (quite often even without prepare callback) and 
the stream start/stop is triggered at CPU DAI end. However, I should 
probably still implement the trigger callback and let the video side 
driver decide if it needs it or not.

> - IEC controls to support compress mode. This should be handled by codec
> driver in I2S mode, but not in SPDIF mode.
>
>>
>> Arnaud, if I'd try to make a patch series that would implement sti
>> HDMI audio with my HDMI codec, would you be willing try that out?
> hmm...more simple that i do the stuff for sti platform as some pieces of
> code are missing today in kernel (Device tree part).
> I will try to find time next week to make a prototype for test and give
> you a feedback.
>

That would be even better. Just let me know I can help you in any way.

> Additional point: We should also define some new helper functions:
>
> - For N and CTS HDMI parameters: In my RFC i have proposed helper
> function, don't know if that matches with other platforms need...
>

Absolutely, but I don't think these helpers should have any direct 
association to ASoC side. So they are in a way orthogonal to the ASoC 
side HDMI codec implementation. But very relevant to the video side 
driver registering the HDMI codec.

> - For IEC standard controls (could be added in core/pcm_iec958.c)
>

Oh, I did not even realize that there are predefined special kcontrols 
for handling the status bits. Adding those sounds like right thing to do.

Cheers,
Jyr
