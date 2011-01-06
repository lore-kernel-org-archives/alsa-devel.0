From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Thu, 6 Jan 2011 09:46:10 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567B85@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
	<20110106005951.GC12153@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D1DA3244D6
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 18:46:24 +0100 (CET)
In-Reply-To: <20110106005951.GC12153@opensource.wolfsonmicro.com>
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
> 
> On Wed, Jan 05, 2011 at 04:20:04PM -0800, Stephen Warren wrote:
> 
> > One of the nice things about ALSA on desktop is that everything just works
> > without having to fiddle around setting up routing etc. from user-space e.g.
> > using alsamixer or custom code.
> 
> If you look at the desktop case on a modern system a fair chunk of the
> configuration is actually being handled by PulseAudio rather than the
> driver - the driver exposes a standard view of the cards but Pulse
> figures out how it should be configured.  Probably at some point after
> the media controller API (or something like it) makes it into mainline
> we'll start to see some efforts at similar managment for embedded
> systems, but the diversity of the hardware makes this a much more
> difficult problem.
> 
> > Isn't ASoC attempting to set up a reasonably good routing/configuration on a
> > per-board basis, driven by knowledge in the machine (board?) driver? Then,
> > let people tweak it /if/ they want? It kinda sounds like you're pushing for a
> 
> No, it's delegating everything to userspace.
> ... [more detailed explanation]

OK. I understand having the use-cases controlled from user-space. However, I'm
still having a little trouble mapping your explanation to what's actually in
the code for various existing ASoC drivers.

As a specific example, look at sound/soc/atmel/playpaq_wm8510.c (for no other
reason than being alphabetically first in the source tree):

static const struct snd_soc_dapm_widget playpaq_dapm_widgets[] = {
        SND_SOC_DAPM_MIC("Int Mic", NULL),
        SND_SOC_DAPM_SPK("Ext Spk", NULL),
};

static const struct snd_soc_dapm_route intercon[] = {
        /* speaker connected to SPKOUT */
        {"Ext Spk", NULL, "SPKOUTP"},
        {"Ext Spk", NULL, "SPKOUTN"},

        {"Mic Bias", NULL, "Int Mic"},
        {"MICN", NULL, "Mic Bias"},
        {"MICP", NULL, "Mic Bias"},
};

This is the kind of thing I'm talking about when saying that the machine
drivers define the routing - or more precisely, they define all the possible
legal routes, but then allow the driver to actually select which of those
routes to actually use in the face of multiple options, such as both
headphone and speaker outputs from a codec connected to a single CPU DAI.

Is this a level below the cases you were describing; i.e. in ASoC currently,
the machine driver does specify possible routes, but let's user-space decide
which of those to activate based on use-cases?

If the latter is true, then I'd argue that the mapping of CPU audio controller
to CPU audio port (i.e. Tegra DAS configuration) is the same kind of thing. I
suppose that feeds into your argument that the DAS driver should be a codec,
albeit ASoC doesn't fully support chaining of codecs right now IIUC.

So, long term in Tegra's case, there would be a DAS codec with 3 controller-
side DAIs and 5 port-side DAIs. The machine driver for Harmony would connect
(using snd_soc_dapm_route data) just one of those port-side DAIs to the
WM8903, and presumably only one of the controller-side DAIs to just the one
controller, since it wouldn't make sense to actually expose N controllers
when at most one could be used.

Or, would you expect Harmony to hook up both I2S controllers to the DAS
codec, and let the user decide which one to use? Personally, I'd expect
only a single controller to be exposed since only one can be used at a time,
and hence toggling between using different controllers is pointless, and
hence so is setting up two controllers.

On a system with two plus ports connected to a codec or modem, I imagine the
machine driver would expose and connect enough controllers as makes sense
based on the number of ports used and max number available in HW, and then
define (again, using snd_soc_dapm_route data)either a 1:1 mapping between
controllers and ports, or a more complex mux, based on whether
#controllers==#ports, or #controllers<#ports.

So again, it's that kind of thing that I had envisaged the machine driver
dictating; how many I2S controllers to "enable", and which I2S ports to
map them to.

Finally, all the above is really talking about what a machine driver
"allows". It'd still be nice if the default (in the absence of any
alsamixer or UCM setup) was that opening e.g. hw:0,0 would allow some
simple use of the audio, e.g. playback to primary output, capture from
primary input, so that simple testing could be performed without having
to set up a bunch of infra-structure in user-space. At least for playback,
this is the case today for the Tegra audio driver contained in the patches
I sent to the mailing list, and also for capture with the internal version
with all that backdoor codec register hacking.

I wonder if such default setup is equivalent of something like the
following from the atmel driver:

        /* always connected pins */
        snd_soc_dapm_enable_pin(dapm, "Int Mic");
        snd_soc_dapm_enable_pin(dapm, "Ext Spk");
        snd_soc_dapm_sync(dapm);

Thanks again for all the help.

-- 
nvpublic
