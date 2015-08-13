From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Thu, 13 Aug 2015 12:44:33 -0700
Message-ID: <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
 <20150813112639.GB1654@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 93540264F39
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 21:44:34 +0200 (CEST)
Received: by vkfi73 with SMTP id i73so1789217vkf.3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 12:44:33 -0700 (PDT)
In-Reply-To: <20150813112639.GB1654@sirena.org.uk>
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
Cc: mfelton1@nuvoton.com, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Aug 13, 2015 at 4:26 AM, Mark Brown <broonie@kernel.org> wrote:
>> Locally I tried to move clock initialization out of platform code to
>> codec itself. Codec calls devm_clk_get() in init and sets frequency in
>> nau8825_set_sysclk(). See it here
>> https://github.com/anatol/linux/tree/nau8825  It works fine on a
>> Tegra-based device. But I found that devm_clk_get() is DTS specific
>> and does not work with ACPI. We need NAU8825 driver for Intel platform
>> as well.
>
> No, that is not the case at all - what makes you claim that devm_clk_get()
> is DT specific?

clk_dev uses of_clk_get_by_name() that is implemented for DTS only.
See include/linux/clk.h.

ACPI has a compatible API for getting simple properties
(strings/numbers), but no API for dealing with clocks.


> I very much doubt that this will be a problem for all boards.  To repeat
> what I said in my previous reply:
>
> | The assumption would be that if the system doesn't have or need jack
> | detection then the jack pins won't be reconfigurable anyway.
>
> Your board may be wired up with jack detection configured in a way that
> needs this, I would be surprised if all boards were.

I am still trying to understand the use-case for NAU8825 without jack
detection functionality. Are you talking about a board configuration
that does not wire jack to JKDET codec pin and (maybe) statically
connects output to speakers?

If platform driver does not enable jack detection, what NAU8825
functionality suppose to work? Does output (HPL/HPR) suppose to work?
Does mic suppose to work? Is OMTP/CTIA mic detection functionality
needed?
