From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 16 Jun 2015 00:49:37 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 48793260705
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 02:50:03 +0200 (CEST)
In-Reply-To: <20150615150556.GQ18309@sirena.org.uk>
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
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, June 15, 2015 11:06 PM
> To: Jie, Yang
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> On Mon, Jun 15, 2015 at 02:46:23PM +0000, Jie, Yang wrote:
> 
> > > > Here I used -EPERM to return and tell caller that compress
> > > > operation is not permitted, does it make sense, Takashi?
> 
> > > The question is whether a runtime error is the best option.  A
> > > runtime error won't be caught by build tests but only when actually
> running by a user.
> 
> > Unfortunately, here cpu_dai->driver->compress_dai is a runtime value,
> > which means we need compress API when it is true. Seems it is not easy
> > to decide it at compile stage?
> 
> The machine driver (which is presumably the thing that should be doing the
> select here, it's not user visible) really ought to know if the DAI links it is
> creating are for compressed audio.  This is why I'm still surprised there's no
> driver updates as part of this patch.  If the Intel drivers referencing
> compressed don't actually implement it then I'd expect to see patches
> cleaning up the references to compressed audio.
 
Mark, as you may see in this patch(1/2), I have added this selection to sound/
Soc/intel/Kconfig, we can find .compress_dai =1 in sst-mfld-platform-pcm.c,
the compressed is referenced in sst-mfld-platform-pcm.c:sst_platform_dai, 
here copy the related part from the patch:

b/sound/soc/intel/Kconfig index 791953f..e559174 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -12,6 +12,7 @@ config SND_MFLD_MACHINE
 
 config SND_SST_MFLD_PLATFORM
 	tristate
+	select SND_SOC_COMPRESS
 
 config SND_SST_IPC
 	tristate

~Keyon
