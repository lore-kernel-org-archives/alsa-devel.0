From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 08:24:39 +0200
Message-ID: <53D5ECA7.5090106@metafoo.de>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-230.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 8842E2650C3
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 08:24:42 +0200 (CEST)
In-Reply-To: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Cc ASoC maintainers.

On 07/26/2014 05:18 PM, jonsmirl@gmail.com wrote:
> Allwinner CPUs have an on-chip codec that supports line out. This is a
> monolithic block that does not implement anything like standard I2S.
> We have implemented this by internally making a soc_card and then
> binding the DAI to a dummy NOP codec to make ASoC happy.
>
> But now someone wants to add a MAX9768 amplifier which needs a codec
> driver to implement volume control.
>
> So how should this be implemented? You want to use simple-audio-card
> when the MAX9768 is present.
>
> But what about the dummy-codec case? Using simple-audio-card to bind
> to a dummy-codec clutters things up a lot. Plus the dummy-codec is not
> currently exposed to device trees.
>
> And then there is the ordering problem, how do I know for sure MAX9768
> is not going to be bound so that it is safe to bind to dummy-codec.
> Or should binding to MAX9768 simply override a binding to the
> dummy-codec?
>
> If my dummy-codec is exposed into the device trees then this generates
> a bunch of NOP clutter in the tree using simple-audio-card to bind it.
>
> Another idea, maybe one of those NOP SDPIF codecs could get an alias
> name like NOP or Dummy.

Hi,

The dummy CODEC is a ASoC specific software construct, it should not appear 
in the description of the hardware. The reason why ASoC requires CODEC for 
successfully instantiate is due its history. When ASoC was initially 
designed and implemented your typical embedded audio system had 3 main 
components, the DMA, the I2C or AC97 CPU DAI and the CODEC with the CODEC 
DAI. And while the ASoC framework as gained support for more configurations 
over the years the basic requirement that at least one CODEC is present in 
the system has remained. So the correct solution in this case is to adopt 
the framework so it can properly support this new class of device it was 
previously not designed to handle. I've been working on removing the 
requirement that at least one CODEC needs to be present in the system by 
moving the abstraction level in the ASoC core to snd_soc_component level. 
This is mostly done and the final missing pieces are scheduled for 
submission after the next merge window closes.

While this restructuring allows for CODEC-less systems, it does not allow 
for DAI-less systems yet. At least if you want to have a PCM device. To 
properly support DAI-less systems 3 major pieces are missing:
* Currently the DAIs are entry and exit points of the PCM streams into the 
DAPM graph. This needs to be reworked so that there is a native 
representation of the PCM device in the DAPM graph which is used as the 
entry and exit point instead.
* Support for creating a PCM device without specifying a DAI link. Right now 
the only way in ASoC to create a PCM device is by having a DAI link. For 
systems without DAIs and DAI links we need an alternative. Preferably the 
driver for the on-chip CODEC should be able to create the PCM device itself 
since it is basically embedded in its hardware.
* Proper devicetree bindings for this kind of devices

- Lars
