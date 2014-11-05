From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Wed, 5 Nov 2014 14:13:12 +0530
Message-ID: <20141105084312.GK1870@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com>
 <20141104082510.GC1870@intel.com>
 <545896DE.4030305@linux.intel.com>
 <20141104111513.GE3815@sirena.org.uk>
 <5459D68F.6030100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 01943261A0D
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 09:42:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5459D68F.6030100@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2014 at 09:49:35AM +0200, Jarkko Nikula wrote:
> On 11/04/2014 01:15 PM, Mark Brown wrote:
> >>Ok, so firmware appears to works on other than CR Baytrails too. Is it
> >>available in linux-firmware since if it's not when changing the platform
> >>drivers there will be obvious regressions to users?
> >Can we take a step back here: what are the firmwares and hardware
> >platforms we're talking about here?
> 
> Only Baytrail and its variants. Current upstreamed drivers use
> "intel/fw_sst_0f28.bin-48kHz_i2s_master" but that FW doesn't have as
> much features like compressed audio and is not compatible with the
> one Vinod's team is upstreaming.
> 
> Goal is to switch to new implementation since it covers more
> platforms but do switchover as seamlessly as possible for Baytrail.
> Problem at the moment for Baytrail that both current and new drivers
> probe using the same ACPIIDs and FW for new drivers is not yet in
> linux-firmware.
Shouldn't that be okay, as user wouldn't select the new driver. Default is n :)

Only when driver is stable and verfied by users should we enable this and
then start removing older driver

-- 
~Vinod
> 
> >
> >>Well, those audio routing differences require to have DMI quirks. E.g. T100
> >>has analogue internal mic, Dell Venue 8 Pro 5830 has digital mic connected
> >>to DMIC2 of the RT564x and some have it connected to DMIC1.
> >Are any of these things on sale at the minute?  Looks like T100 and the
> >Dell both are but I'm not sure if they're current or previous models.
> 
> T100 and Dell are. Third known audio routing difference is used in
> reference design so I guess that setup is found on some models too.
> Then there are byt-max98090 based Chromebooks that use current
> drivers and FW.
> 
> -- 
> Jarkko

-- 
