From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 11:44:18 -0700
Message-ID: <CAOesGMh1zSFnYTBjLdUPBv6od_K0okrTTipnhu6BjO-QX1X6PA@mail.gmail.com>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
 <20130918165334.GA26446@quad.lixom.net>
 <20130918172858.GE21013@sirena.org.uk>
 <20130918173620.GA28143@quad.lixom.net>
 <20130918183401.GG21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 920762615BF
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 20:44:18 +0200 (CEST)
Received: by mail-we0-f170.google.com with SMTP id w62so6981913wes.15
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 11:44:18 -0700 (PDT)
In-Reply-To: <20130918183401.GG21013@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2013 at 11:34 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Sep 18, 2013 at 10:36:20AM -0700, Olof Johansson wrote:
>> On Wed, Sep 18, 2013 at 06:28:58PM +0100, Mark Brown wrote:
>
>> > I'd have expected the folks doing the allyesconfig builds to have
>> > complained then...
>
>> Allyes will probably turn on CONFIG_ACPI and thus reference the variable
>> in the struct device.
>
> Yeah, I was thinking of OF which isn't available on all architectures.
> Perhaps it is on every architecture people tend to do this stuff on
> though.
>
>> With the new of_match_ptr() and ACPI_PTR() you get rid of the
>> ifdef in struct device for those, but you still want it around
>> MODULE_DEVICE_TABLE() and the actual definition of the match table.
>
> Hrm, perhaps that was what was supposed to happen - have
> MODULE_DEVICE_TABLE() create the appropriate eliminateable static
> reference so the compiler can figure things out and we don't need the
> ifdefs.  It'd certainly be nice to elimiante more of these ifdefs.

Easiest way to do that is probably to provide a new macro to declare
the match tables with, that compiles out and/or gives appropriate
attributes depending on what is enabled or not in the config. That
gets rid of the ifdefs but we don't have anything like it today.

I'm honestly not sure I think it's needed, the ifdef for the table
doesn't bother me. But if people feel strongly about it then it's
likely the best way forward.


-Olof
