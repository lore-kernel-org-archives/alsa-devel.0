From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix Kconfig dependencies
Date: Thu, 02 Nov 2017 20:25:05 +0000
Message-ID: <1509654305.2547.212.camel@loki>
References: <20171102110737.2813128-1-arnd@arndb.de>
 <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
 <CAK8P3a3p4k=iU9Ym_h-Ahq5y93ga2yhDLO6S_6+g7dLN5aGbQQ@mail.gmail.com>
 <CAK8P3a3DhaUvQiyggVopT=DnRV2octdx8Qh8EeYmHd6fKaYHkg@mail.gmail.com>
 <20171102160406.GG3187@localhost>
 <CAK8P3a2jXrL2-eEZ0h_ay6CR45quzVjiqD5dWxubz29rVpxFYA@mail.gmail.com>
 <20171102163228.GH3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 42AB0266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 21:25:13 +0100 (CET)
In-Reply-To: <20171102163228.GH3187@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-11-02 at 22:02 +0530, Vinod Koul wrote:
> > > The BYT legacy drivers used DMAengine (dw) to load the firmware
> and hence the
> > > dependency. The Skylake and other drivers do not need that, so we
> should
> > > move this from toplevel to the BYT driver only.
> > 
> > Ok, so Haswell also shouldn't select SND_SOC_INTEL_SST_FIRMWARE,
> right?
> 
> I am not sure on that. Liam?

Haswell and Broadwell also use the DW DMAC for FW loading like the BYT
legacy driver.

Liam
