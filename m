From: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: sof-rt5682: add MCLK
 support for BYT platform
Date: Wed, 19 Jun 2019 10:54:32 +0000
Message-ID: <567A313375B6F043A9BE3A1D9B8C6E7F0B45F65E@SHSMSX101.ccr.corp.intel.com>
References: <20190618181539.9169-1-yung-chuan.liao@linux.intel.com>
 <20190619104831.GQ5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECA00F80C87
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 12:54:37 +0200 (CEST)
In-Reply-To: <20190619104831.GQ5316@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Bard liao <yung-chuan.liao@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, June 19, 2019 6:49 PM
> To: Bard liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; 
> liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; 
> Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH v2 1/2] ASoC: Intel: sof-rt5682: add MCLK support 
> for BYT platform
> 
> On Wed, Jun 19, 2019 at 02:15:38AM +0800, Bard liao wrote:
> > From: Xun Zhang <xun2.zhang@intel.com>
> >
> > The sof-rt5682 machine driver currently uses BCLK on BYT/Minnowboard 
> > platform. The MCLK signal is available since the Turbot revision, so 
> > enable MCLK on BYT/Minnowboard Turbot platform.
> >
> > Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
> > Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
> > ---
> 
> If you've got an ack or other tag for a patch you should carry that 
> forward to new postings unless there's some reason to remove it.

Sure. So
Patch 1 and 2

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
