Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 39629265375
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 06:21:41 +0200 (CEST)
Date: Mon, 18 Aug 2014 09:29:55 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140818035951.GA13863@vinod.koul@linux.intel.com>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140729195043.GM17528@sirena.org.uk>
 <20140812060601.GA1115@vinod.koul@linux.intel.com>
 <20140812214822.GB17528@sirena.org.uk>
 <20140817142023.GA12530@vinod.koul@linux.intel.com>
 <20140817145750.GP14537@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140817145750.GP14537@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Add merrifield machine driver
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Sun, Aug 17, 2014 at 09:57:50AM -0500, Mark Brown wrote:
> On Sun, Aug 17, 2014 at 07:50:28PM +0530, Subhransu S. Prusty wrote:
> > On Tue, Aug 12, 2014 at 10:48:22PM +0100, Mark Brown wrote:
> 
> > > Look at what wm8994_vmid_mode() does...
> 
> > If I understand correctly need to move this enabling/disabling of VMID
> > to wm8994_vmid_mode(). 
> 
> No, it's exactly what wm8994_vmid_mode() is there to do already -
> putting the device into WM8994_VMID_FORCE forces VMID on.

wm8994_vmid_mode() looks to be storing the mode in context and but it's
not applied. It's applied on VMID event.

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
