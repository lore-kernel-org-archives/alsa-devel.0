From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: codec: SPDIF only works with Tx/Rx seperate
 codec drivers?
Date: Fri, 12 Jul 2013 16:26:17 +0200
Message-ID: <51E01209.9020904@metafoo.de>
References: <20130712083030.GA28555@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-071.synserver.de (smtp-out-071.synserver.de
 [212.40.185.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 25549265A16
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 16:25:41 +0200 (CEST)
In-Reply-To: <20130712083030.GA28555@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/12/2013 10:30 AM, Nicolin Chen wrote:
> Hi Mark,
> 
> I've a little question about SPDIF codec drivers.
> 
> I found there're spdif_receiver.c and spdif_transmitter.c, two files,
> in sound/soc/codecs directory. So it looks like SPDIF module would work
> separately as one IN device and one OUT device, for example:
> dts/spear1340.dtsi:		spdif-in@d0100000 {
> dts/spear1340.dtsi:			compatible = "st,spdif-in";
> dts/spear1340.dtsi:		spdif-out@d0000000 {
> dts/spear1340.dtsi:			compatible = "st,spdif-out";
> 
> But the question is what if a SPDIF module have both Tx and Rx function
> in one simple CPU DAI. Is that okay to add a new codec driver for this
> situation?
> 
> Actually I'm gonna prepare some patches to add Freescale SPDIF drivers.
> But this needs to create a brand new dummy SPDIF codec driver, which's
> some kinda same as spdif_receiver/transmitter.c but quite different
> in the supports of SAMPLE_RATE/FORMAT and IN/OUT-in-one integration.
> 
> So I just want to make sure if this'll be okay.

The current drivers should work fine with this. You can create a card with
two DAI links

static struct snd_soc_dai_link dai_links[] = {
	{
		.name = "S/PDIF TX",
		.stream_name = "S/PDIF PCM Playback",
		.platform_name = "your-platform",
		.cpu_dai_name = "your-cpu-dai",
		.codec_dai_name = "dit-hifi",
		.codec_name = "spdif-dit",
	}, {
		.name = "S/PDIF RX",
		.stream_name = "S/PDIF PCM Playback",
		.platform_name = "your-platform",
		.cpu_dai_name = "your-cpu-dai",
		.codec_dai_name = "dir-hifi",
		.codec_name = "spdif-dir",
	},
};
