From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 10:36:20 -0700
Message-ID: <20130918173620.GA28143@quad.lixom.net>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
 <20130918165334.GA26446@quad.lixom.net>
 <20130918172858.GE21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AED26158D
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 19:36:55 +0200 (CEST)
Received: by mail-pb0-f52.google.com with SMTP id wz12so7256464pbc.39
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 10:36:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130918172858.GE21013@sirena.org.uk>
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

On Wed, Sep 18, 2013 at 06:28:58PM +0100, Mark Brown wrote:
> > The problem doesn't show up when you build the driver as a module, because by
> > then the MODULE_DEVICE_TABLE() reference means the table is referenced. But
> > when you don't build as a module, MODULE_GENERIC_TABLE() reduces down to
> > nothing, thus causing this.
> 
> I'd have expected the folks doing the allyesconfig builds to have
> complained then...

Allyes will probably turn on CONFIG_ACPI and thus reference the variable
in the struct device.

> > Only way to avoid is as I see it is to mark the table __maybe_unused,
> > which in this case doesn't look like much of a better option.
> 
> > Most other drivers, for example those using pci or of module tables, have
> > Kconfig dependencies such that there's no need to ifdef. There are plenty of
> > examples of drivers ifdeffing on CONFIG_OF for those tables though.
> 
> Yes, you used to have to ifdef everything but there was a thing about
> stopping bothering doing that.  The same issue applies to the PM
> functions.  It's certainly annoying to have to faff around with the
> ifdefs all the time.
> 
> ISTR Arnd was telling me about this stuff, CCing him.

The PM case is particularly annoying because the device struct members
aren't there when PM is off, so you need the ifdef in the struct device
definition.

With the new of_match_ptr() and ACPI_PTR() you get rid of the
ifdef in struct device for those, but you still want it around
MODULE_DEVICE_TABLE() and the actual definition of the match table.


-Olof
