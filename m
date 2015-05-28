From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Wed, 27 May 2015 22:38:32 -0700
Message-ID: <CAEUnVG6_p7xqYmkxjrqFwTbqwCEO0JiNwjL-pLE2GKv3eLbN+g@mail.gmail.com>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de> <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de> <20150526201426.GA21577@sirena.org.uk>
 <CAEUnVG4FT-U_iwB573VchtQqe9p8jnMYYSptFoYHmzSiwOiG7A@mail.gmail.com>
 <20150527172631.GG21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f49.google.com (mail-vn0-f49.google.com
 [209.85.216.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DE4C2604D6
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 07:38:54 +0200 (CEST)
Received: by vnbg62 with SMTP id g62so3556671vnb.8
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 22:38:53 -0700 (PDT)
In-Reply-To: <20150527172631.GG21577@sirena.org.uk>
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

On Wed, May 27, 2015 at 10:26 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 26, 2015 at 09:22:53PM -0700, Dylan Reid wrote:
>> On Tue, May 26, 2015 at 1:14 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > The only things that concerned me particularly were the name (which I
>> > did agree on once you mentioned it) and the use of a bitmask to describe
>> > what's being reported but it's hard to think of anything much better
>> > than that.
>
>> Is just "audio-jack" too generic?  There are a lot of audio jacks that
>> wouldn't be described by this binding, such as those reported by the
>> 227e or 5650.  The original goal here was to describe a jack that has
>
> I think it's fine - I think we can use this as a jack object and have
> other things reference it to supply additional detection mechanism.
> Lars' point about jacks not just being for audio is a valid one, though.
>
>> one or more gpios, each representing a particular type of device being
>> attached.  This doesn't overlap with the binding for a jack that is
>> handled by a headset detect chip.  Does this seem like the right goal,
>> or is there a benefit to having an "audio-jack" binding that tries to
>> cover all different types of jacks?
>
> So like I say I was thinking that either the jack object has a list of
> detection method phandles which point to other devices or the other
> devices point at the jack object.

I might not be completely following this.  Do we want to create a
binding for the physical plug and another for the method used to
detect the if a device is attached?

What is the benefit in separating the plug from the detection method,
these seem pretty tightly bound to me.  There are three main types of
detection for headsets, gpio, ADC measurement, and offload to a codec
or HP chip.  Are there situations where those would change separate
from how the jack is connected?
