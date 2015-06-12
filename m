From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Fri, 12 Jun 2015 13:34:08 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554A27C@SHSMSX101.ccr.corp.intel.com>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <1434110356-23516-2-git-send-email-yang.jie@intel.com>
 <20150612121549.GU1921@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 605E026696B
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:34:22 +0200 (CEST)
In-Reply-To: <20150612121549.GU1921@sirena.org.uk>
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
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 12, 2015 8:16 PM
> To: Jie, Yang
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress to a
> module
> 
> On Fri, Jun 12, 2015 at 07:59:16PM +0800, Jie Yang wrote:
> 
> > +MODULE_ALIAS("platform:soc-compress");
> 
> Oh, and this is incorrect - there is no platform device driver in this file.
 
OK, will remove this line.
