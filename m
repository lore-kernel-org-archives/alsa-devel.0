From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Mon, 25 May 2015 11:58:59 -0700
Message-ID: <CAEUnVG6=eXTCir5uCVO+=b9GieP6vXScNuYcM_2s2=sF9PGLog@mail.gmail.com>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de> <20150525171501.GC21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f41.google.com (mail-vn0-f41.google.com
 [209.85.216.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A9B2625CF
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 20:59:24 +0200 (CEST)
Received: by vnbg7 with SMTP id g7so5644702vnb.12
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 11:59:22 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 10:15 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 25, 2015 at 05:17:01PM +0200, Lars-Peter Clausen wrote:
>> On 05/23/2015 12:09 AM, Dylan Reid wrote:
>
>> >The first three changes add a gpio audio jack device.  This device can
>> >be used on systems that report headphone or mic plug through GPIOS.
>> >There can be 0-N of these devices created per board each can report one
>> >of several events.  For example, this allows for a single jack for
>> >HP/Mic and a separate jack for line out.
>
>> I'm not convinced that this series is the right approach and I don't think
>> it helps us to solve the problem.
>
> I think it solves the 90% case well enough for simple-card (which is to
> the main target user here) and the situation with jack detection is
> already fragmented enough that we're not likely to make things
> that much worse.  Though now I think about it just taking the gpio out
> of the device name would help with binding reuse for other users.

Thanks for taking the time to look at this.

My goal was to enable simple-card to be used with a wider arrangement
of jacks.   There is still more that can be done to make this more
general, but hopefully this is a step in the right direction.  The
next step is to add an "audio-jack" binding to simple card which could
be satisfied with this "gpio-audio-jack" or a reference to the
ts3a227e or similar.  That should allow for the rk3288 board to use
simple-card.

>
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

The common use case is also the simplest one.  The framework doesn't
need to know if it is plugged or not because the policy is handled in
user space.  That could work well in extcon as long as there is a way
to map to a device and control.  However I'm not sure that provides
much added value.
