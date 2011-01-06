From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Thu, 6 Jan 2011 21:02:38 +0000
Message-ID: <20110106210238.GD8018@opensource.wolfsonmicro.com>
References: <20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
	<20110106005951.GC12153@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567B85@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE1B12454D
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 22:02:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567B85@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 09:46:10AM -0800, Stephen Warren wrote:
> Mark Brown wrote:
> > On Wed, Jan 05, 2011 at 04:20:04PM -0800, Stephen Warren wrote:

> OK. I understand having the use-cases controlled from user-space. However, I'm
> still having a little trouble mapping your explanation to what's actually in
> the code for various existing ASoC drivers.

> As a specific example, look at sound/soc/atmel/playpaq_wm8510.c (for no other
> reason than being alphabetically first in the source tree):

> static const struct snd_soc_dapm_widget playpaq_dapm_widgets[] = {
>         SND_SOC_DAPM_MIC("Int Mic", NULL),
>         SND_SOC_DAPM_SPK("Ext Spk", NULL),
> };

> This is the kind of thing I'm talking about when saying that the machine
> drivers define the routing - or more precisely, they define all the possible
> legal routes, but then allow the driver to actually select which of those
> routes to actually use in the face of multiple options, such as both
> headphone and speaker outputs from a codec connected to a single CPU DAI.

Note that in the case of the mic this is also plumbing the bias in to
the jack itself so the core can figure out when that needs powering up.
With the speaker the widget is mostly documentation, it doesn't actually
*do* anything here.   Some systems have GPIOs or whatever that need
updating to power things externally, but that's not the case here, and
some will make a SND_SOC_DAPM_PIN_SWITCH() to allow userspace to control
stereo paths as one or otherwise manage the power for the widgets.

> Is this a level below the cases you were describing; i.e. in ASoC currently,
> the machine driver does specify possible routes, but let's user-space decide
> which of those to activate based on use-cases?

Yes.  The kernel says what's possible, userspace says what is.

> If the latter is true, then I'd argue that the mapping of CPU audio controller
> to CPU audio port (i.e. Tegra DAS configuration) is the same kind of thing. I
> suppose that feeds into your argument that the DAS driver should be a codec,
> albeit ASoC doesn't fully support chaining of codecs right now IIUC.

Exactly, yes.  The kernel lets the user do whatever is possible and
treats the decision about what's needed at any given moment as a policy
decision in line with the general kernel policy.

Chaining of CODECs will work at the minute, it's just really painful for
userspace right now as it has to manually configure and start each
CODEC<->CODEC link which isn't terribly reasonable, we only do it in
cases like digital basebands where there's no other option.

> Or, would you expect Harmony to hook up both I2S controllers to the DAS
> codec, and let the user decide which one to use? Personally, I'd expect
> only a single controller to be exposed since only one can be used at a time,
> and hence toggling between using different controllers is pointless, and
> hence so is setting up two controllers.

I don't think that'd be useful unless the CPU is capable of doing
mixing.  Similiarly, if both the CPU and CODEC could consume multiple
streams using TDM then it might be useful.  I don't think either of
those cases applies here, though.

> On a system with two plus ports connected to a codec or modem, I imagine the
> machine driver would expose and connect enough controllers as makes sense
> based on the number of ports used and max number available in HW, and then
> define (again, using snd_soc_dapm_route data)either a 1:1 mapping between
> controllers and ports, or a more complex mux, based on whether
> #controllers==#ports, or #controllers<#ports.

Or just let the user flip them over at runtime.

> So again, it's that kind of thing that I had envisaged the machine driver
> dictating; how many I2S controllers to "enable", and which I2S ports to
> map them to.

It's the which I2S ports to map them onto that I'd like to see
controllable at runtime - in the case where we have got multiple options
(especially if you had all three physical ports live).  Looking at your
code it seemed like it was also possible to do things like route the
external ports directly to each other so this sort of flexibility could
be used to, say, take the CPU out of the audio path between two external
devices for some use cases.

This isn't terribly likely to be used for things like Harmony but in
things like smartphones my general experience is that if there's
flexibility in the system someone's going to be able to think up a way
of exploiting it to add a feature.

> Finally, all the above is really talking about what a machine driver
> "allows". It'd still be nice if the default (in the absence of any
> alsamixer or UCM setup) was that opening e.g. hw:0,0 would allow some
> simple use of the audio, e.g. playback to primary output, capture from
> primary input, so that simple testing could be performed without having

Define "primary output" and "primary input" and what a sensible setup
for them is; it's not terribly clear what they are always.  Besides,
it's not like ALSA supports *any* use without alsa-lib or equivalent and
if you've got that far you've already got the infrastructure you need to
do configuration anyway more or less.  You'd need to do that to develop
the default settings anyway, and once you've done that you've then got
to translate them back into kernel space.

Probably the only people who'd get much from this are people who are
using a reference system with no userspace provided, which is fairly
unusual.  If a userspace is being shipped then including config there
generally isn't much of an issue, and if you're bringing up a board then
you're in the situation where you need to work out what the setup that's
needed is.

This also comes back to the issues with fragility from dependency on the
internals of the CODEC and to a lesser extent CPU drivers - it means the
machine driver needs to know much more about what's going on inside the
devices it's connecting which isn't great, and it means that if you
change the defualts in the machine driver you change the defaults
userspace sees which may break setups done by setting the values of
individual controls.

One other thing I should've mentioned is that from a subsystem
maintainer point of view we've got a clear and definite answer to what
the setup is so we don't need to worry about any debate on the issue,
that's all punted to userspace.

> to set up a bunch of infra-structure in user-space. At least for playback,
> this is the case today for the Tegra audio driver contained in the patches
> I sent to the mailing list, and also for capture with the internal version
> with all that backdoor codec register hacking.

Right, the WM8903 comes up with a DAC to headphone path by default.

One thing I'd say with most of the attempts I've seen to do the backdoor
write approach what ends up happening is that some of the configuration
done by userspace gets overwritten in the process of setting up the
route, which isn't always useful.

> I wonder if such default setup is equivalent of something like the
> following from the atmel driver:

>         /* always connected pins */
>         snd_soc_dapm_enable_pin(dapm, "Int Mic");
>         snd_soc_dapm_enable_pin(dapm, "Ext Spk");
>         snd_soc_dapm_sync(dapm);

> Thanks again for all the help.

Sort of; it's a combination of that and the fact that the default setup
of the WM8903 happens to be one that routes the DAC to the headphone.
