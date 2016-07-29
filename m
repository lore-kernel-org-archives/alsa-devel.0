From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about struct snd_soc_dai() ::
	cpu_dai->codec
Date: Fri, 29 Jul 2016 09:30:19 +0900
Message-ID: <579AA39B.5030100@sakamocchi.jp>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost> <s5hh9bb7he6.wl-tiwai@suse.de>
 <20160727172125.GF9681@localhost> <20160727180456.GQ11806@sirena.org.uk>
 <s5h1t2f6jdm.wl-tiwai@suse.de> <20160727182233.GV11806@sirena.org.uk>
 <s5hpopy6dbi.wl-tiwai@suse.de> <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id EB826265312
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2016 02:30:22 +0200 (CEST)
In-Reply-To: <579A6C1B.2060904@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Lars,

On Jul 29 2016 05:33, Lars-Peter Clausen wrote:
> Hotplug is something that always pops up sooner or later. E.g. if someone
> puts a ASoC supported CODEC on a hot-pluggable device (maybe USB) we
> don't want to duplicate the code, but be able to reuse.

(A bit to sidetrack)

To me, it's unclear for devices on USB. When ALSA SoC part supports 
these devices, what is the scenario you assumed? In short, assuming we 
put codes to ALSA SoC part, what is the shape of the corresponding 
devices and links of pairs of endpoints? Additionally, in this case, 
what codes are able to be reused?


Regards

Takashi Sakamoto
