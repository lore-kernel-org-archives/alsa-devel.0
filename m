From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Tue, 4 Nov 2014 15:01:20 +0530
Message-ID: <20141104093120.GD1870@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com>
 <20141104082510.GC1870@intel.com>
 <545896DE.4030305@linux.intel.com> <1415092510.7168.9.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 14307260694
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:30:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1415092510.7168.9.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, lgirdwood@gmail.com, broonie@kernel.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 09:15:10AM +0000, Liam Girdwood wrote:
> On Tue, 2014-11-04 at 11:05 +0200, Jarkko Nikula wrote:
> > Hi
> > 
> > On 11/04/2014 10:25 AM, Vinod Koul wrote:
> > > On Tue, Nov 04, 2014 at 10:09:40AM +0200, Jarkko Nikula wrote:
> > >>
> > >> I think there is need to have some consolidation with current
> > >> byt-rt5640 and byt-max98090. Since existing drivers and this set are
> > >> using the same ACPI IDs "80860F28" for the ADSP and "10EC5640" codec
> > >> ACPIID for the machine driver probing these drivers won't work
> > >> together.
> > > Liam's suggestion was to remove the current driver when all the bits are
> > > upstream
> 
> I think we need to keep the original driver around a bit longer until
> the new driver is stable on rambi and other platforms the old driver
> supports atm. A that point we can depricate the original driver with a
> view to eventual removal.
Yes agreed, taht would help

-- 
~Vinod

> > Yeah, I'm not against it but we must avoid regressions and perhaps try 
> > to do seamless handover if possible. It's always more nice to find 
> > regression in a small than big patch when bisecting :-)
> > 
> 
> Liam
> 

-- 
