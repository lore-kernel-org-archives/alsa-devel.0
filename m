From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask
Date: Mon, 25 May 2015 09:49:45 +0100
Message-ID: <20150525084945.GC31187@opensource.wolfsonmicro.com>
References: <5560AB9D.1010807@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5560AB9D.1010807@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <daniel@zonque.org>, Wolfram Sang <wsa@the-dreams.de>, Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2015 at 06:32:29PM +0200, Maciej S. Szmigiero wrote:
> snd_soc_pcm_stream.formats is a bitmask of SNDRV_PCM_FMTBIT_*,
> not of SNDRV_PCM_FORMAT_* (which are sequential integers),
> however some of ASoC CODEC drivers use these values instead.
> 
> Found out by sparse on 0-day kernel tester.
> 
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> 

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
