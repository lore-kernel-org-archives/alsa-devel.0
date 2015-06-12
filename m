From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Fri, 12 Jun 2015 13:37:30 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554A295@SHSMSX101.ccr.corp.intel.com>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <1434110356-23516-2-git-send-email-yang.jie@intel.com>
 <20150612121524.GT1921@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7473B2604A9
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:37:36 +0200 (CEST)
In-Reply-To: <20150612121524.GT1921@sirena.org.uk>
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
> Sent: Friday, June 12, 2015 8:15 PM
> To: Jie, Yang
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress to a
> module
> 
> On Fri, Jun 12, 2015 at 07:59:16PM +0800, Jie Yang wrote:
> 
> > +static int __init soc_compress_init(void) {
> > +       return 0;
> > +}
> > +module_init(soc_compress_init);
> > +
> > +static void __exit soc_compress_exit(void) { }
> > +module_exit(soc_compress_exit);
> 
> These are completely empty, why are they being added?
 
I imitated that from sound/core/compress_offload.c, let me remove
them.

~Keyon
