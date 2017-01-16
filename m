From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v4 0/3] Generic HDMI codec: Add channel
	mapping control
Date: Mon, 16 Jan 2017 09:54:31 +0100
Message-ID: <968a714d-c802-f3de-00de-4e4889c82c63@st.com>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <CA+M3ks4rM9Fyt9ysjtruqzJeJj=cBgKddE+n0UFHpP1RMy6OgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id F25FA266218
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 09:54:35 +0100 (CET)
In-Reply-To: <CA+M3ks4rM9Fyt9ysjtruqzJeJj=cBgKddE+n0UFHpP1RMy6OgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: Takashi Iwai <tiwai@suse.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Jani Nikula <jani.nikula@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

Any comments on this patch-set?
what about the introduction of pcm new callback in DAI ops to use chmap
helpers?
Is it something reasonable, or should i come back on V1?

Regards
Arnaud

> 2017-01-03 16:52 GMT+01:00 Arnaud Pouliquen <arnaud.pouliquen@st.com>:
> Aim of this patch is to add  'Playback Channel Map' control to export
> audio capabilities in term of HDMI sink speakers allocation.
>
> V4:
> Abandon "Generic HDMI codec: Add channel mapping control" patch as it generates warnings during compilation.
>
> Workaround is to define 2 constant tables in hdmi-codec.c to declare channel mapping.
> One for stereo and one for multichannel.
> Consequence is that the behaviour is changed:
>    The chmap multichannel table export the HDMI CA configuration (tlv) and not only the one suuported by HDMI sink.
> Furthermore the chmap control .get handler is overwritten to allow to export to user the selected configuration.
>
>  - "ASoC: hdmi-codec: add channel mapping control":
>     - add hdmi_codec_stereo_chmaps and hdmi_codec_8ch_chmaps tables.
>     - implement chmap control get handler.
>  - "DRM: add help to get ELD speaker allocation"
>      => No delta vs V2.
>  - "ALSA pcm: allow non constant snd_pcm_chmap_elem"
>      => abandonned
>  - "ASoC: core: add optional pcm_new callback for DAI driver"
>      => No delta vs V2.
>
> V3:
>  - "ASoC: hdmi-codec: add channel mapping control":
>      => Minor fixes:
>          - select stereo speaker config by default if HDMI cable unplugged
>          - fix compilation warning.
>  - "DRM: add help to get ELD speaker allocation"
>      => No delta vs V2.
>  - "ALSA pcm: allow non constant snd_pcm_chmap_elem"
>      => No delta vs V2.
>  - "ASoC: core: add optional pcm_new callback for DAI driver"
>      => No delta vs V2.
>
> V2:
> In this version I use chmap helper functions from pcm_lib.c.
> It is quite tricky to use it from ASoC due to the relation chip of the controls
> with the pcm runtime.
> After several tries, my conclusion is that it must be handled in ASoC DAI driver.
> Main reason is that the DAI driver can not provide snd_pcm_chmap struct
> through kcontrol structure. But this induces that soc-core provides pcm runtime
> structure to DAI driver during probe.
>
> Base on this conclusion. I reworked my patches by adding 2
> new patches in patch-set
> 1)  ALSA pcm: allow non constant snd_pcm_chmap_elem
>    This patch allows to handle non constant channel mapping. As ELD
>    information can change during runtime it is mandatory to properly
>    handle the feature.
>    In term of compatibility with legacy it should be straightforward,
>    as update just consists in suppressing the 'const' constraint.
>
> 2)  ASoC: core: add optional pcm_new callback for DAI driver
>     This is the only way i found to be able to use
>     snd_pcm_add_chmap_ctls and associated controls helper functions.
>     From my point of view, this is the more simple way to add relationship
>     between DAI and associated pcm devices.
>    Notice that this patch, if accepted, makes the following one obsolete,
>    as it also answer to the associated topic:
>   [PATCH v5 0/2] ALSA controls management using index/device/sub-devices fields
>   (http://www.spinics.net/lists/alsa-devel/msg57639.html).
>
> If you estimate that this it not reasonable i will come back to my first version.
>
> V1:
> This patch follows discussion initiate here:
> [RFC] ASOC: HDMI audio info frame speaker allocation
> http://www.spinics.net/lists/alsa-devel/msg57363.html
>
> The code is fully inspired from HDA driver.
> On hw_param, HDMI sink speaker capabilities are exported via TLV ops
> and  a CEA allocation is choson, based on ELD information and the number of
> channels requested by user.
>
> Mains differences with HDA implementation are:
>  - Control is read only
>  - Channel swap is not supported. Consequence is that unused channel in
>    the mid of CEA audio infoframe channel mapping are considered as
>    active.
>    example for channel allocation 0x02: FL, FR, 0, FC)
>         This configuration is only available for a 4 channels stream.
>   - Channel allocation table has been reordered and HDMI 2.0 is not
>     supported.
>
> Arnaud Pouliquen (4):
>   DRM: add help to get ELD speaker allocation
>   ASoC: core: add optional pcm_new callback for DAI driver
>   ASoC: hdmi-codec: add channel mapping control
>
>  include/drm/drm_edid.h        |  13 ++
>  include/sound/soc-dai.h       |   3 +
>  sound/soc/codecs/hdmi-codec.c | 380 +++++++++++++++++++++++++++++++++++++++++-
>  sound/soc/soc-core.c          |  28 ++++
>  4 files changed, 423 insertions(+), 1 deletion(-)
>
> --
> 1.9.1
>
> 
