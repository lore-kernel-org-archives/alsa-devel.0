From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Mon, 19 Aug 2019 16:01:12 -0700
Message-ID: <CAOReqxg+J=Sa1o+1Cmo7hrh136k2tUFCaqxPgrXE=DKfwsbTfw@mail.gmail.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
 <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
 <356b3f4eacb43f23c40c4cd8e3c54ae9514a34c6.camel@linux.intel.com>
 <7e08e45d-7cec-9fdd-36c5-5e82632968f8@linux.intel.com>
 <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
 <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
 <CACJJ=pxokT5z+U=nM9QcUVxCk84998ugM5J89U28k=CVGMjG=w@mail.gmail.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A9606FC567@SHSMSX106.ccr.corp.intel.com>
 <d0131c02-3477-8390-e0c6-b37b142169e8@intel.com>
 <CACJJ=pwsV2U669QqB0E05XxWppfXR81TrDCkEunfSefJ5Mij7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7E7FF802E0
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 01:01:25 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id y26so3858890qto.4
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 16:01:25 -0700 (PDT)
In-Reply-To: <CACJJ=pwsV2U669QqB0E05XxWppfXR81TrDCkEunfSefJ5Mij7w@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jon Flatley <jflat@chromium.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Ross Zwisler <zwisler@google.com>, Jie Yang <yang.jie@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "benzh@chromium.org" <benzh@chromium.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "cujomalainey@chromium.org" <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2019 at 3:37 PM Jon Flatley <jflat@chromium.org> wrote:
>
> On Mon, Aug 19, 2019 at 11:08 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
> >
> > On 2019-08-19 04:33, Jie, Yang wrote:
> > >
> > >> -----Original Message-----
> > >> From: Jon Flatley [mailto:jflat@chromium.org]
> > >> Sent: Thursday, August 15, 2019 5:25 AM
> > >> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >> Cc: Jon Flatley <jflat@chromium.org>; Jie, Yang <yang.jie@intel.com>;
> > >> benzh@chromium.org; alsa-devel@alsa-project.org; Ranjani Sridharan
> > >> <ranjani.sridharan@linux.intel.com>; cujomalainey@chromium.org; Jie Yang
> > >> <yang.jie@linux.intel.com>
> > >> Subject: Re: [alsa-devel] [BUG] bdw-rt5650 DSP boot timeout
> > >>
> > >> On Wed, Aug 14, 2019 at 1:51 PM Pierre-Louis Bossart <pierre-
> > >> louis.bossart@linux.intel.com> wrote:
> > >>>
> > >>>
> > >>>> There seems to be an issue when suspending the ALC5650. I think the
> > >>>> nondeterministic behavior I was seeing just had to do with whether
> > >>>> or not the DSP had yet suspended.
> > >>>>
> > >>>> I reverted commit 0d2135ecadb0 ("ASoC: Intel: Work around to fix HW
> > >>>> D3 potential crash issue") and things started working, including
> > >>>> suspend/resume of the DSP. Any ideas for why this may be? I would
> > >>>> like to resolve this so I can finish upstreaming the bdw-rt5650
> > >>>> machine driver.
> > >>>
> > >>> Copying Keyon in case he remembers the context.
> > >>>
> > >>> Reverting a 5yr-old commit with all sorts of clock/power-related fixes
> > >>> looks brave, and it's not clear why this would work with the rt5677
> > >>> and not with 5650.
> > >>
> > >> No idea, I was just diffing the register writes looking for sources of discrepancy.
> > >> The Chromium OS 3.14 kernel tree that Buddy uses doesn't have this patch, so
> > >> I figured what's the worst that could happen?
> > >
> > > Hi Jon, sorry about just noticing this thread.
> > >  From the dmesg log, the issue happens at runtime suspend/resume but not in boot, am I right(you can disable runtime PM for the device to confirm that)?
>
> From what I can tell that is correct. Disabling runtime PM seems to
> stabilize things. I tested this over 10 reboots. I'll kick off my
> stress test script overnight just to see if this is 100% consistent.
>
> > >
> > > My points here are:
> > > 1. the commit 0d2135ecadb0 was suggested by FW team to W/A D3 potential crash issue.
> > > 2. it was verified with rt286(Broadwell.c, e.g. Dell XPS) from our side only(and may have been checked with rt5677 by Chrome team).
> > > 3. please follow sequence in broadwell.c if issue happen at boot time.
> > > If happened at runtime PM from DSP side, we should see it with all kinds of machine driver.
>
> I'm not really a sound guy; I've been picking this up as I go along.
> From what I've gathered it doesn't make sense to me why this is an
> issue on buddy, but not other bdw platforms, such as samus. If I
> understand correctly they both have the same DSP and use the same
> runtime suspend/resume code. What makes this fail with the 5650 and
> not the 5677 is the million dollar question.
>
> > > Could you performing more test and debugging to see what it real happen there?
>
> Yes, I'll continue poking at this. The debugging that got me this far
> basically just involved placing traces on the sst_shim32_write/read
> functions and looking at the diff from my best working reference,
> which is our cros-kernel-3.14 branch. This is what lead me to
> reverting 0d2135ecadb0, as it produced effectively identical traces as
> I was seeing in 3.14.
>
> > > 4. we have no reason to remove the commit directly, except correcting if some lines are proved wrong. And, as Pierre mentioned, SOF driver is preferred, as there is no new development effort to support SST haswell/Broadwell driver here(no platform, no developer, :-( ).
>
> I'm not suggesting removing the commit, merely observing that
> reverting it seems to fix the problem.
>
> > >
> > > Thanks,
> > > ~Keyon>
> >
> > Got to disagree with the last one - no platform, no developer.
> > We are setting up some BDW/ HSW here to join our happy SKL+ family in
> > CI. This is because of /common cleanups which will engulf aDSP project
> > (hsw/byt) obviously.
> >
> > These will be tested against the exact same BAT scope as other ADSP
> > devices. Code here looks much better, at least compared to /skylake -
> > ain't a high threshold though.. Given how outdated all SKL+ fw binaries
> > are (on upstream repo) it might even come down simply to fw upgrade.
> > Most of FW peps who took part in that project are already out. Although,
> > found one or two who are willing to help : )
> >
> > And yes, I'm setting them up with rt286 too. There are some rt56XX but
> > I'm unsure if rt5650 is amount them.
> > Still got some problems with ACPI, but soon two new faces should be
> > greeting audio CI bonfire..
> >
> > Czarek
> >
>
> I can continue to work at this to see if I can make any more headway.
> Unfortunately without a solid intuitive understanding of the system,
> or insight into the DSP, I'm limited to looking at traces and git
> history for the most part.
>
> Curtis: Do you think it makes sense to poke at samus and see if there
> are any differences in the suspend/resume process, or are they pretty
> much guaranteed to be identical?
>
My recommendation would be to look at the machine driver and see if
its making additional calls to the DSP driver that is not made in
other machine drivers such as the bdw-rt5677 (Samus.) That might
indicate an additional code path that might be getting exercised in
your context that isn't used in samus which is causing your problems.
If you find something you can always copy it over to samus to see if
it causes the same breakage. So yes definitely look. Usually the
suspend/resume paths aren't that long, but I would search the whole
machine driver for anything that can alter state.
> Thanks for all your help on this.
>
> - Jon
>
> > >>>
> > >>> Are you using the latest upstream firmware btw? Or the one which
> > >>> shipped with the initial device (which could be an issue if the protocol
> > >> changed).
> > >>
> > >> The firmware I'm loading is: `FW info: type 01, - version: 00.00, build 77,
> > >> source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a1`.
> > >> Hashes the same as the upstream binary.
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
