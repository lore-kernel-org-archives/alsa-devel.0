From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] hda - delayed ELD repoll
Date: Wed, 16 Nov 2011 07:51:28 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D7487A@HQMAIL01.nvidia.com>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
	<74CDBE0F657A3D45AFBB94109FB122FF1740805DE1@HQMAIL01.nvidia.com>
	<20111116024806.GB11375@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 57AA824559
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 16:51:44 +0100 (CET)
In-Reply-To: <20111116024806.GB11375@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Wu Fengguang wrote at Tuesday, November 15, 2011 7:48 PM:
> On Wed, Nov 16, 2011 at 02:25:00AM +0800, Stephen Warren wrote:
> > Wu Fengguang wrote at Tuesday, November 15, 2011 7:33 AM:
> > > The Intel HDMI chips (ironlake at least) are found to have ~250ms delay
> > > between the ELD_Valid=1 hotplug event is send and the ELD buffer becomes
> > > actually readable. During the time the ELD buffer is mysteriously all 0.
> > >
> > > Fix it by scheduling a delayed work to re-read ELD buffer after 300ms.
> >
> > Any idea why; is the graphics driver writing the ELD data to the audio HW
> > after triggering the unsolicited even rather than before, or something
> > like that?
> 
> Nope. The graphics driver is doing
> 
>         eld_valid = 0
>         write to eld buffer
>         eld_valid = 1

OK, that sounds fine.

> > 250mS almost sounds like it's setting ELDV in the audio HW,
> > then going and reading the EDID, then writing the EDID to the audio HW;
> > perhaps the graphics driver is accidentally setting PRESENT+ELDV when it's
> > meant to be setting just PRESENT, and later setting ELDV?
> 
> From the debug dmesg, I'm pretty sure that the ELDV events are
> triggered exactly by the "eld_valid = 0" and "eld_valid = 1" register
> writes. Since the ELD data is already prepared, there is no EDID read
> in between.
> 
> Below is the dmesg representing a video mode set.
> 
> ELD writes from the graphics driver
> 
> [  424.254958] [drm:intel_write_eld], ELD on [CONNECTOR:12:HDMI-A-2], [ENCODER:11:TMDS-11]
> [  424.257670] [drm:ironlake_write_eld], ELD on pipe B
> [  424.259833] [drm:ironlake_write_eld], Audio directed to unknown port
> [  424.262156] [drm:ironlake_write_eld], ELD size 13
> 
> ELD events received by audio driver (eld reads 0)
> 
> [  424.263258] HDMI hot plug event: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=0

That line makes sense.

> [  424.265877] HDMI status: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1

I don't /think/ it's related to this issue, but I wonder why ELDV==1 in
that message; it seems that the unsolicited response contains the correct
data, but AC_VERB_GET_PIN_SENSE contains ELDV==1 all the time. That's odd.

> [  424.272415] ALSA hda_eld.c:259 HDMI: Unknown ELD version 0
> [  424.274566] HDMI hot plug event: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1
> [  424.277027] HDMI status: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1
> [  424.283157] ALSA hda_eld.c:259 HDMI: Unknown ELD version 0
> 
> graphics driver go on with its job
> 
> [  424.314331] [drm:intel_wait_for_vblank], vblank wait timed out
> [  424.367183] [drm:intel_wait_for_vblank], vblank wait timed out
> [  424.368960] [drm:ironlake_update_wm], FIFO watermarks For pipe A - plane 5, cursor: 6
> [  424.370700] [drm:ironlake_update_wm], FIFO watermarks For pipe B - plane 42, cursor: 6
> [  424.424056] [drm:intel_wait_for_vblank], vblank wait timed out
> [  424.476906] [drm:intel_wait_for_vblank], vblank wait timed out
> [  424.479169] [drm:ironlake_fdi_link_train], FDI_RX_IIR 0x100
> [  424.481084] [drm:ironlake_fdi_link_train], FDI train 1 done.
> [  424.483452] [drm:ironlake_fdi_link_train], FDI_RX_IIR 0x600
> [  424.485444] [drm:ironlake_fdi_link_train], FDI train 2 done.
> [  424.486765] [drm:ironlake_fdi_link_train], FDI train done
> [  424.490820] [drm:intel_update_fbc],
> [  424.491841] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
> [  424.494449] [drm:drm_crtc_helper_set_config],        [CONNECTOR:12:HDMI-A-2] set DPMS on
> [  424.505904] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
> 
> audio driver repoll the ELD after 300ms (eld data readable now)
> 
> [  424.574763] HDMI status: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1
> [  424.580867] HDMI: detected monitor RX-V1800 at connection type HDMI
> [  424.582413] HDMI: available speakers: FL/FR LFE FC RL/RR RC RLC/RRC
...

OK, well I guess this make it work, and I don't think the patch will cause
any issues on HW without this issue, so the patch is fine. I'd still love
to understand why this is happening though.

-- 
nvpublic
