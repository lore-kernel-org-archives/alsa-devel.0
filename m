From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Dynamic PCM and Tegra AHUB
Date: Fri, 25 May 2012 18:23:48 -0600
Message-ID: <4FC02294.1000500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EA03C103FEA
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2012 02:23:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark, Liam,

Tegra30's AHUB is structured as follows:

> +-------------+   +-----+   +--------------+   +-----+   +------+
> | FIFO pair 0 |<->| CIF |<->| Cross-bar    |<->| CIF |<->| I2S0 |<-> External IO
> +-------------+   +-----+   | (the "AHUB") |   +-----+   +------+
>               . . .         |              |         . . .
> +-------------+   +-----+   |              |   +-----+   +------+
> | FIFO pair 3 |<->| CIF |<->|              |<->| CIF |<->| I2S4 |<-> External IO
> +-------------+   +-----+   |              |   +-----+   +------+
>                             |              |
>                             |              |   +-----+   +-------+
>                             |              |<->| CIF |<->| SPDIF |<-> External IO
>                             |              |   +-----+   +-------+
>                             |              |
>                             |              |   +-----+   +-------+
>                             |              |<->| CIF |<->| DAM   |
>                             |              |   +-----+   +-------+
>                             +--------------+

Notes on the diagram:

Each FIFO above is a separate TX and RX FIFO. I merged them in the
drawing for simplicity, but they operate completely independently;
different memory packing formats, data flow rates, ...

The CIF can convert the audio format, e.g. mono<->stereo conversion and
change the # of bits in the data in pretty arbitrary combinations. This
is true for all CIFs; those that join the AHUB core to either the DMA
FIFOs or the I2S/SPDIF/DAM controllers.

The AHUB core is a complete cross-bar; each output selects 1 of the n
inputs.

The I2S and SPDIF controllers take audio from the AHUB, format it to the
appropriate protocol, and send to external IO (or the other way around).
The I2S and SPDIF modules don't perform any additional data
rate/width/channel conversion; the CIF must do whatever conversions are
needed.

The DAMs take 2 input channels from the AHUB, optionally perform some
sample rate conversion and/or bit size conversion beyond what the CIF
does, mix them together, and send them back into the AHUB cross-bar.

Questions:

It seems like the whole point of ASoC dynamic PCM is to represent the
AHUB core, and at least some of the surrounding boxes above, as an ASoC
CODEC.

Initially, I would assume the AHUB CODEC's DAIs would be the DMA FIFOs
and the I2S* controllers themselves, i.e. include everything in the
above diagram.

If I do that, then the dai_links that the ASoC machine driver registers
for I2S->WM8903 would represent a codec DAI <-> codec DAI link rather
than a regular CPU DAI <-> codec DAI link. The difference here is the
lack of symmetry in struct snd_soc_dai_link: The CPU-side of each DAI
link only has a "cpu_dai_name" to identify it, whereas the codec side
has both a codec_name (or of node) /plus/ a DAI name. This is important
at least in the context of device tree, where to avoid hard-coding
specific device names into the dai_link structure's .codec_name field in
the machine driver, an of_node is looked up at run-time instead, and
then the codec_dai_name interpreted relative to that. Without a CPU-side
separation between name/node and dai_name, that's not possible. So, I
sent a patch for that in case this is the right approach.

An alternative to expanding struct snd_soc_dai_link might be to add an
API so the machine driver could ask the AHUB driver for the
globally-unique name of each DAI it exposes, and write that into
dai_link.cpu_dai_name. But if we have that API, we could use it for the
codec-side of the link to, and just have .codec_dai_name and remove the
.codec_name and .codec_of_node fields.

Alternatively, perhaps the DMA FIFOs should be registered as CPU DAIs
completely separately from the AHUB CODEC. The AHUB CIFs would then be
the DAIs registered by the AHUB CODEC. But then, the machine driver
would need to include dai_links for all the DMA FIFO <-> CIF
connections, which would end up duplicating that list of links into all
Tegra machine drives (or perhaps sharing it in common code).

Very curious for your thoughts...
