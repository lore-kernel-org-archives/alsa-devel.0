From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/2] hda - delayed ELD repoll
Date: Thu, 17 Nov 2011 07:12:03 +0800
Message-ID: <20111116231203.GA10320@localhost>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
	<74CDBE0F657A3D45AFBB94109FB122FF1740805DE1@HQMAIL01.nvidia.com>
	<20111116024806.GB11375@localhost>
	<74CDBE0F657A3D45AFBB94109FB122FF1740D7487A@HQMAIL01.nvidia.com>
	<20111116224659.GA4981@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A240103975
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 00:12:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111116224659.GA4981@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> > > Below is the dmesg representing a video mode set.
> > > 
> > > ELD writes from the graphics driver
> > > 
> > > [  424.254958] [drm:intel_write_eld], ELD on [CONNECTOR:12:HDMI-A-2], [ENCODER:11:TMDS-11]
> > > [  424.257670] [drm:ironlake_write_eld], ELD on pipe B
> > > [  424.259833] [drm:ironlake_write_eld], Audio directed to unknown port
> > > [  424.262156] [drm:ironlake_write_eld], ELD size 13
> > > 
> > > ELD events received by audio driver (eld reads 0)
> > > 
> > > [  424.263258] HDMI hot plug event: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=0
> > 
> > That line makes sense.
> > 
> > > [  424.265877] HDMI status: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1
> > 
> > I don't /think/ it's related to this issue, but I wonder why ELDV==1 in
> > that message; it seems that the unsolicited response contains the correct
> > data, but AC_VERB_GET_PIN_SENSE contains ELDV==1 all the time. That's odd.
> 
> It depends on timing. When audio driver receives the unsolicited event, 
> graphics driver has finished with "eld_valid = 1", hence
> AC_VERB_GET_PIN_SENSE returns ELDV=1.
> 
> It's not happening /all the time/ though. For example here is another
> dmesg showing a different timing on the same test box.

Sorry this is actually from another test box. But I did see similar
ones from the same test box.

> [  467.561516] [drm:intel_dp_mode_set], Enabling DP audio on pipe B
> [  467.567503] [drm:intel_write_eld], ELD on [CONNECTOR:26:DP-3], [ENCODER:27:TMDS-27]
> [  467.574207] [drm:ironlake_write_eld], ELD on pipe B
> [  467.579346] [drm:ironlake_write_eld], Audio directed to unknown port
> [  467.584724] [drm:ironlake_write_eld], ELD: DisplayPort detected
> [  467.586540] HDMI hot plug event: Codec=3 Pin=7 Presence_Detect=1 ELD_Valid=0
> [  467.599608] [drm:ironlake_write_eld],                    
> [  467.599922] HDMI status: Codec=3 Pin=7 Presence_Detect=1 ELD_Valid=0
> [  467.605834] ELD size 9                                           
> [  467.610434] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 7, cursor: 6
> [  467.612365] HDMI hot plug event: Codec=3 Pin=7 Presence_Detect=1 ELD_Valid=1
> [  467.620654] [drm:sandybridge_update_wm],                 
> [  467.620765] HDMI status: Codec=3 Pin=7 Presence_Detect=1 ELD_Valid=1
