From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Sun, 5 Jun 2016 09:48:36 -0700
Message-ID: <CAG5mAdw2kk1t7uSScX6pXUrw0Uzp9XtcENmAf_9rAySKSjgxNQ@mail.gmail.com>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia> <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
 <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
 <20160602171753.GQ2282@sirena.org.uk>
 <CAG5mAdwp2DEeFk6pwe6n65iQHHzzyiNPx1QTz3u2rUsQRUpNEA@mail.gmail.com>
 <20160602184014.GR2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4972607C8
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 18:48:56 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id r4so1581179oib.1
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 09:48:56 -0700 (PDT)
In-Reply-To: <20160602184014.GR2282@sirena.org.uk>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 2, 2016 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 02, 2016 at 10:40:58AM -0700, Caleb Crome wrote:
>> On Thu, Jun 2, 2016 at 10:17 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Well, if you specifically mean TDM as opposed to multi-channel our
>> > general support for that isn't good (mainly due to lack of demand).  It
>> > sounds like you're more interested in multi channel here though.
>
>> I must be missing something.  To me, TDM is synonymous with
>> multi-channel on a single wire. The datasheets of codecs and SoCs
>
> TDM, at least in the sense Linux is using it, is multiple *unrelated*
> audio streams on a single wire.  Any multi-channel audio stream is TDM
> in some sense but the trivial extension to add two or more channels
> isn't really a big deal.  This is for things more complex than just
> stuffing more bytes of data onto a wire where there are going to be some
> timeslots that the device should ignore as they're going to/from other
> devices (or at least other streams even if the same chip is handling
> them).

Hi Mark,
   Thanks for taking the time to describe this to me.  This definitely
comes as a surprise to me.  I assumed that TDM mode simply means
multi-channels on a single wire (which is what it means in all the
datasheets).

Just so I have this straight, TDM in the linux sense is putting say,
6-channels on one wire where the channels are from logically different
places? i.e. chanels 0-1 are from bluetooth, 2-3 from analog in, and
4-5 from somewhere else?

So, going back to Nicolin's original question for this email, the
CS53L30, what are the proper DT settings for these modes:
The device can be configured in what amounts to at least 3 different modes:

1) 4-channel, 5-pin ADC interface:  dual I2S: shared BCLK/WCLK/MCLK,
separate data pins for channels 0/1 and 2/3 (SDOUT0/SDOUT1).
2) 4-channel, 4-pin ADC interface: MBLCK/BCLK/WCLK/SDOUT0 only.  Slots
0/1/2/3 on the SDOUT0 pin (synch master)
3) and finally, a multi-codec configuration, where 4 x CS53L30 are
used:  16-channel, 4-pin ADC (what I call TDM) interface, all on the
same 4 pins.  These are very related data streams -- they are
perfectly synchronized in hardware, so perhaps this isn't TDM in the
linux-sense.

>> Nicolin Wrote:
>> Another question is for its TDM support. This chip outputs 4-channel
>> data on two data output pins (SDOUT1 and SDOUT2) as normal mode; it
>> outputs 4-channel data on one data output pin (SDOUT1) as TDM mode.
>> However, the mode selection for a 4-channel recording should depend
>> on the hardware design: whether the SDOUT2 is connected or not. So
>> I am wondering if there is a common way or existing way to indicate
>> this hardware design. Or just by simply defining a new DT property?

As far as I can see he's not trying to define *unrelated* streams in
TDM mode, but very related streams, which is TDM in the
datasheet-sense.  And there not only needs to be a mechanism of
choosing the dual I2S mode, but also which TDM slots to drop the data
in (which I think already exists, right?)


>> What's the linuxy name for what the datasheets call TDM format with
>> slots > 2?  Do we just call that 'multi-channel', or specifically say,
>> 'channels_max > 2'?  I was always under the assumption that's what TDM
>> meant.
>
> We don't particularly call it anything, it's such a trivial extension.

That's not been my experience :-) Getting 16 channels onto a wire has
been anything but trivial because of the lack of SoC driver support
for it.  Perhaps I'm just using the wrong SoCs.

Thanks again,
 -Caleb
