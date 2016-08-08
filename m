From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ASoC: simple-card: fix module load "unknown symbol" issue
Date: Mon, 8 Aug 2016 19:48:40 +0530
Message-ID: <57A894C0.3090206@ti.com>
References: <20160801233610.10479-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160801233610.10479-1-khilman@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 August 2016 05:06 AM, Kevin Hilman wrote:
> An ASoC driver using simple-card, when built as a module gets the
> following error at module load time:
> 
> [   23.571873] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)
> [   23.712726] simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)
> 
> fix this by including simple-card-utils.o symbols in the module build
> its symols are resolved correctly.
> 
> Tested on Davinci DA850-EVM using snd_soc_edma, snc_soc_davinci_mcasp,
> with all of ASoC built as modules.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Tested with audio on DaVinci DA850 EVM.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
