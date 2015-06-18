From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Thu, 18 Jun 2015 02:59:54 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554C827@SHSMSX101.ccr.corp.intel.com>
References: <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk> <s5hlhfj8wb3.wl-tiwai@suse.de>
 <s5hioan8w6v.wl-tiwai@suse.de> <20150616162507.GA28601@localhost>
 <s5h7fr38vax.wl-tiwai@suse.de> <20150617025448.GB28601@localhost>
 <20150617122340.GC3214@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B7CAC2660BD
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 05:00:00 +0200 (CEST)
In-Reply-To: <20150617122340.GC3214@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Mark Brown
> Sent: Wednesday, June 17, 2015 8:24 PM
> To: Koul, Vinod
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Zhang, Vivian; Babu, Ramesh;
> Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: soc-compress: add a config
> item for soc-compress
> 
> On Wed, Jun 17, 2015 at 08:24:48AM +0530, Vinod Koul wrote:
> > On Tue, Jun 16, 2015 at 06:36:22PM +0200, Takashi Iwai wrote:
> 
> Please remember to delete unneeded context from replies.
> 
> > > 	if (cpu_dai->driver->create)
> > > 		ret = cpu_dai->driver->create(rtd, num);
> 
> 
> > > and each driver passes soc_new_compress (or whatever) there.  This
> > > is flexible and can be extended if any new stuff has to be handled.
> > > Even PCM creation or dai widget links can be passed in that form,
> > > too.
> 
> > and the default would be snd_pcm_new so that *most* drivers dont need
> > to add this. Only Intel atom driver should add soc_new_compress() as
> > create ops, hence direct reference so no gaurds required
> 
> > Looks good to me then, Mark you okay with this approach?
> 
> I'm not sure this fully helps.  This will put the reference in the CPU driver
> which if there's sharing with non-compressed DAIs means that any machine
> driver using the platform needs to select the compressed audio code.  It also
> means that we're still in the situation whre if a machine
> *can* support compressed audio it *must* support compressed audio, it's
> not clear to me that people doing this sort of memory optimisation are
> always going to be doing it on hardware that doesn't have the capacity for
> compressed audio (or won't in the future).  But then I don't know exactly
> how much memory is being saved here...

It saves ~12KB memory usage on i386 platform on my side.
 
~Keyon
