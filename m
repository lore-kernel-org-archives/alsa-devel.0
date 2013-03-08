From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ASoC: add snd_soc_register_chip()
Date: Fri, 08 Mar 2013 13:53:19 -0700
Message-ID: <513A4FBF.5050802@wwwdotorg.org>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87ehfqaccl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F7F2625EE
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 21:53:24 +0100 (CET)
In-Reply-To: <87ehfqaccl.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/07/2013 06:50 PM, Kuninori Morimoto wrote:
> Current ASoC has register function for platform/codec/dai/card,
> but doesn't have for cpu.
> It often produces confusion and fault on ASoC.
> 
> As result of ASoC community discussion,
> we consider new struct snd_soc_chip for CPU/CODEC,
> and will switch over to use it.
> 
> This patch adds very basic struct snd_soc_chip,
> and register function for it.

Conceptually this seems fine.

I would have called this a "component" rather than a "chip", since:

a) That aligns better with the phrase "multi-component" for related ASoC
features.

b) This struct doesn't always represent a whole chip, but perhaps just
an IP block within a chip. Consider an SoC with 5 completely separate
I2S block and an SPDIF block. Those are probably each separate Linux
platform devices, and each would register as its own snd_soc_chip.

To be fully useful, we'd have to convert snd_soc_sodec to be a
snd_soc_chip too. Should CODEC be a "sub-class" of chip? Should we
instead rename snd_soc_codec to snd_soc_chip/component? How do we get
there from here?
