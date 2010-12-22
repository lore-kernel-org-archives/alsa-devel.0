From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 22 Dec 2010 10:30:15 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D876224517
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 19:31:18 +0100 (CET)
In-Reply-To: <20101217220029.GD25609@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Dec 17, 2010 at 02:41:26PM -0700, Stephen Warren wrote:
> 
> > /*
> >  * Terminology:
> >  * DAS: Digital audio switch (HW module controlled by this driver)
> >  * DAP: Digital audio port (port/pins on Tegra device)
> >  * DAC: Digital audio controller (e.g. I2S or AC97 controller elsewhere)
> >  * 
> >  * The Tegra DAS is a mux/cross-bar which can connect each DAP to a specific
> >  * DAC, or another DAP. When DAPs are connected, one must be the master and
> >  * one the slave. Each DAC allows selection of a specific DAP for input, to
> >  * cater for the case where N DAPs are connected to 1 DAC for broadcast
> >  * output.
> >  *
> >  * This driver is dumb; no attempt is made to ensure that a valid routing
> >  * configuration is programmed.
> >  */ 
> 
> Reading this it's essentially just exporting point to point switches
> within the DAS block.  This really feels like it ought to be represented
> as a CODEC driver to give runtime flexibility to userspace to control
> the mux - it looks like the AP part of the system streams data into this
> block which then has very flexible switching on to the externally
> connected audio devices.

Hmm. I don't see any examples of anything like Tegra's DAS in the existing
ASoC code-base. So, I'm slightly unsure how to recast the DAS driver as
a codec. In particular, in the machine driver, would I do something like:

static struct snd_soc_dai_link harmony_i2s_das_link = {
	.name = "WM8903",
	.stream_name = "WM8903 PCM",
	.cpu_dai_name = "tegra-i2s-dai.0",
	.platform_name = "tegra-pcm-audio",
	.codec_name = "tegra-das.0",
	.codec_dai_name = "tegra-das.0-in",
	.ops = &harmony_i2s_das_ops,
};

static struct snd_soc_dai_link harmony_das_wm8903_link = {
	.cpu_dai_name = "tegra-das.0-out",
	.codec_name = "wm8903-codec.0-001a",
	.codec_dai_name = "wm8903-hifi",
	.ops = &harmony_das_codec_ops,
};

static struct snd_soc_dai_link *harmony_links[] = {
	& harmony_i2s_das_link,
	& harmony_das_wm8903_link,
};

static struct snd_soc_card snd_soc_harmony = {
	.name = "tegra-harmony",
	.dai_link = &harmony_links,
	.num_links = ARRAY_SIZE(harmony_links),
};

And then re-write the tegra-das driver to expose two DAIs somehow?

Wouldn't that end up exposing two streams to user-space, one for each entry
in harmony_links[]?

-- 
nvpublic
