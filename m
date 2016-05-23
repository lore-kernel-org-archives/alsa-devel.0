From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info
 from coreboot nhlt
Date: Mon, 23 May 2016 11:17:33 +0530
Message-ID: <20160523054733.GI2735@localhost>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
 <20160519160136.GE8206@sirena.org.uk>
 <C193D76D23A22742993887E6D207B54D03535BCA@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A28432604A9
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 07:41:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <C193D76D23A22742993887E6D207B54D03535BCA@ORSMSX106.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Zhi, Yong" <yong.zhi@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Fang,
 Yang A" <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 19, 2016 at 09:47:41PM +0530, Zhi, Yong wrote:
> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org] 
> Sent: Thursday, May 19, 2016 9:02 AM
> To: Zhi, Yong <yong.zhi@intel.com>
> Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; Kp, Jeeja <jeeja.kp@intel.com>; Patel, Vedang <vedang.patel@intel.com>; Fang, Yang A <yang.a.fang@intel.com>; M R, Sathya Prakash <sathya.prakash.m.r@intel.com>; Herbert, Marc <marc.herbert@intel.com>; Sripathi, Srinivas <srinivas.sripathi@intel.com>
> Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info from coreboot nhlt
> 
> On Thu, May 19, 2016 at 08:58:59AM -0700, Yong Zhi wrote:
> > skylake can be configured with either both 2 and 4 channel DMIC array, 
> > or 2 channel DMIC array only, this patch provides an API to retrieve 
> > the DMIC info from nhlt.
> 
> What's the difference between this and the similarly titled patch you sent yesterday?
> 
> [YZ], Hi, Mark, the only function change is at line 143 below, found another product that also needs to get DMIC config info yesterday.

Yong,

You please wrap you replies..

The patches are doing two different things, so they should have different
titles mentioning the work the patch is doing.

Also you should consider posting them as a series.

Please update this and post the updated v2.

Thanks
-- 
~Vinod
