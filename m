From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Tue, 4 Nov 2014 15:53:11 +0530
Message-ID: <20141104102310.GG1870@intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
 <20141029103053.GX18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B704DC6@SHSMSX101.ccr.corp.intel.com>
 <20141031125415.GA18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B705DA4@SHSMSX101.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B7069B1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 458532604CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:22:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B7069B1@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 03:15:15PM +0530, Lin, Mengdong wrote:
> Hi Mark,
> 
> I've posted the v3 patch. Would you please have a review?
> 
> There are other Intel machine drivers submitted at the same time, hope they
> can be integrated smoothly to avoid conflict on Kconfig and Makefile.

Mengdong, I am about to send v3 series of my driver changes. Should I add
this driver in my series to avoid merge conflict in Kconfig?

-- 
~Vinod

> 
> Thanks
> Mengdong
> 
> > -----Original Message-----
> > From: alsa-devel-bounces@alsa-project.org
> > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Lin, Mengdong
> > Sent: Monday, November 03, 2014 8:11 PM
> > To: Mark Brown
> > Cc: Koul, Vinod; alsa-devel@alsa-project.org; Prusty, Subhransu S; Girdwood,
> > Liam R
> > Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
> > machine driver cht_bsw_rt5672
> > 
> > > -----Original Message-----
> > > From: Mark Brown [mailto:broonie@kernel.org]
> > > Sent: Friday, October 31, 2014 8:54 PM
> > 
> > > On Fri, Oct 31, 2014 at 12:48:26PM +0000, Lin, Mengdong wrote:
> > >
> > > > Now we're working with Realtek to enable runtime PM on RT5672 codec
> > > driver.
> > > > With help of ACPI,
> > > > - the codec will be in suspended to D3 when idle , switch to its
> > > > internal clock,  and BIOS will turn off the platform clock output
> > > > (MCLK) to
> > > save power.
> > > > - And when the codec resumes to D0, BIOS will turn on the clock at
> > > > first. And  hw_params will make the codec use PLL and lock to MCLK again.
> > >
> > > > Thus the machine driver does not need to explicitly turn on/off the
> > > > platform codec by itself.
> > >
> > > If the machine driver has asked for the PLL to be on I'd expect the
> > > CODEC driver to be respecting that...
> > 
> > The codec driver rt5670 defines a supply widget to control the power of PLL.
> > So the PLL will be power on when there is active audio streaming and power off
> > when Idle.
> > The machine driver need not explicitly turn on/off the PLL, but only need to
> > select PLL source to MCLK in hw_params and configure the in/out frequency.
> > 
> > And we've verified to enable runtime PM on the codec driver and trigger ACPI
> > method to dynamically control the MCLK output from SOC to the codec:
> > - When codec is active (D0), BIOS will turn on MCLK at first
> > - When codec is suspended on idle (D3), codec will switch to its internal clock,
> > and BIOS will turn off MCLK
> > 
> > I'll post V3 machine driver based on your comments on v2.
> > After an internal sync, this machine driver will be moved to sound/soc/intel
> > directory, with other existing Intel machines.
> > 
> > Thanks
> > Mengdong
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
