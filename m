From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 12:56:27 -0400
Message-ID: <CAKON4Oz5t4duQoymgPufo24bAWHga3TKEE0wzGs4pLCW-9juvA@mail.gmail.com>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
 <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
 <20140728163645.GA17528@sirena.org.uk>
 <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
 <53D67F0C.3010207@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id C8EF0265162
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:56:27 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id v6so5929279lbi.25
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 09:56:27 -0700 (PDT)
In-Reply-To: <53D67F0C.3010207@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2014 at 12:49 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/28/2014 06:47 PM, jonsmirl@gmail.com wrote:
>>
>> On Mon, Jul 28, 2014 at 12:36 PM, Mark Brown <broonie@kernel.org> wrote:
>>>
>>> On Mon, Jul 28, 2014 at 12:33:57PM -0400, jonsmirl@gmail.com wrote:
>>>
>>>> So what do you want the device tree to look like?
>>>> Example with no external amp.
>>>> Example with external amp.
>>>
>>>
>>> To repeat what I said in a previous mail:
>>
>>
>> I see the aux binding in soc-core.c
>> Where is an example of how to use it in a device tree?
>
>
> https://lkml.org/lkml/2014/4/28/318
>
> Does pretty much them same though to what you proposed.
>

So devicetree...
    external-amp = phandle;

then internally I'll hook it up to the aux_dev instead of replacing my
codec. And yes, codec is not completely empty it has widgets for the
possible output pins.


-- 
Jon Smirl
jonsmirl@gmail.com
