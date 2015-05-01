From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ALSA: hda: add hdac_adsp_enable module
 flag
Date: Fri, 1 May 2015 10:09:40 +0530
Message-ID: <20150501043940.GR3521@localhost>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <5542520B.8080606@linux.intel.com>
 <20150430192726.GD22845@sirena.org.uk>
 <s5hmw1pjqhm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1453F26042F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 06:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmw1pjqhm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 10:44:21PM +0200, Takashi Iwai wrote:
> At Thu, 30 Apr 2015 20:27:26 +0100,
> Mark Brown wrote:
> > 
> > On Thu, Apr 30, 2015 at 11:02:19AM -0500, Pierre-Louis Bossart wrote:
> > > On 4/30/15 9:52 AM, Vinod Koul wrote:
> > 
> > > >Some Intel HDA controllers sport a DSP. These systems can also be enabled
> > > >with ASoC HDA driver as well. So add a flag in hda-core to enable/disable
> > > >aDSP This flag for now is false, and should be true once the ASoC based
> > > >systems mature.  The integrators/OS vendors can configure this flag based on
> > > >system preference.
> > 
> > > This choice is contingent on the BIOS options, you can't enable the DSP if
> > > the BIOS said no DSP...
That is right, but by default DSP in On. Btw this is not like older HSW
platform where HDA and DSP and muxed and BIOS plays key role.
> > 
> > Presumably this flag should be coming from the BIOS by default and this
> > providing a disable only setting for test/development?
> 
> It's hard to know exactly how many models will be with DSP and how
> many without...  The problem we're dealing with is that we'll have two
> individual drivers supporting the very same PCI ID.  And, there is no
> good mechanism to prioritize the driver load on Linux, so far.
> 
> So, this is the consequence after lengthy discussions: it's fairly
> simple but effective enough.  Distros may build both drivers, but
> which driver to use can be decided by this option.  The default value
> of this switch should be set via a Kconfig, but it can be overridden
> dynamically via either a static module option or boot option.
Okay i will respin the series based on latest discussion

Thanks
-- 
~Vinod
