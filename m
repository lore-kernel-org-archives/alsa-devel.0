From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Wed, 27 Jul 2016 08:51:11 +0530
Message-ID: <20160727032111.GY9681@localhost>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2016 at 05:41:56AM +0000, Kuninori Morimoto wrote:
> 
> Hi ALSA SoC
> 
> My current headache is ALSA SoC's each modules (= Card/Codec/CPU/Platform)
> doesn't care about "unbind/rmmod".
> For example, if someone unbinded/rmmoded "Codec", Card or other modules
> doesn't know about it. Thus, user can continue to use this sound card,
> and kernel will be Oops.

Are you sure about this? Have you tried removing a module?

During card probe, asoc will hold a reference to the component. See the
calls to try_module_get(). This will prevent from unloading under normal
cases.

-- 
~Vinod
