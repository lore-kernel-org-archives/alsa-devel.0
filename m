From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Tue, 6 Oct 2015 18:44:34 +0300
Message-ID: <5613EC62.8000007@ti.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 74F36265715
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:44:41 +0200 (CEST)
In-Reply-To: <561392F7.90608@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 10/06/15 12:23, Arnaud Pouliquen wrote:
> Hello Jyri,
>
> Thanks your feedback, my answers in line
>
>
> On 10/05/2015 03:27 PM, Jyri Sarha wrote:
>> On 10/01/15 19:50, Arnaud Pouliquen wrote:
>>>
>>> Version 2:
>>> This version integrates missing features upgraded to be aligned when
>>> possible
>>> with patch set:
>>> [PATCH RFC v4 0/8] Implement generic ASoC HDMI codec and use it in
>>> tda998x
>>>
>>
>> There are still some details I would like to change if we decide to go
>> the drm audio bridge way. But before all that, I would like to ask,
>> why should we go forward with your approach? Is there anything that
>> can be done with your approach, but can not be done with mine?
>>
>> Don't take me wrong, I do not see anything fundamentally wrong with
>> your approach. I would just like hear some justification why we should
>> abandon my approach - that I've been working on for some time - and go
>> forward with yours.
>
> Both implementations are similar in term of feature. And i think both
> have advantages and drawbacks...
> The main difference, is that my approach is based on a standard service
> client-provider model.
> Means that ops are defined by code in charge of providing the service
> (DRM) and not by the client (ALSA).
> I don't want to impose my implementation but just propose an alternative
> that makes sense for me.
>

My model merely sees a driver providing access to a piece standard HDMI =

HW with audio functionality trough ASoC codec DAI API.

> In a first step, before going deep in discussion on the approach, it
> should be interesting to have maintainers feedback, to be sure that my
> approach could make sense from DRM and ALSA point of view.
>

Absolutely. In the end the maintainers need to make the final decision =

any way.

> @DRM (and ALSA) maintainers:
> Please, could you give a first feedback on such implementation based on
> DRM API extension?
> Is it something that could be acceptable (or not) from your point of view?
>
>>
>> Here is couple of benefits I can name in my approach:
>> =AD Video side agnostic implementation
>>      The ASoC side does not need to know anything about video side
>>      implementation. There is no real exposure ASoC side internals in
>>      video side either. Even fbdev driver, or some other non DRM video
>>      driver, could use my implementation.
> My approach is the reverse: DRM driver does not need to know anything
> about audio side. As ALSA is the client of DRM, seems more logical from
> my point of view ...
> Now if a generic solution must be found for all video drivers, sure,
> your solution is more flexible.
> But if i well understood fbdev drivers are no more accepted for upstream
> (please correct me if I'm wrong).
> So i don't know we have to keep fbdev in picture...
>

I am not promoting fbdev support. I am merely asking if we want to force =

all HDMI drivers to implement a drm_bridge if they want to support audio.

>> - HDMI encoder driver implementations that do not use DRM bridge
>>     abstraction do not need add an extra DRM object just to get the
>>     audio working.
>>
>> Short comings I see in the current HDMI audio bridge approach:
>>
>> In its current from the DRM audio bridge abstraction pretends to be a
>> generic audio abstraction for DRM devices, but the implementation is
>> quite specific to external HDMI encoders with spdif and/or i2s
>> interface. There is a lot of HDMI video devices that provide the
>> digital audio interface (ASoC DAI) directly and there is no need for
>> anything but dummy codec implementation (if following ASoC
>> paradigm). Before going forward I think we should at least consider
>> how this abstraction would serve those devices.
> Sorry, but i don't see any difference between both implementations for
> this point.In both implementations, ops are called only if defined.
> Could you give me name of the drivers you have in mind?

I am not talking about Beaglebone-Black or tda998x here. There are =

platforms where video HW provides the digital audio interface for HDMI =

audio directly. For instance OMAP4 and OMAP5 (see =

sound/soc/omap/omap-hdmi-audio.c and drivers/video/fbdev/omap2/dss/) are =

like that.

>>
>> Also, I am not entirely happy how the drm_audio_bridge_funcs are used
>> at the moment. The do not map too well to ASoC DAI callbacks and I do
>> not see too much point in creating a completely new audio-callback
>> abstraction, that is sligtly incompatible with ALSA, and then
>> translating alsa callbacks to these new callbacks. I think the
>> callbacks should map more or less directly ALSA callbacks.
>
> As API is defined in DRM, it seems more logical to match it with the one
> defined for video. From my windows, i didn't see any blocking point to
> connect codec callback with this API.
> But anyway, this API is not freezed, it could be improved with your help.

The most usual things can be made to work with your API too, but the =

translation is not the most efficient one and some features are missing, =

for instance muting. Also, in ALSA side the prepare and trigger =

callbacks are meant to be used only for starting and stopping the audio =

stream. The stream is configured before either one of those are called. =

With your API each pause+resume from a video client will reconfigure the =

audio from the scratch.

Best regards,
Jyri
