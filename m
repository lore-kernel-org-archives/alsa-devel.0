From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Sun, 16 Aug 2015 00:38:41 -0700
Message-ID: <CAOMFOmVtw9sXBRp6hkNu+AfhQR2TF-uJeyyB0SmHTtgLd8ZoQw@mail.gmail.com>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
 <20150813112639.GB1654@sirena.org.uk>
 <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
 <20150813223339.GN10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id F18B0260430
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2015 09:38:42 +0200 (CEST)
Received: by vkfi73 with SMTP id i73so44335319vkf.2
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2015 00:38:41 -0700 (PDT)
In-Reply-To: <20150813223339.GN10748@sirena.org.uk>
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
Cc: mfelton1@nuvoton.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dylan Reid <dgreid@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Aug 13, 2015 at 3:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 13, 2015 at 12:44:33PM -0700, Anatol Pomozov wrote:
>> On Thu, Aug 13, 2015 at 4:26 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, that is not the case at all - what makes you claim that devm_clk_get()
>> > is DT specific?
>
>> clk_dev uses of_clk_get_by_name() that is implemented for DTS only.
>> See include/linux/clk.h.
>
> That means that the clock API can work with DT, not that DT is
> mandatory - notice how there are stubs for the non-DT case.
>
>> ACPI has a compatible API for getting simple properties
>> (strings/numbers), but no API for dealing with clocks.
>
> So ACPI based platforms have to deal with providing clocks in some other
> way, that's something that is abstracted away by the clock API.  There
> are a number of drivers for both board file based and ACPI based systems
> already in tree which manage to make use of the clock API.

What is the best example of driver that uses clk API in both DT and
ACPI friendly way? I will use it as a template for my driver.

>> I am still trying to understand the use-case for NAU8825 without jack
>> detection functionality. Are you talking about a board configuration
>> that does not wire jack to JKDET codec pin and (maybe) statically
>> connects output to speakers?
>
> I'm not specifically familiar with this CODEC, however this sort of
> detection circuitry is all pretty standard.  I'm thinking of the sort of
> straightforward configurations where the detection inputs and any
> outputs required to flip polarity of the jack are just not wired up.

This corresponds to codec's JKDET/GPIO1 pin that is used as a default
source for jack detection interruption. And better place to describe a
board configuration like this is DTS.

Looking at Nuvoton's documentation I see it mentions that jack
detection IRQ source can be set to one of the GPIO pins or its
combination. In DTS it will look something like
  nuvoton,jkdet-source = <N>; // 0 to disable jkdet functionality, 1
for gpio1 (chip default), 2 for gpio2

The chip documentation on jack detection is sparse so I need to
clarify all aspects of configuration with Nuvoton engs.

And I believe this jack detection source configuration can be added
later and should not block the rest of the driver.
