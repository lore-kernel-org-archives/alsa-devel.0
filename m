From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: SND_PXA2XX_SOC should depend on
	HAS_DMA
Date: Mon, 10 Jul 2017 08:31:07 +0200
Message-ID: <87ziccst04.fsf@belgarion.home>
References: <1499628632-15421-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A561266CE2
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 08:31:12 +0200 (CEST)
In-Reply-To: <1499628632-15421-1-git-send-email-geert@linux-m68k.org> (Geert
 Uytterhoeven's message of "Sun, 9 Jul 2017 21:30:32 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> If NO_DMA=y:
>
>     ERROR: "bad_dma_ops" [sound/soc/pxa/snd-soc-pxa2xx.ko] undefined!
>     ERROR: "bad_dma_ops" [sound/arm/snd-pxa2xx-lib.ko] undefined!
>     ERROR: "dma_common_mmap" [sound/arm/snd-pxa2xx-lib.ko] undefined!
>
> Add a dependency on HAS_DMA to fix this.
>
> Fixes: 73d7ee2e831f106c ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
