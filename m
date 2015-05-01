From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda: register selectively for
	SPT-LP
Date: Fri, 1 May 2015 10:01:43 +0530
Message-ID: <20150501043143.GQ3521@localhost>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <1430405556-19166-3-git-send-email-vinod.koul@intel.com>
 <20150430203355.GP22845@sirena.org.uk>
 <s5hk2wtjpsl.wl-tiwai@suse.de>
 <20150430212330.GQ22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1094726042F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 06:31:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150430212330.GQ22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 10:23:30PM +0100, Mark Brown wrote:
> On Thu, Apr 30, 2015 at 10:59:22PM +0200, Takashi Iwai wrote:
> 
> > Ideally, it'd be best if the system can do everything automatically,
> > e.g. loads the DSP driver at first, then falls back to the legacy
> > driver if no DSP is found.  But there seems no clean way to do this,
> > so far.  Thus the flag was introduced.
> 
> Eeew, that's horrible.  I guess another DMI quirk table is going to be
> needed...  
> 
> > Another way to skip the unwanted driver is just to return -ENODEV from
> > its probe callback when the given PCI is SKL and the flag is set.
> > Then the driver core ignores this and continues to the next possible
> > driver (i.e. the dsp one).  The same should be applied to hda-soc-skl
> > driver in vice versa.
> 
> Right, that was one of my suggestions.
okay that sounds okay to me. So the device probe checks the value of this
flag and then either goes ahead with probe or returns -ENODEV

Thanks
-- 
~Vinod
