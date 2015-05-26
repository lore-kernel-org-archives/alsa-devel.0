From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Tue, 26 May 2015 20:43:34 +0200
Message-ID: <5564BED6.3070604@metafoo.de>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de> <20150525171501.GC21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 0916B262606
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 20:43:36 +0200 (CEST)
In-Reply-To: <20150525171501.GC21577@sirena.org.uk>
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

On 05/25/2015 07:15 PM, Mark Brown wrote:
> On Mon, May 25, 2015 at 05:17:01PM +0200, Lars-Peter Clausen wrote:
>> On 05/23/2015 12:09 AM, Dylan Reid wrote:
>
>>> The first three changes add a gpio audio jack device.  This device can
>>> be used on systems that report headphone or mic plug through GPIOS.
>>> There can be 0-N of these devices created per board each can report one
>>> of several events.  For example, this allows for a single jack for
>>> HP/Mic and a separate jack for line out.
>
>> I'm not convinced that this series is the right approach and I don't think
>> it helps us to solve the problem.
>
> I think it solves the 90% case well enough for simple-card (which is to
> the main target user here) and the situation with jack detection is
> already fragmented enough that we're not likely to make things
> that much worse.  Though now I think about it just taking the gpio out
> of the device name would help with binding reuse for other users.
>

Yea, but 90% of those 90% are already covered by the existing bindings. The 
existing simple-card bindings and driver support GPIO based jack detection, 
albeit not as flexible as this. But we don't actually gain that much with 
this series and most importantly it does not fix the underlying problem. 
What it does though is introduce a set of bindings which are not proper 
DT-ish bindings which describe the hardware, but which are a workaround for 
the quirks of the current ASoC framework. And once these bindings are 
applied we have to maintain them forever, which also means we have to 
maintain these quirks in the ASoC implementation forever.

>> I think what we need to get the layering and encapsulation right is to
>> introduce a distinction between jacks and jack detection logic. The jacks
>> are part of the fabric and should be registered by the machine driver. The
>> jack detection logic can be implemented by either GPIOs, a dedicated jack
>> detection chip, like the TS3A227E, or can be part of a more complex CODEC.
>> The jack detection logic is a function that is provided by these. The audio
>> fabric, which makes up the sound card, is a consumer of this functionality.
>
>> To be able to properly abstract this changes to the framework are necessary
>> to introduce the concept of jack detection logic providers and consumers.
>
>> The chip/driver that implements the jack detection logic register a jack
>> detection logic provider, the machine driver registers the jack and
>> specifies which jack detection provider is used for each jack.
>
> Yes, this is the complete solution - and it's not an audio specific
> thing either, there's a reasonable case to be made for saying that that
> this should be resolved in extcon rather than in any one consumer
> subsystem.

If the bindings are good it doesn't really matter which framework eventually 
picks them up, but in this case the bindings are awfully ASoC specific and 
leak a lot of the shortcomings of the current implementation.

- Lars
