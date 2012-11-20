From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-pcm: add dma support
Date: Tue, 20 Nov 2012 17:22:03 +0800
Message-ID: <50AB4BBB.7050308@atmel.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com> <1353400698-19384-2-git-send-email-voice.shen@atmel.com> <20121120085728.GX10560@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20121120085728.GX10560@opensource.wolfsonmicro.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 11/20/2012 16:57, Mark Brown wrote:
> On Tue, Nov 20, 2012 at 04:38:18PM +0800, Bo Shen wrote:
>> Change xfer_size name to apply to PDC and DMA aswell.
>> Specify overrun bit in interrupt mask.
>> Add dmaengine specific routines and replace PDC ones in
>> pcm_ops if appropriate.
>> Uses cyclic DMA API for queuing samples.
>
> If you're using dmaengine you really need a *very* good reason not to
> use the core dmaengine support...

You mean I should using the soc-dmaengine-pcm, am I right?

Best Regards
Bo Shen

