From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 09:53:34 -0700
Message-ID: <20130918165334.GA26446@quad.lixom.net>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ECB82610D3
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 18:54:08 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id hz10so8505120pad.30
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 09:54:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130918153842.GA21013@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2013 at 04:38:42PM +0100, Mark Brown wrote:
> On Wed, Sep 18, 2013 at 08:13:14AM -0700, Olof Johansson wrote:
> > On Wed, Sep 18, 2013 at 2:41 AM, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, Sep 17, 2013 at 11:10:24PM -0700, Olof Johansson wrote:
> 
> > > Please send things to the advertised maintainer addresses.
> 
> > I sent it to the person signing off on the patch that this fixes up,
> > you should probably use your maintainer address for that.
> 
> In that case you should've also CCed the maintainer address, you should
> always CC maintainers on patches.

Sure, will do. But you should also consider using your maintainer address
for your maintainer work. Linaro will surely be credited for it anyway
in the oh-so-important statistics. :-)

> > > Shouldn't the fix for this be to do the same as we're doing for the OF
> > > tables and have an acpi_match_ptr()?  It seems like we're doing the same
> > > thing so we should be handling it in a similar fashion.
> 
> > There's already ACPI_PTR(), which is exactly why this warning shows
> > up. of_match_ptr() and ACPI_PTR() will evaluate to NULL if
> > CONFIG_OF/ACPI aren't set, which is the case here -- which in turn is
> > why there's a warning that the match table is defined but never used.
> 
> > So, the solution is either to not define the table, i.e. ifdef, or to
> > not use the ACPI_PTR() macro. It makes sense to not advertise the
> > driver as capable of probing on ACPI if ACPI is not enabled in the
> > kernel config, which in turn means ifdef.
> 
> > Unless I'm missing something here, of course. :)
> 
> We're supposed to be able to do this sort of stuff without the ifdef
> noise and have the compiler eliminate unreferenced static symbols
> automatically, though I can't see how of_match_ptr() actually does this
> now.  I don't immedately seem to be able to persuade Kconfig to turn
> off OF to verify though we do have some examples which nobody has
> complained about...

The problem doesn't show up when you build the driver as a module, because by
then the MODULE_DEVICE_TABLE() reference means the table is referenced. But
when you don't build as a module, MODULE_GENERIC_TABLE() reduces down to
nothing, thus causing this.

Only way to avoid is as I see it is to mark the table __maybe_unused,
which in this case doesn't look like much of a better option.

Most other drivers, for example those using pci or of module tables, have
Kconfig dependencies such that there's no need to ifdef. There are plenty of
examples of drivers ifdeffing on CONFIG_OF for those tables though.


-Olof
