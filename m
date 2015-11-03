From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Tue, 3 Nov 2015 23:28:01 +0530
Message-ID: <20151103175801.GI12910@localhost>
References: <20151102153229.GP21326@localhost>
 <20151103112458.GO20228@sirena.org.uk>
 <5638A88E.5050908@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 69C02262631
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 18:54:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5638A88E.5050908@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Keyon <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2015 at 08:29:02PM +0800, Keyon wrote:
> >I'm having a hard time seeing the difference between this and what's
> >going on in sst-acpi.  They seem to be doing the same thing in slightly
> >different ways, they both match tables of CODEC IDs to machine driver
> >names with the distinction being that this doesn't provide a firmware
> >filename whereas sst-acpi does but the mechanics of mapping a CODEC to a
> >machine driver seem otherwise the same.
> 
> agree that it may be better if we can reuse(or merge with) sst
> driver (intel/common/sst-acpi.c) for SKL.

all drivers use different sst_machine structure... and data required is not
same

-- 
~Vinod
