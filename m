From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 16 Jun 2015 12:36:16 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B7F261A84
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 14:36:37 +0200 (CEST)
In-Reply-To: <20150616105429.GI18309@sirena.org.uk>
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
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, June 16, 2015 6:54 PM
> To: Jie, Yang
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> On Tue, Jun 16, 2015 at 12:49:37AM +0000, Jie, Yang wrote:
> 
> > Mark, as you may see in this patch(1/2), I have added this selection
> > to sound/ Soc/intel/Kconfig, we can find .compress_dai =1 in
> > sst-mfld-platform-pcm.c, the compressed is referenced in
> > sst-mfld-platform-pcm.c:sst_platform_dai,
> > here copy the related part from the patch:
> 
> OK, that should have been in the commit message.
 
OK, so let me add it to the commit message and resend?

~Keyon
