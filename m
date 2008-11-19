From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Wed, 19 Nov 2008 16:08:00 +0800
Message-ID: <20081119080800.GA522@localhost>
References: <1226542918.126598.6912@de> <20081119071135.GA17733@csy.ca>
	<20081119071757.GA32376@localhost> <20081119075545.GA19833@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id EE7A4245CD
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 09:08:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119075545.GA19833@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 11:55:45PM -0800, Shane W wrote:
> On Wed, Nov 19, 2008 at 03:17:57PM +0800, Wu Fengguang wrote:
> > On Tue, Nov 18, 2008 at 11:11:35PM -0800, Shane W wrote:
> > > On Thu, Nov 13, 2008 at 10:21:53AM +0800, Wu Fengguang wrote:
> > > > Create hda_eld.c for ELD routines and proc interface.
> > 
> > > Just testing this and your multichannel HDMI code over here
> > > but it doesn't seem to get ELD data for my setup.  Intel
> > > g45-id board with an Yamaha RX-v1800 receiver which is HDMI
> > > 1.3 capable.
> > 
> > Do you run the latest xorg intel driver?  Also dmesg should tell us
> > something if anything goes wrong with ELD retrieving/parsing.
> 
> Yes though Xorg wasn't running when I was doing the audio
> tests.  Pure console at that point but I fired up Xorg
> which is latest git as of today but still no ELD

Yeah sorry I missed one note. The xorg git tree only contains the
audio output enabling patches, but not yet ELD transferring patches.
(the ELD data flow is monitor => video driver => audio driver)
I called for the Xorg ELD enabling patches from Ma Ling just after
replying to your email. He should send the patches soon.

> population.  When Xorg starts, I get this in dmesg:
> [drm] Initialized i915 1.6.0 20080730 on minor 0
> [drm:i915_gem_object_bind_to_gtt] *ERROR* GTT full, but LRU
> list empty
> [drm:i915_gem_object_pin] *ERROR* Failure to bind:

> -12<6>HDMI intrinsic event: PD=1 ELDV=1

This last dmesg line is funny. The ELDV(i.e. ELD Valid) is true,
but the video driver obviously has no ELD data prepared for us.

Thanks,
Fengguang
