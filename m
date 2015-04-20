From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Mon, 20 Apr 2015 15:48:19 -0700
Message-ID: <CAJzqFtbseDe8c19ZpZjw3y72-+eO1+Zcq7D+DC=0G5_LbimRJg@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <20150418111622.GD26185@sirena.org.uk> <CAJzqFtYBvNAgwROZ09MGanYOyyF0EXEL7W9ZF4eAhprQVquNcQ@mail.gmail.com>
 <20150420220338.GZ14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420220338.GZ14892@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 20, 2015 at 3:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 20, 2015 at 02:18:56PM -0700, Kevin Cernekee wrote:
>> On Sat, Apr 18, 2015 at 4:16 AM, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Apr 15, 2015 at 02:42:19PM -0700, Kevin Cernekee wrote:
>
>> >> +- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply
>
>> > This is clearly not correct - if there are three separate physical
>> > supplies there should be three separate regulators requested.  They may
>> > all resolve to one physical regulator on the board you are working with
>> > but that might not be true on other boards.
>
>> In the "simplified diagram," TI shows a single AVDD/DVDD/HP_VDD supply:
>
>> http://www.ti.com/lit/ds/symlink/tas5717.pdf#2
>
>> Page 20 also suggests the use of a single 3.3V supply for AVDD/DVDD/HP_VDD.
>
>> But this combines a number of separate pins.  On 5711 we have
>> dedicated pins for:
>
>> PVDD_A
>> PVDD_B
>> PVDD_C
>> PVDD_D
>> AVDD
>> DVDD
>
> Yes, those are three separate supplies that are typically tied together
> - it looks like PVDD has high current draw so is tied through multiple
> pins.

Each half-bridge output OUT_{A,B,C,D} has its own dedicated
PVDD_{A,B,C,D} supply on 5711:

http://www.ti.com/lit/ds/symlink/tas5711.pdf#7

I don't understand the statement: "those are three separate supplies
that are typically tied together."  AVDD/DVDD are 3.3v fixed but PVDD
is 8V minimum (5711) or 4.5V minimum (5717/5719).  So AVDD/DVDD can
never be driven by the same regulator output as PVDD.  Perhaps you
were thinking of HPVDD/AVDD/DVDD on 5717/5719?

The simplified application diagram on page 2 does show that AVDD/DVDD
are typically tied together, and that PVDD_* are also typically tied
together.  But as you pointed out, there may be situations where that
isn't the case, so that leaves us with up to 6 separate supplies on
5711, or 5 on 5717/5719.  The typical case is probably closer to 2 or
3, though.

> I'd not be surprised to see systems with AVDD tied to a separate
> pin, analogue supplies often benefit from low noise supplies separate to
> digital ones.  Indeed if you look at the pin descriptions the analogue
> and digital supplies even have separate grounds.
>
>> I didn't see anything in the datasheet suggesting it is OK to have
>> different voltages or power states on the various supply pins (other
>> than the special voltage on PVDD).
>
> That's more likely to go wrong if they're not controlled separately than
> if they are since we will only be able to turn a single supply on or
> off..
>
>> I can add as many regulator entries as appropriate.  What do you recommend?
>
> Have the driver accurately reflect the hardware, request one regulator
> per supply.

So, request one regulator per VDD pin?  Or group all of PVDD_* into a
single regulator?
