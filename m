From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC 0/4] ALSA controls management
	using	index/device/sub-devices fields
Date: Tue, 8 Nov 2016 10:52:55 +0100
Message-ID: <a5b9dbde-f864-34ef-8703-e7d6cd4a8904@ladisch.de>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E01122666FA
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 10:52:57 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Arnaud Pouliquen wrote:
> 1-1) How to Instantiate generic ALSA control
>
> The  point is the handling of multi instance of generic ALSA controls.
> In this case "prefix" can not be used. Controls have to be identified
> by a combination of device/sub-device/index

Controls are identified either
- by their numid, or
- by the combination of iface/device/subdevice/name/index.

The device/subdevice fields are used to link controls with PCM devices;
this is needed for per-stream volume controls or for the S/PDIF "Mask"
controls, which set properties of some PCM stream.

>     Should we always apply this rules?
>       - MIXER control type: as it is not linked to PCM device but card,
> 	"index" is used to instantiate control.

"index" is _always_ used.

>       - PCM control type: as it is linked to PCM device,
>         "device/subdevice" is used to instantiate control.
>     Or could we consider that a control can be instantiated using
>       device/subdevice fields  and/or index fields?

The amixer tool does not allow controls with the same iface/name/index
values, regardless of the (sub)device values.  This appears to be a bug
in amixer (because the behaviour is different from the kernel's), but
the (sub)device fields were never intended to be used by MIXER controls,
and PCM controls typically are inactive when their stream is closed.

>    - Concerning IEC controls, should we consider them as PCM or MIXER
>      type controls? In current implementations both are used...

MIXER controls are shown in alsamixer.  PCM controls are hidden, and
accessed by software.

Something like "IEC958 Playback Switch" should be MIXER, and "IEC958
Playback Con Mask", PCM.

> 2) From driver point of view
>
> 2-1) None SOC drivers:
> Today solution seems to base indexation on both "index" and "device"
> number. Device indexation seems not linked to PCM device number
> Example in  ea9b43addc4d ("ALSA: hda - Fix broken workaround for HDMI/SPDIF conflicts").
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add
>
> => The drawback is that each driver has to implement it. Could be nice
>    to have in generic code....

In the good old times, the ALSA framework assumed that a driver knows
all its controls, and handles conflicts by assignind index values.

It would be useful to let snd_ctl_add() assign a new index automatically,
but only if explicitly requested (e.g., something like
"#define SNDRV_CTL_INDEX_AUTO -1").

> 2-2) SOC drivers:
>   - Relation chip between control and PCM device. if rules mentioned
>     in 1-3 should be respected, need to link control to PCM device.

What is this link needed for?  Is that control set by software (PCM), or
by the user (MIXER)?


Regards,
Clemens
