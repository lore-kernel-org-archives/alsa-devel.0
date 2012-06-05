From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Confusion about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Tue, 05 Jun 2012 14:24:47 -0600
Message-ID: <4FCE6B0F.6080106@wwwdotorg.org>
References: <4FC7F576.30101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 897F6246E3
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 22:24:52 +0200 (CEST)
In-Reply-To: <4FC7F576.30101@wwwdotorg.org>
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

On 05/31/2012 04:49 PM, Stephen Warren wrote:
> [I'm having issues with CODEC/CODEC links]

I believe I've tracked down the issue I'm having. Playback isn't working
because of a lack of a complete DAPM path from CPU DAI to the final
CODEC in the chain. This path does not exist, because some DAIs on some
CODECs in the chain are getting DAI widgets created multiple times.

I have the following DAIs/links:

CPU DAI is dev=tegra30-ahub-apbif dai=APBIF0

link (1) from APBIF0 in ^ to APBIF0 in \/

CODEC dev=tegra30-ahub-xbar with DAIs APBIF0, I2S1

link (2) from I2S1 in ^ to CIF in \/

CODEC dev=tegra30-i2s.1 with DAIs CIF, DAP

link (3) from DAP in ^ to wm8903-hifi in \/

CODEC wm8903.4-001a dai=wm8903-hifi

The links in the machine driver are listed in order (1) (3) (2).

The problem is that when link (3) is instantiated, the DAP DAI is probed
on its own as just a CPU DAI. This happens in soc_probe_dai_link() in
the "probe the cpu_daiI" logic.

Then later when link (2) is instantiated, the entire tegra30-i2s.1 CODEC
is probed. This happens in soc_probe_dai_link() in the "probe the CODEC"
logic.

Both those two things call snd_soc_dapm_new_dai_widgets() for the I2S
CODEC's DAP DAI. Furthermore, the DAPM context in each case is
different. For link (2) it's the I2S1 CODEC's DAPM context; see the call
to snd_soc_dapm_new_dai_widgets() from soc_probe_dai_link(). For link
(3), it's the DAP DAI's own context; see the call to
snd_soc_dapm_new_dai_widgets() from snd_soc_probe_codec().

So, there end up being two DAP DAI widgets created for the one DAI.

In turn, I believe that snd_soc_dapm_add_route() ends up being confused
by this, either setting up the wrong route, or none.

To solve this:

Initially, I thought that snd_soc_dapm_new_dai_widgets() could just
return if the DAI already had widgets, but that doesn't work, since the
widgets were created for the wrong DAPM context - the I2S1 DAP DAI's
rather than the I2S CODEC's.

Perhaps instead of blindly probing the CPU DAI, soc_probe_dai_link()
should check whether that DAI is part of a CODEC, and instead of calling
try_module_get() and snd_soc_dapm_new_dai_widgets(), it should just call
soc_probe_codec() on the parent CODEC (guarded by whether the CODEC was
already probed). Does that sound right? I'm attempting to make that work
now, in case it's right.
