From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
Date: Fri, 09 Aug 2013 11:34:30 +0200
Message-ID: <5204B7A6.9050907@gmail.com>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CCED265717
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 11:34:35 +0200 (CEST)
Received: by mail-ee0-f48.google.com with SMTP id l10so1976102eei.21
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 02:34:35 -0700 (PDT)
In-Reply-To: <20130809091953.GO6427@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/09/13 11:19, Mark Brown wrote:
> On Fri, Aug 09, 2013 at 10:23:50AM +0200, Sebastian Hesselbarth wrote:
>> On 08/08/2013 01:22 PM, Jean-Francois Moine wrote:
>
>>> +i2s1: audio-controller@b4000 {
>>> +	compatible = "mrvl,mvebu-audio";
>>> +	reg = <0xb4000 0x2210>;
>>> +	interrupts = <21>, <22>;
>>> +	clocks = <&gate_clk 13>;
>>> +	clock-names = "internal";
>>> +};
>
>> Also we will need some phandle reference to the audio codec here. As
>> this property is ongoing work in ASoC core, I suggest we wait for it
>> and propose a binding afterwards.
>
> No, as discussed this should be in the binding for the audio subsystem
> not in the binding for an individual component in that subsystem.
>

Mark,

I do understand there may be SoCs requiring sophisticated extra audio
nodes, but Marvell SoCs don't. I prefer having a single node for the
i2s controller *and* exploit the audio subsystem properties from that.

For Marvell audio, we only need a single node for all three ASoC
drivers. No other subsystem _requires_ you to have extra nodes for
it's needs. If you can provide interrupts, just have an interrupt-
controller property. If you can provide clocks, you can link to that
very node - no virtual device node required. Even for media they
do not insist on a virtual node but they do have generic properties
you can exploit.

If you insist on creating a virtual sound card node just because
ASoC wants it that way - okay, your call. But I don't see any value
in that.

Sebastian
