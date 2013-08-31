From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sat, 31 Aug 2013 17:28:26 +0200
Message-ID: <52220B9A.9000007@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B856F261AE5
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 17:26:53 +0200 (CEST)
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/31/2013 02:34 PM, Russell King - ARM Linux wrote:
[...]
> The same conditions apply as per my previous posting - the DAI link
> needs to be setup and the associated DAPM routes to tell the CPU DAI
> which outputs are in use, like this:
> 
> DAI link:
>                 .name = "S/PDIF1",
>                 .stream_name = "IEC958 Playback",
>                 .platform_name = "mvebu-audio.1",
>                 .cpu_dai_name = "mvebu-audio.1",
>                 .codec_dai_name = "dit-hifi",
>                 .codec_name = "spdif-dit",
> 
> static const struct snd_soc_dapm_route routes[] = {
>         { "Playback", NULL, "spdifdo" },
> };

This is still not exactly the right way to implement this though. Add a
second DAI to your CPU driver, like this:

static struct snd_soc_dai_driver kirkwood_mvebu_dais[] = {
	{
		.id = 0,
		.probe = kirkwood_i2s_probe,
    		.playback = {
			.stream_name = "I2S Capture",
			...
		},
		.capture = {
			.stream_name = "I2S Playback",
			...
		},
		.ops = &kirkwood_i2s_dai_ops,
	}, {
		.id = 1,
		.probe = kirkwood_i2s_probe,
    		.playback = {
			.stream_name = "SPDIF Capture",
			...
		},
		.capture = {
			.stream_name = "SPDIF Playback",
			...
		},
		.ops = &kirkwood_i2s_dai_ops,
	},
};

Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
widgets to the I2S streams. In your machine driver setup the link config to
use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
framework will then create the necessary routes all by itself. Of course
this won't work on a platform where both the SPDIF and I2S controller are
used at the same time, but neither does your current solution.

- Lars
