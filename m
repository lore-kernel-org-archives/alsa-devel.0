From: "Zhi, Yong" <yong.zhi@intel.com>
Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info
 from coreboot nhlt
Date: Thu, 19 May 2016 16:17:41 +0000
Message-ID: <C193D76D23A22742993887E6D207B54D03535BCA@ORSMSX106.amr.corp.intel.com>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
 <20160519160136.GE8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D0E26528D
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2016 18:17:43 +0200 (CEST)
In-Reply-To: <20160519160136.GE8206@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Thursday, May 19, 2016 9:02 AM
To: Zhi, Yong <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; Kp, Jeeja <jeeja.kp@intel.com>; Patel, Vedang <vedang.patel@intel.com>; Fang, Yang A <yang.a.fang@intel.com>; M R, Sathya Prakash <sathya.prakash.m.r@intel.com>; Herbert, Marc <marc.herbert@intel.com>; Sripathi, Srinivas <srinivas.sripathi@intel.com>
Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info from coreboot nhlt

On Thu, May 19, 2016 at 08:58:59AM -0700, Yong Zhi wrote:
> skylake can be configured with either both 2 and 4 channel DMIC array, 
> or 2 channel DMIC array only, this patch provides an API to retrieve 
> the DMIC info from nhlt.

What's the difference between this and the similarly titled patch you sent yesterday?

[YZ], Hi, Mark, the only function change is at line 143 below, found another product that also needs to get DMIC config info yesterday.

        { "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
-                               NULL, NULL, NULL },
+                               NULL, NULL, &skl_dmic_data },
