From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 11:44:07 -0400
Message-ID: <9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 270611039AC
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 17:44:08 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so942796qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 08:44:07 -0700 (PDT)
In-Reply-To: <20090513224424.GB24973@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 6:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 13, 2009 at 03:18:36PM -0400, Jon Smirl wrote:
>
>> On PowerPC the device tree is used to dynamically load the correct
>> codec module. How am I supposed to get this dynamically loaded module
>
> For an AC97 CODEC in the standard configuration there should be no need
> for the CODEC to appear in the device tree for it to be discovered.
> However...
>
>> registered? The WM8580 codec registers itself.
>
> The CODEC driver should use the normal kernel APIs to get itself probed.
>
> In the specific case of AC97 what ought to be happening is that the
> CODEC driver is dynamically probed based on the ID registers (as the
> non-ASoC AC97 core code does). =A0There's quite a bit of infrastructure
> work that needs to be done on the AC97 bus to make that viable, though -
> at the minute it doesn't support dynamic module loading and is only
> used for secondary CODEC functions like touchscreens. =A0There doesn't
> seem to be much prospect of anyone doing anything with this in the
> immediate future, most of the PC side effort is on HDA these days and in
> the embedded space the situation is similar and there's more urgent
> things with AC97 like platform data that are likely to get dealt with
> first.

Can we stick with the modifications to of_simple I just posted for
2.6.31 and then try to get the core fixed in 2.6.32 so that of_simple
can be removed? I have no love for of_simple, I will immediately
remove it in favor of core support. Removing it has no impact on user
space.

of_simple handles both i2s and ac97. There's no probing mechanism for
i2s so we will have to keep device tree support that attaches i2s
codecs. There's also the problem of platform data for the ac97 codec
contained in the of node.

I would switch to HDA immediately but none of the embedded CPUs have
HDA controllers.


>
> What's happening at the minute for ASoC is that AC97 CODECs are not
> required to be registered before the card instantiates. =A0A better
> solution would involve having the AC97 controllers probed for CODECs
> when they register but that would require some cooperation from the
> machine driver since random actions may be required to ensure that the
> CODECs are operational (see Zylonite with CLK_POUT in use for a simple
> example). =A0There would also be some fun handling the ac97.c adaptor but
> we can cross that bridge when we come to it.
>
>> Modifying the WM9712 codec to register itself on device load works for
>> me. If I don't do this how am I supposed to dynamically find the DAI
>> pointer so that I can call snd_soc_register_dais()?
>
> I'm unenthusiastic about including any more of this soc-of-simple stuff
> in CODEC drivers, if it's going to be more generally used it ought to be
> pushed into the core. =A0soc-of-simple predates the core registration
> support and since registration is now required for everything there
> doesn't seem to be any sense in going through all the existing CODEC
> drivers adding specific bodges for this - we should just move the
> soc-of-simple stuff into the core registration functions so we don't
> need to modify the individual drivers.
>
> That doesn't solve your OpenFirmware problems; the easiest thing there
> is probably to do a specific soc-of-simple variant or option that knows
> how to find the various AC97 driver options there are. =A0That's not ideal
> but it's tractable since there aren't that many AC97 CODECs. =A0I don't
> think I'd object to core code to read the ID registers either so long as
> it doesn't impact boards that need to jump through hoops to get the
> CODEC running.
>
> I definitely don't want to be adding random platform devices for AC97
> CODECs if at all possible since it feels like it complicates the AC97
> support more than it already is.
>



-- =

Jon Smirl
jonsmirl@gmail.com
