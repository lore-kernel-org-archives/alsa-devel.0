From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Tue, 4 Nov 2014 15:03:27 +0530
Message-ID: <20141104093327.GF1870@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com>
 <20141104082510.GC1870@intel.com>
 <545896DE.4030305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2922606E9
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:32:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <545896DE.4030305@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, lgirdwood@gmail.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 11:05:34AM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 11/04/2014 10:25 AM, Vinod Koul wrote:
> >On Tue, Nov 04, 2014 at 10:09:40AM +0200, Jarkko Nikula wrote:
> >>
> >>I think there is need to have some consolidation with current
> >>byt-rt5640 and byt-max98090. Since existing drivers and this set are
> >>using the same ACPI IDs "80860F28" for the ADSP and "10EC5640" codec
> >>ACPIID for the machine driver probing these drivers won't work
> >>together.
> >Liam's suggestion was to remove the current driver when all the bits are
> >upstream
> 
> Yeah, I'm not against it but we must avoid regressions and perhaps
> try to do seamless handover if possible. It's always more nice to
> find regression in a small than big patch when bisecting :-)
> 
> >>One difference at the moment is that byt-rt5640 machines out there
> >>have differences in audio routings but those are not too difficult
> >>to handle in the same machine driver.
> >>
> >>Bigger question how to handle platform part? I.e. can these use the
> >>same drivers and ADSP firmware? If they can, is the firmware
> >>available for distributions to take?
> >The two firmware are *not* compatible and that is the big reason why we
> >can't reuse the parts available
> 
> Ok, so firmware appears to works on other than CR Baytrails too. Is
> it available in linux-firmware since if it's not when changing the
> platform drivers there will be obvious regressions to users?
I will send it this week, was focusing on getting the code done, whcih is
now mostly complete.

-- 
~Vinod

> 
> >>Optimally all machines out there would use the same drivers and get
> >>support for compressed audio but meanwhile we should not break
> >>existing machines.
> >Yes, I have tested this one on T100 and doesn't seem to break anything.
> >Please do test and revert if you find issues on any other available board (I
> >don't have any other board)
> >
> Well, those audio routing differences require to have DMI quirks.
> E.g. T100 has analogue internal mic, Dell Venue 8 Pro 5830 has
> digital mic connected to DMIC2 of the RT564x and some have it
> connected to DMIC1.
> 
> -- 
> Jarkko

-- 
