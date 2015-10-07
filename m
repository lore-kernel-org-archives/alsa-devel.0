From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Wed, 7 Oct 2015 10:19:27 +0200
Message-ID: <5614D58F.9010102@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com> <5613EC62.8000007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F016A2658CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 10:19:34 +0200 (CEST)
In-Reply-To: <5613EC62.8000007@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org



>> My approach is the reverse: DRM driver does not need to know anything
>> about audio side. As ALSA is the client of DRM, seems more logical from
>> my point of view ...
>> Now if a generic solution must be found for all video drivers, sure,
>> your solution is more flexible.
>> But if i well understood fbdev drivers are no more accepted for upstream
>> (please correct me if I'm wrong).
>> So i don't know we have to keep fbdev in picture...
>>
>
> I am not promoting fbdev support. I am merely asking if we want to force
> all HDMI drivers to implement a drm_bridge if they want to support audio.
>
Yes this is a good point... My implementation is based on hypothesis 
that HDMI drivers are now upstreamed as DRM drivers.

>>> - HDMI encoder driver implementations that do not use DRM bridge
>>>      abstraction do not need add an extra DRM object just to get the
>>>      audio working.
>>>
>>> Short comings I see in the current HDMI audio bridge approach:
>>>
>>> In its current from the DRM audio bridge abstraction pretends to be a
>>> generic audio abstraction for DRM devices, but the implementation is
>>> quite specific to external HDMI encoders with spdif and/or i2s
>>> interface. There is a lot of HDMI video devices that provide the
>>> digital audio interface (ASoC DAI) directly and there is no need for
>>> anything but dummy codec implementation (if following ASoC
>>> paradigm). Before going forward I think we should at least consider
>>> how this abstraction would serve those devices.
>> Sorry, but i don't see any difference between both implementations for
>> this point.In both implementations, ops are called only if defined.
>> Could you give me name of the drivers you have in mind?
>
> I am not talking about Beaglebone-Black or tda998x here. There are
> platforms where video HW provides the digital audio interface for HDMI
> audio directly. For instance OMAP4 and OMAP5 (see
> sound/soc/omap/omap-hdmi-audio.c and drivers/video/fbdev/omap2/dss/) are
> like that.
Not checked in details but seems similar to your approach except ops 
used by cpu_dai.

>
>>>
>>> Also, I am not entirely happy how the drm_audio_bridge_funcs are used
>>> at the moment. The do not map too well to ASoC DAI callbacks and I do
>>> not see too much point in creating a completely new audio-callback
>>> abstraction, that is sligtly incompatible with ALSA, and then
>>> translating alsa callbacks to these new callbacks. I think the
>>> callbacks should map more or less directly ALSA callbacks.
>>
>> As API is defined in DRM, it seems more logical to match it with the one
>> defined for video. From my windows, i didn't see any blocking point to
>> connect codec callback with this API.
>> But anyway, this API is not freezed, it could be improved with your help.
>
> The most usual things can be made to work with your API too, but the
> translation is not the most efficient one and some features are missing,
> for instance muting.
Could be added but is it necessary if trigger is implemented?( see my 
next comments)

> Also, in ALSA side the prepare and trigger
> callbacks are meant to be used only for starting and stopping the audio
> stream.
Yes but for me, it is required. Otherwise how to manage CPU-DAI master 
configuration?
if stream is stopped, cpu_dai can be stopped as there is no more stream 
to sent on bus. If no information is sent to HDMI, This generates HDMI 
codec or protocol issue...
Use startup/shutdown/digital_mute seems not sufficient.

The stream is configured before either one of those are called.
> With your API each pause+resume from a video client will reconfigure the
> audio from the scratch.
Configuration is sent using pre_enable operation. So no reconfiguration 
should be re-applied.

Best Regards
Arnaud
