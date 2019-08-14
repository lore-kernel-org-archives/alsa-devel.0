From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
Date: Tue, 13 Aug 2019 21:24:28 -0700
Message-ID: <20190814042428.GA125416@archlinux-threadripper>
References: <20190813061014.45015-1-natechancellor@gmail.com>
 <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
 <20190814035947.GS12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190814035947.GS12733@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 09:29:47AM +0530, Vinod Koul wrote:
> On 13-08-19, 09:22, Pierre-Louis Bossart wrote:
> > On 8/13/19 1:10 AM, Nathan Chancellor wrote:
> > > clang warns when CONFIG_ACPI is unset:
> > > 
> > > ../drivers/soundwire/slave.c:16:12: warning: unused function
> > > 'sdw_slave_add' [-Wunused-function]
> > > static int sdw_slave_add(struct sdw_bus *bus,
> > >             ^
> > > 1 warning generated.
> > > 
> > > Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
> > > align with other serial links"), this code would only be compiled when
> > > ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
> > > depends on ACPI.
> > > 
> > > Now, this code can be compiled without CONFIG_ACPI, which causes the
> > > above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
> > > compiling the function; however, slave.c only contains three functions,
> > > two of which are static. Only compile slave.o when CONFIG_ACPI is set,
> > > where it will actually be used. bus.h contains a stub for
> > > sdw_acpi_find_slaves so there will be no issues with an undefined
> > > function.
> > > 
> > > This has been build tested with CONFIG_ACPI set and unset in combination
> > > with CONFIG_SOUNDWIRE unset, built in, and a module.
> > 
> > Thanks for the patch. Do you have a .config you can share offline so that we
> > add it to our tests?
> > 
> > > 
> > > Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/637
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >   drivers/soundwire/Makefile | 6 +++++-
> > >   drivers/soundwire/slave.c  | 3 ---
> > >   2 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > > index 45b7e5001653..226090902716 100644
> > > --- a/drivers/soundwire/Makefile
> > > +++ b/drivers/soundwire/Makefile
> > > @@ -4,9 +4,13 @@
> > >   #
> > >   #Bus Objs
> > > -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> > > +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
> > >   obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> > > +ifdef CONFIG_ACPI
> > > +soundwire-bus-objs += slave.o
> > > +endif
> > 
> > I am fine with the change, but we might as well rename the file acpi_slave.c
> > then?
> 
> Srini's change add support for DT for the same file, so It does not make
> sense to rename. Yes this patch tries to fix a warn which is there due
> to DT being not supported but with Srini's patches this warn should go
> away as sdw_slave_add() will be invoked by the DT counterpart
> 
> Sorry Nathan, we would have to live with the warn for few more days till
> I apply Srini's changes. So I am not taking this (or v2) patch
> 

That is fine as I can apply this locally. Could you point me to these
patches so that I can take a look at them?

Thanks for the reply!
Nathan
