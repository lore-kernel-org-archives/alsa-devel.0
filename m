From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Wed, 17 Jun 2015 08:24:48 +0530
Message-ID: <20150617025448.GB28601@localhost>
References: <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk>
 <s5hlhfj8wb3.wl-tiwai@suse.de> <s5hioan8w6v.wl-tiwai@suse.de>
 <20150616162507.GA28601@localhost> <s5h7fr38vax.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 700A2265A2D
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 04:53:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7fr38vax.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 16, 2015 at 06:36:22PM +0200, Takashi Iwai wrote:
> At Tue, 16 Jun 2015 21:55:07 +0530,
> Vinod Koul wrote:
> > 
> > On Tue, Jun 16, 2015 at 06:17:12PM +0200, Takashi Iwai wrote:
> > > At Tue, 16 Jun 2015 18:14:40 +0200,
> > > Takashi Iwai wrote:
> > > > 
> > > > At Tue, 16 Jun 2015 17:06:07 +0100,
> > > > Mark Brown wrote:
> > > > > 
> > > > > On Tue, Jun 16, 2015 at 12:36:16PM +0000, Jie, Yang wrote:
> > > > > 
> > > > > > > OK, that should have been in the commit message.
> > > > > 
> > > > > > OK, so let me add it to the commit message and resend?
> > > > > 
> > > > > Well, there's still the stubs to consider.  Should we really be
> > > > > returning an error or should we silently ignore the error and hide the
> > > > > DAI if the user deconfigured compressed audio?  Or rearrange things so
> > > > > we don't need stubs?  Given that the machine driver has to select
> > > > > compressed support it's not something that should ever really hit the
> > > > > stubs, it's not truly a runtime thing...
> > > > 
> > > > Yes, I guess that leaving without dummy function will give unresolved
> > > > symbol errors at module link time, so the user can catch before
> > > > actually running it.  Of course, this should be checked actually.
> > > 
> > > Oh, scratch this.  It won't work well in the current code.
> > > Possibly with weak linking, but...
> > Right as the soc_new_compress() is called from soc-core for compressed dai
> > links. Since ASoC drivers don't use any of compress APIs directly, it would
> > be difficult to add a compile time failure so we are stuck with silent
> > runtime failures :(
> 
> One feasible option would be to make the driver's dai creation a
> function pointer to the generic constructor.  That is,
> soc_probe_link_dais() will run like:
> 
> 	if (cpu_dai->driver->create)
> 		ret = cpu_dai->driver->create(rtd, num);
> 
> and each driver passes soc_new_compress (or whatever) there.  This is
> flexible and can be extended if any new stuff has to be handled.
> Even PCM creation or dai widget links can be passed in that form,
> too.
and the default would be snd_pcm_new so that *most* drivers dont need to add
this. Only Intel atom driver should add soc_new_compress() as create ops,
hence direct reference so no gaurds required

Looks good to me then, Mark you okay with this approach?

-- 
~Vinod
