From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Wed, 17 Jun 2015 11:10:50 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554C57E@SHSMSX101.ccr.corp.intel.com>
References: <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk>	<s5hlhfj8wb3.wl-tiwai@suse.de>
 <s5hioan8w6v.wl-tiwai@suse.de>	<20150616162507.GA28601@localhost>
 <s5h7fr38vax.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ED5CF265CA8
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 13:10:55 +0200 (CEST)
In-Reply-To: <s5h7fr38vax.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Zhang, Vivian" <vivian.zhang@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, June 17, 2015 12:36 AM
> To: Koul, Vinod
> Cc: Mark Brown; Jie, Yang; alsa-devel@alsa-project.org; Girdwood, Liam R;
> ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> At Tue, 16 Jun 2015 21:55:07 +0530,
> Vinod Koul wrote:
> >
> > On Tue, Jun 16, 2015 at 06:17:12PM +0200, Takashi Iwai wrote:
> > > At Tue, 16 Jun 2015 18:14:40 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > At Tue, 16 Jun 2015 17:06:07 +0100, Mark Brown wrote:
> > > > >
> > > > > On Tue, Jun 16, 2015 at 12:36:16PM +0000, Jie, Yang wrote:
> > > > >
> > > > > > > OK, that should have been in the commit message.
> > > > >
> > > > > > OK, so let me add it to the commit message and resend?
> > > > >
> > > > > Well, there's still the stubs to consider.  Should we really be
> > > > > returning an error or should we silently ignore the error and
> > > > > hide the DAI if the user deconfigured compressed audio?  Or
> > > > > rearrange things so we don't need stubs?  Given that the machine
> > > > > driver has to select compressed support it's not something that
> > > > > should ever really hit the stubs, it's not truly a runtime thing...
> > > >
> > > > Yes, I guess that leaving without dummy function will give
> > > > unresolved symbol errors at module link time, so the user can
> > > > catch before actually running it.  Of course, this should be checked
> actually.
> > >
> > > Oh, scratch this.  It won't work well in the current code.
> > > Possibly with weak linking, but...
> > Right as the soc_new_compress() is called from soc-core for compressed
> > dai links. Since ASoC drivers don't use any of compress APIs directly,
> > it would be difficult to add a compile time failure so we are stuck
> > with silent runtime failures :(
> 
> One feasible option would be to make the driver's dai creation a function
> pointer to the generic constructor.  That is,
> soc_probe_link_dais() will run like:
> 
> 	if (cpu_dai->driver->create)
> 		ret = cpu_dai->driver->create(rtd, num);
> 
> and each driver passes soc_new_compress (or whatever) there.  This is
> flexible and can be extended if any new stuff has to be handled.
> Even PCM creation or dai widget links can be passed in that form, too.
 
Then we may need this in driver code:

static struct snd_soc_dai_driver sst_platform_dai[] = {
...,
{
	.name = "compress-cpu-dai",
	.create = soc_new_compress, //.compress_dai = 1,
//	.create = NULL, //.compress_dai = 0,
	.ops = &sst_compr_dai_ops,
	.playback = {
		.stream_name = "Compress Playback",
		.channels_min = SST_STEREO,
		.channels_max = SST_STEREO,
		.rates = SNDRV_PCM_RATE_48000,
		.formats = SNDRV_PCM_FMTBIT_S16_LE,
	},
},
}

With  this implementation, for driver which needed compress,
if we forget to add 'select SND_SOC_COMPRESS' in Kconfig of the
driver, compiler will check and report error(no NULL inline function
defined).

Sounds this feasible for me, any extra comment for it?

~Keyon

> 
> 
> Takashi
