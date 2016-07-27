From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Wed, 27 Jul 2016 22:51:26 +0530
Message-ID: <20160727172125.GF9681@localhost>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost>
 <s5hh9bb7he6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hh9bb7he6.wl-tiwai@suse.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 27, 2016 at 07:57:05AM +0200, Takashi Iwai wrote:
> On Wed, 27 Jul 2016 05:21:11 +0200,
> Vinod Koul wrote:
> > 
> > On Tue, Jul 26, 2016 at 05:41:56AM +0000, Kuninori Morimoto wrote:
> > > 
> > > Hi ALSA SoC
> > > 
> > > My current headache is ALSA SoC's each modules (= Card/Codec/CPU/Platform)
> > > doesn't care about "unbind/rmmod".
> > > For example, if someone unbinded/rmmoded "Codec", Card or other modules
> > > doesn't know about it. Thus, user can continue to use this sound card,
> > > and kernel will be Oops.
> > 
> > Are you sure about this? Have you tried removing a module?
> > 
> > During card probe, asoc will hold a reference to the component. See the
> > calls to try_module_get(). This will prevent from unloading under normal
> > cases.
> 
> For unloading the module, yes, it should have been prevented by
> managing the module refcount.  However, unbinding can't be stopped by
> that.  It's a known problem.

Oh yes, unload is an issue. Are these any solutions to prevent this?

In core, should we de-register the card if one of the components exits. The
.remove should be called for the driver, thus triggering unregister?

-- 
~Vinod
