From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Tue, 26 May 2015 21:22:53 -0700
Message-ID: <CAEUnVG4FT-U_iwB573VchtQqe9p8jnMYYSptFoYHmzSiwOiG7A@mail.gmail.com>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de> <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de> <20150526201426.GA21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f46.google.com (mail-vn0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0516A265795
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 06:23:14 +0200 (CEST)
Received: by vnbf7 with SMTP id f7so9652724vnb.13
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 21:23:14 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2015 at 1:14 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 26, 2015 at 08:43:34PM +0200, Lars-Peter Clausen wrote:
>> On 05/25/2015 07:15 PM, Mark Brown wrote:
>
>> >I think it solves the 90% case well enough for simple-card (which is to
>> >the main target user here) and the situation with jack detection is
>> >already fragmented enough that we're not likely to make things
>> >that much worse.  Though now I think about it just taking the gpio out
>> >of the device name would help with binding reuse for other users.
>
>> Yea, but 90% of those 90% are already covered by the existing bindings. The
>
> I'm not sure what this thing with "yea" is (I've seen some other people
> use it too) but the normal word is "yes"...
>
>> existing simple-card bindings and driver support GPIO based jack detection,
>> albeit not as flexible as this. But we don't actually gain that much with
>
> Huh, so they do.  Ugh.
>
>> >Yes, this is the complete solution - and it's not an audio specific
>> >thing either, there's a reasonable case to be made for saying that that
>> >this should be resolved in extcon rather than in any one consumer
>> >subsystem.
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
>
> The only things that concerned me particularly were the name (which I
> did agree on once you mentioned it) and the use of a bitmask to describe
> what's being reported but it's hard to think of anything much better
> than that.

Is just "audio-jack" too generic?  There are a lot of audio jacks that
wouldn't be described by this binding, such as those reported by the
227e or 5650.  The original goal here was to describe a jack that has
one or more gpios, each representing a particular type of device being
attached.  This doesn't overlap with the binding for a jack that is
handled by a headset detect chip.  Does this seem like the right goal,
or is there a benefit to having an "audio-jack" binding that tries to
cover all different types of jacks?

Thanks for taking the time to think about this.

Dylan
