From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Tue, 12 Aug 2014 08:45:22 -0400
Message-ID: <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB072650CC
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 14:45:24 +0200 (CEST)
Received: by mail-la0-f47.google.com with SMTP id mc6so7724631lab.6
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 05:45:23 -0700 (PDT)
In-Reply-To: <20140812115755.GO17528@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2014 at 7:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 12, 2014 at 07:46:58AM -0400, jonsmirl@gmail.com wrote:
>> On Tue, Aug 12, 2014 at 7:45 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>
>> > The machine driver is simple-card. It is not smart enough to change
>> > the sysclk between 22.5Mhz and 24.5Mhz depending on what music is
>> > being played.
>
>> Having said that, should we make simple-card smart enough to do that?
>
> Yes, as has been said several times now it's the responsibility of the
> machine driver to coordinate clocking in the card so if you want to use

I hear this, but I'm conflicted about putting a generic capability
into the machine driver.

> simple-card that means you need to add the feature to simple-card.

Some questions then....

1) Are sysclk and mclk the same thing? Inside of simple-card they seem
to be but I can possibly see arguments that they aren't.

2) Should sysclk for the cpu-dai and codec-dai be set independently?
In simple-card they can be set to conflicting values on the two nodes
in the DTS. Should sysclk be a single property for the machine?

3) If sysclk is defined by a phandle to a clock, how should clock
accuracy be handled? For example in my CPU the best clock that can be
made is about 0.01% less than what it should be. If you take that
frequency number and start doing integer division on it you won't get
the expect results because of truncation effects. Diving by 44100
gives 511.95 which truncates to 511 instead of 512.

4) If the sysclk is going to change based on the music, should it just
flip between 22.5/24.5 or should it use the FS multiplier in the
simple DTS and always be set to FS*music? For example FS=512 so for
44100 it is set to 22.5Mhz and 8000 it is set to 4Mhz.

5) What should the syntax for this look like in simple?

6) Longer term set-sysclk could be replaced by using phandles for the
clock and then clk notifiers in the components to listen for it being
changed. That would remove this problem of having multiple sysclks in
the system and the DTS syntax for identifying them.

So in my case I expose a MCLK clk. sgtl5000 codec references that
clock with a phandle. As the cpu-dai looks at the music it changes the
rate on MCLK. Codec gets notified of that change (if it is listening)
and can act on it.

For my TI codecs the MCLK code in the cpu-dai is still there and
changing the MCLK, but the TI codec won't have a reference to it in
the DTS. The TI codecs can auto clock on to whatever they are fed so
they don't need to listen to the MCLK changes.  cpu-dai knows that no
one is listening to MCLK and doesn't turn the pin on (saving power).





-- 
Jon Smirl
jonsmirl@gmail.com
