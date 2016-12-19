From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 0/4] Generic HDMI codec: Add channel
	mapping control
Date: Tue, 20 Dec 2016 04:49:35 +0900
Message-ID: <af6c08cc-c2ed-5b83-e17b-8798e613d349@sakamocchi.jp>
References: <1482145726-16782-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 3A0A2266DBC
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 20:49:43 +0100 (CET)
In-Reply-To: <1482145726-16782-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 19 2016 20:08, Arnaud Pouliquen wrote:
> Aim of this patch is to add  'Playback Channel Map' control to export
> audio capabilities in term of HDMI sink speakers allocation.
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
> 	This configuration is only available for a 4 channels stream.
>   - Channel allocation table has been reordered and HDMI 2.0 is not
>     supported.
>
> Arnaud Pouliquen (4):
>   DRM: add help to get ELD speaker allocation
>   ALSA pcm: allow non constant snd_pcm_chmap_elem
>   ASoC: core: add optional pcm_new callback for DAI driver
>   ASoC: hdmi-codec: add channel mapping control
>
>  include/drm/drm_edid.h        |  13 ++
>  include/sound/pcm.h           |   4 +-
>  include/sound/soc-dai.h       |   3 +
>  sound/core/pcm_lib.c          |   6 +-
>  sound/soc/codecs/hdmi-codec.c | 313 +++++++++++++++++++++++++++++++++++++++++-
>  sound/soc/soc-core.c          |  28 ++++
>  6 files changed, 361 insertions(+), 6 deletions(-)

I'm sorry but please drop me from CC list. I'd like not to be involved 
into this kind of new integration within merge window of next Linux 
kernel, as I said to you.


Regards

Takashi Sakamoto
