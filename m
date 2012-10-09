From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Tue, 9 Oct 2012 18:08:59 +0900
Message-ID: <20121009090857.GD8237@opensource.wolfsonmicro.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
 <20121009065836.GT8237@opensource.wolfsonmicro.com>
 <5073E93F.7090507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EEB4126262D
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 11:09:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5073E93F.7090507@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 09, 2012 at 11:07:11AM +0200, P=E9ter Ujfalusi wrote:

> When we build sound as modules for OMAP which has been converted to dmaen=
gine:

> ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko]
> undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undef=
ined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefine=
d!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefin=
ed!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] unde=
fined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undef=
ined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

What makes you believe that this is due to the code not being part of
the core module?
