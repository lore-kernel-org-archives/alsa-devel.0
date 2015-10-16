From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: Splitting out controls
Date: Fri, 16 Oct 2015 16:35:30 +0100
Message-ID: <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>  <561CADA8.3040903@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F0B2606F6
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 17:35:58 +0200 (CEST)
In-Reply-To: <561CADA8.3040903@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-13 at 09:07 +0200, David Henningsson wrote:
> 
> On 2015-10-12 22:59, James Cameron wrote:
> > On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
> >> I've written up the minutes here below
> >
> > Thanks!
> >
> >> Splitting out controls: Takashi
> >> ===============================
> >>
> >>   - Restricted access.  Consensus to restrict access to some controls due
> >> to possibility of breaking HW at kernel level. i.e. prevent feeding
> >> digital Mic into HP amp to prevent speaker over heating.
> >
> > I'd like that.  rt5631.  Avoiding at the moment by removing the controls.
> 
> IIRC, the debate was over "do not expose dangerous controls to userspace 
> at all" vs "expose dangerous controls controls only to root".
> 
> I'm strongly voting for "do not expose to userspace at all".
> 
> I personally believe that if the physical hardware can be set to state 
> where it's bricked, the hardware itself is buggy.
> 
> If the hardware is buggy, this should be worked around in BIOS or 
> whatever firmware is present on the machine. Otherwise there is a bug in 
> BIOS.
> 
> If BIOS is buggy and cannot protect the machine from being physically 
> damaged, then we need to work around that in the kernel. Otherwise there 
> is a bug in the kernel.
> 
> And if the kernel is buggy, we should fix the kernel. Period. :-)
> 
I agree with you in principle that if it can break the hardware then
either it shouldn't be exposed to user-side at all, or it should be
checked by the kernel/driver to prevent bad settings.

However, what about this sort of scenario: some codec has a speaker
volume range of 0..100, all of which are valid and safe. Manufacturer X
makes a device with an inadequate speaker that can be damaged with
volume settings above 80. How is that protected? There's nothing wrong
with the codec driver. There's no software at all for a speaker - it's
just a speaker. Where do we put a hard limit of 80 on a codec control
for one specific device? If it was my codec driver I don't want to have
to put a workaround for one specific device because manufacturer X chose
the wrong type of speaker. Or do we not care about the "stupid
manufacturer" cases and we're only interested in protecting the device
the control directly applies to - in this example it's a codec control
so it mustn't damage the codec but we don't care if poor hardware design
means it could damage other hardware connected to the codec.
