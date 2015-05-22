From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Fri, 22 May 2015 03:11:17 +0200
Message-ID: <3809842.ZiibdYZ1mn@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <6154326.X9FC8ZVDIy@vostro.rjw.lan> <20150521102413.GA5866@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150521102413.GA5866@isilmar-3.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday, May 21, 2015 12:24:13 PM Dominik Brodowski wrote:
> On Thu, May 21, 2015 at 03:24:41AM +0200, Rafael J. Wysocki wrote:
> > On Monday, May 18, 2015 06:47:11 AM Dominik Brodowski wrote:
> > > On Mon, May 18, 2015 at 03:01:32AM +0200, Rafael J. Wysocki wrote:
> > > > On Sunday, May 17, 2015 07:41:44 PM Dominik Brodowski wrote:
> > > > > On Thu, May 14, 2015 at 11:55:33 PM Rafael J. Wysocki wrote:
> > > > > > On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> > > > > > > So the only value that would really make sense here is 5.
> > > > > 
> > > > > > Overall, what about the appended patch instead of your [2-3/4] (modulo the
> > > > > > new command line parameter description which is missing here ATM)?
> > > > > 
> > > > > Well, this approach works as well -- limiting it to an override for just 5
> > > > > seems reasonable; expanding blacklist.c to also cover this case (even though
> > > > > it's not a blacklisting per se) isn't worth any discussion.
> > > > > 
> > > > > Nonetheless, a few specifics:
> > > > > 
> > > > > > +config ACPI_REV_OVERRIDE_POSSIBLE
> > > > > 
> > > > > Why should that be a config option at all? The code savings should be
> > > > > really, really tiny;
> > > > 
> > > > The idea is not about the code savings, but about having a simple way to disable
> > > > the whole thing entirely at one point.
> > > > 
> > > > All of the workarounds under this option *including* the command line switch
> > > > should be temporary.
> > > 
> > > Hopefully, yes. But I am not convinced about that yet (see below).
> > > 
> > > > > and especially in the beginning we might see a few
> > > > > machines where testing the override might seem to be a good idea. So I'd
> > > > > favour having the command line optional, and then only specific quirks
> > > > > behind a config option: For the Dell XPS 13 it makes sense to disable the
> > > > > quirk if userspace can manage i2s sound; for other systems, there may not be
> > > > > such hope. And as this is a machine-specific decision, I fear that we have
> > > > > to do CONFIG options for each and every such DMI entry.
> > > > 
> > > > I'm not sure if we need a config option for Dell in particular.  We can simply
> > > > drop the quirk when it is not necessary any more.
> > > 
> > > The quirk for the Dell XPS 13 (2015), yes. Once userspace catches up (which
> > > may take _years_). But Matthew was mentioning that "[t]he Inspiron 7437
> > > queries _REV and uses it to modify its EC behaviour, and apparently breaks
> > > on Linux without that." If that is indeed the case, we will need a quirk
> > > for that Inspiron for much, much longer than for the Dell XPS 13 (2015).
> > > 
> > > Therefore, I see a need to distinguish the quirk for the Dell XPS 13 (2015),
> > > the quirk for the Inspiron 7437 and potential quirks for other systems: Some
> > > may depend on _sound_ userspace being up to date (XPS), some may depend on
> > > _other_ parts of userspace being up to date, and some may be needed for
> > > as long as these systems exist (Inspiron 7437?). And if the userspace for
> > > the XPS is up to date, the quirk for that particular issue may not be needed
> > > any more, while other quirks (such as potentially the one for the 7437) may
> > > still be needed -- that is why I see a need for different CONFIG options.
> > 
> > Which doesn't explain why we need a config option per quirk.  To me, such config
> > options don't add any value, because (a) everyone will set them anyway and (b)
> > removing the quirks from the source is trivial if needed.
> 
> As long as you consider userspace and kernel moving along at a coordinated pace,
> yes -- where we should simply agree to disagree.
> 
> That leaves just the question on whether the quirk (and especially the kernel
> parameter) should be hidden behind a special config option (and not just
> CONFIG_X86) -- especially if "everyone will set them anyway" and if "removing
> the quirks from the source is trivial if needed".

If somebody (eg. me) doesn't want to build in the entire code associated with
that stuff at all, the config option making it go away is actually useful.
Conversely, if you know you need at least one of the quirks or the command line
switch, building in it all is not a big deal.

I just want to avoid unnecessary proliferation of config options that's going
to result from that if we start to add them per quirk.

I guess the Matthew's point is that distros would not need to patch their
kernels to remove quirks if we added these config options to the mainline,
but quite frankly I don't see much difference in this particular case.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
