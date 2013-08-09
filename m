From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
Date: Fri, 09 Aug 2013 13:01:24 +0200
Message-ID: <5204CC04.4000401@gmail.com>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1B8265714
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 13:01:29 +0200 (CEST)
Received: by mail-ee0-f50.google.com with SMTP id d51so2021477eek.37
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 04:01:29 -0700 (PDT)
In-Reply-To: <20130809094340.GO23006@n2100.arm.linux.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/09/13 11:43, Russell King - ARM Linux wrote:
> On Fri, Aug 09, 2013 at 11:34:30AM +0200, Sebastian Hesselbarth wrote:
>> I do understand there may be SoCs requiring sophisticated extra audio
>> nodes, but Marvell SoCs don't. I prefer having a single node for the
>> i2s controller *and* exploit the audio subsystem properties from that.
>>
>> For Marvell audio, we only need a single node for all three ASoC
>> drivers. No other subsystem _requires_ you to have extra nodes for
>> it's needs. If you can provide interrupts, just have an interrupt-
>> controller property. If you can provide clocks, you can link to that
>> very node - no virtual device node required. Even for media they
>> do not insist on a virtual node but they do have generic properties
>> you can exploit.
>
> Certainly from the "DT is a hardware description" you are completely
> correct.  The audio controller _should_ link directly to the codec,
> because that's how the hardware is wired.  Remember though that there
> are two outputs from the audio controller (please, call it audio
> controller, not I2S controller) so you need to specify which of those
> two outputs the "codec" is connected to.

Exactly, we can solve that with multiple phandle/args audio-codecs
property and audio-codec-names (or whatever property names are more
appropriate). That is the common set of properties, I am talking about.
But the properties are totally unrelated to what nodes you put them
into.

> I would say that's required irrespective of whether or not we have a
> virtual node to aggregate the stuff together for ASoC's purposes (which
> should not be part of the DT hardware description - it can be part of
> the "software" configuration though.)

And that is *the only thing* that keeps bugging me in Mark's replies -
he *insists* on having that virtual audio nodes. I have nothing against
it, except it should be *required* for every DT we have. DRM doesn't
_need_ it, media doesn't _need_ it, but audio is so very special that it
_requires_ you to have it described in DT?

I understand that it may be required on some boards, especially if you
create different sound-cards out of the IP available. Just like the
DRM discussion we had - have a virtual node if there is no other sane
way to describe it, but there is no strict requirement.

Anyway, Mark keeps insisting on it, I'll obey.

> We may be able to have kirkwood-i2s.c (which I plan to rename to
> mvebu-audio.c) automatically generate the snd_soc_card stuff from the
> audio controller node.  Given that we need a more complex description
> than the "simple" thing for DPCM, that might be overall the best
> solution in any case (maybe calling out to a library which can be
> shared between CPU DAI drivers to do this.)

That is what I am doing on top of the audio-controller node and except
that there is no helper to determine the names, yet. If ASoC would
provide a snd_soc_simple_card_register_from_dt(...,device_node *), I
wouldn't even have to parse the properties myself.

> Note that we do have another case not yet in tree, which is DRM, but
> this case is different from that, because ASoC can cope with components
> with independent initialisation.

True, and those should also probe themselves independent of the
corresponding lcd driver. Now that we have the discussion on ASoC, that
will also allow us to have an audio codec driver for the TDA998x audio
part. We need that anyway to create correct AIF packets someday.

Sebastian
