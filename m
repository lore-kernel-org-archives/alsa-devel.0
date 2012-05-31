From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Confusing about Playback/Capture, CODEC/CODEC links,
	and snd_soc_dapm_link_dai_widgets()
Date: Thu, 31 May 2012 16:49:26 -0600
Message-ID: <4FC7F576.30101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B767103B5F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 00:49:30 +0200 (CEST)
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

recall the Tegra AHUB structure:

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

(CIF is AHUB XBAR Client InterFace; basically the DAI or DAI link)

I have created a driver for the 4 FIFOs on the left, which exposes 4
(CPU) DAIs.

I have created a driver for the AHUB XBAR, which is an ASoC CODEC, and
has a DAI for each of the CIFs.

There's a CODEC/CODEC link between each FIFO DAI and the relevant AHUB
CIF DAI.

In order to connect the I2S devices to the AHUB XBAR, I had to make that
a CODEC too. This exposes two DAIs; the CIF DAI to connect to the AHUB,
and the DAP (Digital Audio Port) DAI to represent the I/O pins on the
Tegra package that are connected to the external codec.

I have an issue with the paths that snd_soc_dapm_link_dai_widgets() sets
up inside both the AHUB XBAR and the I2S. I'll use the I2S to explain
since it's internally much simpler.

The two DAIs in I2S are roughly:

> static const struct snd_soc_dai_driver tegra30_i2s_dais[] = {
>     {
> 	.playback = {
> 		.stream_name = "DAP Playback",
> 	},
> 	.capture = {
> 		.stream_name = "DAP Capture",
> 	},
>     },
>     {
> 	.playback = {
> 		.stream_name = "CIF Playback",
> 	},
> 	.capture = {
> 		.stream_name = "CIF Capture",
> 	},
>     },
> };

For the CIF-side DAI, I instantiated widgets for the AIFs:

> static const struct snd_soc_dapm_widget tegra30_i2s_widgets[] = {
> 	SND_SOC_DAPM_AIF_IN("CIF RX", "CIF Playback", 0, SND_SOC_NOPM, 0, 0),
> 	SND_SOC_DAPM_AIF_OUT("CIF TX", "CIF Capture", 0, SND_SOC_NOPM, 0, 0),

This works fine; snd_soc_dapm_link_dai_widgets() create a route from the
DAI widget "DAP Playback" that feeds into the AIF_IN widget "CIF RX".

"works fine" means that the ASoC debugfs files in
"asoc/$card/tegra30-i2s.1/dapm/CIF {Playback,RX}" show the expected
connections.

The DAPM routes inside the I2S are:

> static const struct snd_soc_dapm_route tegra30_i2s_routes[] = {
> 	{ "DAP TX", NULL, "CIF RX" },
> 	{ "CIF TX", NULL, "DAP RX" },
> };

This also works fine.

Now, I instantiated two AIF widgets to interface with the DAP-side DAI:

> 	SND_SOC_DAPM_AIF_IN("DAP RX", "DAP Capture", 0, SND_SOC_NOPM, 0, 0),
> 	SND_SOC_DAPM_AIF_OUT("DAP TX", "DAP Playback", 0, SND_SOC_NOPM, 0, 0),

However, this causes snd_soc_dapm_link_dai_widgets() to set up some
unexpected paths; "DAP Playback" ends up feeding *into* "DAP TX", rather
than feeding from/out of it...

> # cat CIF\ Playback 
> CIF Playback: Off  in 0 out 0
>  stream CIF Playback inactive
>  out "static" "CIF RX"
>  out "static" "CIF RX"
> # cat CIF\ RX
> CIF RX: Off  in 0 out 0
>  stream CIF Playback inactive
>  in  "static" "CIF Playback"
>  in  "static" "CIF Playback"
>  out "static" "DAP TX"
> # cat DAP\ TX
> DAP TX: Off  in 0 out 0
>  stream DAP Playback inactive
>  in  "static" "DAP Playback"      <<<<<<<<<<
>  in  "static" "DAP Playback"      <<<<<<<<<<
>  in  "static" "CIF RX"
> # cat DAP\ Playback 
> DAP Playback: Off  in 0 out 0
>  stream DAP Playback inactive
>  out "static" "DAP TX"
>  out "static" "DAP TX"

Now, I can fake this out by swapping the stream names on the DAP-side
AIF widgets:

> 	SND_SOC_DAPM_AIF_IN("DAP RX", "DAP Playback", 0, SND_SOC_NOPM, 0, 0),
> 	SND_SOC_DAPM_AIF_OUT("DAP TX", "DAP Capture", 0, SND_SOC_NOPM, 0, 0),

Which yields the expected paths in debugfs:

> # cat CIF\ Playback 
> CIF Playback: Off  in 0 out 0
>  stream CIF Playback inactive
>  out "static" "CIF RX"
>  out "static" "CIF RX"
> # cat CIF\ RX
> CIF RX: Off  in 0 out 0
>  stream CIF Playback inactive
>  in  "static" "CIF Playback"
>  in  "static" "CIF Playback"
>  out "static" "DAP TX"
> # cat DAP\ TX
> DAP TX: Off  in 0 out 0
>  stream DAP Capture inactive
>  in  "static" "CIF RX"
>  out "static" "DAP Capture"
>  out "static" "DAP Capture"
> # cat DAP\ Capture 
> DAP Capture: Off  in 0 out 0
>  stream DAP Capture inactive
>  in  "static" "DAP TX"
>  in  "static" "DAP TX"

But I'm not sure if that's quite correct. In the DAI definitions, is the
.playback sub-structure always meant to represent:

1) Playback from the CPU's perspective, in which case the first set of
DAP AIF definitions above would be correct

or:

2) Is it more that Playback==RX_into_codec, Capture==TX_from_codec? This
appears to be supported by the fact that the paths get set up correctly
with the second set of AIF definitions above.

But if (2) is correct, I wonder why soc_dapm_stream_event()'s first if
statement appears to consider the playback_widget of both sides of the
DAI to be coupled; wouldn't one side's playback widget be coupled to the
other side's capture widget?

As an aside, I'm not sure if it's conceptually correct to talk about
playback or capture any more (beyond the initial CPU DAI) with arbitrary
CODEC/CODEC links, since who knows what kind of routing/CPU->CPU
loopbacks/external CODEC->CODEC loopbacks/... might exist in the CODECs?

Either way though, something is still not working correctly even when
the expected paths show up in debugfs. When I start playback on a PCM
exposed by the DMA FIFO driver, I see the relevant AHUB XBAR's stream
turned on, and a route exists to the relevant AIF_IN widget, but that
widget is not considered to have any outward connections by
is_connected_output_ep(), which I think is what is causing it and none
of the rest of the path to turn on:

(from asoc/$card/asoc/tegra30-ahub-xbar/dapm)

> # cat APBIF0\ Playback 
> APBIF0 Playback: On  in 1 out 1
>  stream APBIF0 Playback active
>  out "static" "APBIF0 RX"
>  out "static" "APBIF0 RX"
> # cat APBIF0\ RX
> APBIF0 RX: Off  in 2 out 0       <<<<< last value shouldn't be 0?
>  stream APBIF0 Playback inactive <<<<< still inactive?
>  in  "static" "APBIF0 Playback"
>  in  "static" "APBIF0 Playback"
>  out "APBIF0 RX" "I2S0 TX Mux"

even though when I look at all the debugfs files, all the expected paths
are there, at least within the AHUB XBAR and I2S drivers, and the
external DAI links in the machine driver all probed as expected and
bound all the components together.

Probably related, the I2S and WM8903 (DAI) drivers aren't being called
by the ASoC core to initialize themselves for playback either; pretty
much all that happens is that DMA is started. Is the machine driver
responsible for this?

At this point, I'm not sure whether I have a gross mis-understanding of
how this is supposed to work, or whether there are simply bits missing
from the DAPM code to fully support CODEC/CODEC links, rather than
CPU/CODEC links.

Probably slightly related to all of this, but is the following code correct:

> int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
> 	struct snd_soc_dapm_widget_list **list)
...
> 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> 		paths = is_connected_output_ep(dai->playback_widget, list);
> 	else
> 		paths = is_connected_input_ep(dai->playback_widget, list);

I would have expected this to use capture_widget on the final line, but
I haven't thought about this in detail, just noticed the lack of
symmetry by very brief inspection.

Thanks for any help. Sorry for the long email.
