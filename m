From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Wed, 27 May 2015 13:12:51 +0200
Message-ID: <5565A6B3.6040509@metafoo.de>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de> <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de> <20150526201426.GA21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 937FD265923
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 13:12:53 +0200 (CEST)
In-Reply-To: <20150526201426.GA21577@sirena.org.uk>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/26/2015 10:14 PM, Mark Brown wrote:
[...]
>
>>> Yes, this is the complete solution - and it's not an audio specific
>>> thing either, there's a reasonable case to be made for saying that that
>>> this should be resolved in extcon rather than in any one consumer
>>> subsystem.
>
>> If the bindings are good it doesn't really matter which framework eventually
>> picks them up, but in this case the bindings are awfully ASoC specific and
>> leak a lot of the shortcomings of the current implementation.
>
> Could you expand on the abstraction problems you see please?  It looks
> like a fairly direct mapping of GPIOs to a jack to me (like I say I
> don't see having GPIOs directly on the jack object as a problem - having
> to create a separate node to put the GPIOs in doesn't seem to solve
> anything) and we're not likely to have enough GPIOs to make the usual
> problems with lists of values too severe.

Sorry, I overlooked something which lead to a bit of misunderstanding. I 
though that the gpio-audio-jack driver also sets up the DAPM pins for the 
jack, based on that patch 4 removes the DAPM jack pin setup from 
tegra_max98090 driver. This would have resulted in a weired dependency chain 
where the gpio-audio-jack driver sets references DAPM pins by name which 
belong to the audio fabric that references the gpio-audio-jack node as its 
jack detection chip. But the driver doesn't actually do that so there is no 
real implicit dependency to the audio-fabric in the binding itself and it is 
all internal to the implementation. So that is OK.

I'm still a bit uncomfortable with mixing up jacks and jack detection logic. 
For the GPIO based jack detection logic this isn't that bad since we could 
argue that the DT node represents the jack. But I'm a bit afraid that this 
sets a precedence and we'll soon see bindings where the description of the 
jack becomes part of the description of the jack detection chip or CODEC. 
And the component or CODEC driver is responsible for registering the jack.

And the other problem is how do we match up DAPM widgets to a jack. This is 
functionality from the tegra_max98090 driver that is lost in this series.

- Lars
