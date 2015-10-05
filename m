From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Mon, 5 Oct 2015 16:27:55 +0300
Message-ID: <56127ADB.6080700@ti.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C9F2605B4
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 15:28:05 +0200 (CEST)
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, broonie@kernel.org, lgirdwood@gmail.com, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 10/01/15 19:50, Arnaud Pouliquen wrote:
>
> Version 2:
> This version integrates missing features upgraded to be aligned when poss=
ible
> with patch set:
> [PATCH RFC v4 0/8] Implement generic ASoC HDMI codec and use it in tda998x
>

There are still some details I would like to change if we decide to go
the drm audio bridge way. But before all that, I would like to ask,
why should we go forward with your approach? Is there anything that
can be done with your approach, but can not be done with mine?

Don't take me wrong, I do not see anything fundamentally wrong with
your approach. I would just like hear some justification why we should
abandon my approach - that I've been working on for some time - and go
forward with yours.

Here is couple of benefits I can name in my approach:
=AD Video side agnostic implementation
    The ASoC side does not need to know anything about video side
    implementation. There is no real exposure ASoC side internals in
    video side either. Even fbdev driver, or some other non DRM video
    driver, could use my implementation.
- HDMI encoder driver implementations that do not use DRM bridge
   abstraction do not need add an extra DRM object just to get the
   audio working.

Short comings I see in the current HDMI audio bridge approach:

In its current from the DRM audio bridge abstraction pretends to be a
generic audio abstraction for DRM devices, but the implementation is
quite specific to external HDMI encoders with spdif and/or i2s
interface. There is a lot of HDMI video devices that provide the
digital audio interface (ASoC DAI) directly and there is no need for
anything but dummy codec implementation (if following ASoC
paradigm). Before going forward I think we should at least consider
how this abstraction would serve those devices.

Also, I am not entirely happy how the drm_audio_bridge_funcs are used
at the moment. The do not map too well to ASoC DAI callbacks and I do
not see too much point in creating a completely new audio-callback
abstraction, that is sligtly incompatible with ALSA, and then
translating alsa callbacks to these new callbacks. I think the
callbacks should map more or less directly ALSA callbacks.

Best regards,
Jyri


> It does not support the abort callback, the mute and syclk ops.
> This could be added in V3 or separate patch if justified.
>
>    [RFC 1/5]video: hdmi: add help function for N and CTS
> 	- Replace real frequency value by enum in switch case
> 	Notice that this patch is independant from the rest of the implentation
>    [RFC 2/5]drm: add helper functions to add audio capabilities for bridge
> 	- extend audio bridge ops
>    [RFC 3/5]ASoC: codec:  hdmi drm codec driver
> 	aligned when possible with hdmi-codec.c implementation
> 	. ELD management for alsa contraints
> 	. Support of SPDIF and I2S mode
> 	. hwparam ond set_fmt functions implemented
>    [RFC 4/5]drm: sti: connect audio driver
> 	=3D> Implementation for STI platform
>    [RFC 5/5]DT: sti: add audio HDMI dai link in audio card
> 	=3D> Devicetree example
>
> Version 1:
>
> This patch set is a tentative to implement a generic code for the HDMI au=
dio.
> Main concept are aligned with solution proposeded for TI platform.
>   -  ASoC codec driver registered by DRM driver
>   -  ASOC driver is a generic driver.
>   -  compatible with simple card
>
>   Difference is that i propose a DRM generic interface based on bridge st=
ructure.
>   Advantage is that all data exchanges are done through the DRM API.
>
>   I think also that some helper functions could been used for N and CTS p=
arameters calculation,
>   as suggested by Russell King in a previous mail.
>
>   I full aware that some features (like ELD and info frame) are partially=
 or not implemented in my patches.
>   This patch set is more a skeleton than a full implementation...
>   I just post it to suggest a possible DRM API.
>
> Arnaud Pouliquen (5):
>    video: hdmi: add helper function for N and CTS
>    drm: add helper function to add audio capabilities for bridge
>    ASoC: codec:  hdmi drm codec driver
>    drm: sti: connect audio driver
>    DT: sti: add audio HDMI dai link in audio card
>
>   arch/arm/boot/dts/stih410.dtsi       |   6 +-
>   arch/arm/boot/dts/stihxxx-b2120.dtsi |  21 ++
>   drivers/gpu/drm/drm_bridge.c         | 137 +++++++++++++-
>   drivers/gpu/drm/sti/sti_hdmi.c       | 184 ++++++++++++++++--
>   drivers/gpu/drm/sti/sti_hdmi.h       |   3 +
>   drivers/video/hdmi.c                 | 147 ++++++++++++++
>   include/drm/drm_crtc.h               |  62 ++++++
>   include/drm/drm_modes.h              |  12 ++
>   include/linux/hdmi.h                 |  12 ++
>   include/sound/hdmi_drm.h             |  15 ++
>   sound/soc/codecs/Kconfig             |   8 +-
>   sound/soc/codecs/Makefile            |   2 +
>   sound/soc/codecs/hdmi_drm.c          | 358 ++++++++++++++++++++++++++++=
+++++++
>   13 files changed, 951 insertions(+), 16 deletions(-)
>   create mode 100644 include/sound/hdmi_drm.h
>   create mode 100644 sound/soc/codecs/hdmi_drm.c
>
