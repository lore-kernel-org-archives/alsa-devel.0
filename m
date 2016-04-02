From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Getting rid of inside_vm in intel8x0
Date: Sat, 2 Apr 2016 05:57:44 -0700
Message-ID: <CALCETrW6Og2_cNnmgMWkGhfFNdLyJjtojqn6_s+BfFCsdzzczg@mail.gmail.com>
References: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
 <s5h60w48po7.wl-tiwai@suse.de> <20160331222618.GE1990@wotan.suse.de>
 <s5hvb4151v1.wl-tiwai@suse.de> <20160401222831.GX1990@wotan.suse.de>
 <s5hwpog377v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AD7F260524
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 14:58:05 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id s79so9934015oie.1
 for <alsa-devel@alsa-project.org>; Sat, 02 Apr 2016 05:58:05 -0700 (PDT)
In-Reply-To: <s5hwpog377v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Konstantin Ozerkov <kozerkov@parallels.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, George.Dunlap@eu.citrix.com, Andrew Cooper <andrew.cooper3@citrix.com>, Dario Faggioli <dario.faggioli@citrix.com>, Jim Gettys <jg@freedesktop.org>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Matt Fleming <matt@codeblueprint.co.uk>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Borislav Petkov <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, xen-devel <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 1, 2016 at 10:33 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 02 Apr 2016 00:28:31 +0200,
> Luis R. Rodriguez wrote:
>> If the former, could a we somehow detect an emulated device other than through
>> this type of check ? Or could we *add* a capability of some sort to detect it
>> on the driver ? This would not address the removal, but it could mean finding a
>> way to address emulation issues.
>>
>> If its an IO issue -- exactly what is the causing the delays in IO ?
>
> Luis, there is no problem about emulation itself.  It's rather an
> optimization to lighten the host side load, as I/O access on a VM is
> much heavier.
>
>> > > > This is satisfied mostly only on VM, and can't
>> > > > be measured easily unlike the IO read speed.
>> > >
>> > > Interesting, note the original patch claimed it was for KVM and
>> > > Parallels hypervisor only, but since the code uses:
>> > >
>> > > +#if defined(__i386__) || defined(__x86_64__)
>> > > +               inside_vm = inside_vm || boot_cpu_has(X86_FEATURE_HYPERVISOR);
>> > > +#endif
>> > >
>> > > This makes it apply also to Xen as well, this makes this hack more
>> > > broad, but does is it only applicable when an emulated device is
>> > > used ? What about if a hypervisor is used and PCI passthrough is
>> > > used ?
>> >
>> > A good question.  Xen was added there at the time from positive
>> > results by quick tests, but it might show an issue if it's running on
>> > a very old chip with PCI passthrough.  But I'm not sure whether PCI
>> > passthrough would work on such old chipsets at all.
>>
>> If it did have an issue then that would have to be special cased, that
>> is the module parameter would not need to be enabled for such type of
>> systems, and heuristics would be needed. As you note, fortunately this
>> may not be common though...
>
> Actually this *is* module parametered.  If set to a boolean value, it
> can be applied / skipped forcibly.  So, if there has been a problem on
> Xen, this should have been reported.  That's why I wrote it's no
> common case.  This comes from the real experience.
>
>> but if this type of work around may be
>> taken as a precedent to enable other types of hacks in other drivers
>> I'm very fearful of more hacks later needing these considerations as
>> well.
>>
>> > > > > There are a pile of nonsensical "are we in a VM" checks of various
>> > > > > sorts scattered throughout the kernel, they're all a mess to maintain
>> > > > > (there are lots of kinds of VMs in the world, and Linux may not even
>> > > > > know it's a guest), and, in most cases, it appears that the correct
>> > > > > solution is to delete the checks.  I just removed a nasty one in the
>> > > > > x86_32 entry asm, and this one is written in C so it should be a piece
>> > > > > of cake :)
>> > > >
>> > > > This cake looks sweet, but a worm is hidden behind the cream.
>> > > > The loop in the code itself is already a kludge for the buggy hardware
>> > > > where the inconsistent read happens not so often (only at the boundary
>> > > > and in a racy way).  It would be nice if we can have a more reliably
>> > > > way to know the hardware buggyness, but it's difficult,
>> > > > unsurprisingly.
>> > >
>> > > The concern here is setting precedents for VM cases sprinkled in the kernel.
>> > > The assumption here is such special cases are really paper'ing over another
>> > > type of issue, so its best to ultimately try to root cause the issue in
>> > > a more generalized fashion.
>> >
>> > Well, it's rather bare metal that shows the buggy behavior, thus we
>> > need to paper over it.   In that sense, it's other way round; we don't
>> > tune for VM.  The VM check we're discussing is rather for skipping the
>> > strange workaround.
>>
>> What is it exactly about a VM that enables this work around to be skipped?
>> I don't quite get it yet.
>
> VM -- at least the full one with the sound hardware emulation --
> doesn't have the hardware bug.  So, the check isn't needed.

Here's the issue, though: asking "am I in a VM" is not a good way to
learn properties of hardware.  Just off the top of my head, here are
some types of VM and what they might imply about hardware:

Intel Kernel Guard: your sound card is passed through from real hardware.

Xen: could go either way.  In dom0, it's likely passed through.  In
domU, it could be passed through or emulated, and I believe this is
the case for all of the Xen variants.

KVM: Probably emulated, but could be passed through.

I think the main reason that Luis and I are both uncomfortable with
"am I in a VM" checks is that they're rarely the right thing to be
detecting, the APIs are poorly designed, and most of the use cases in
the kernel are using them as a proxy for something else and would be
clearer and more future proof if they tested what they actually need
to test more directly.

>
>> > You may ask whether we can reduce the whole workaround instead.  It's
>> > practically impossible.  We don't know which models doing so and which
>> > not.  And, the hardware in question are (literally) thousands of
>> > variants of damn old PC mobos.  Any fundamental change needs to be
>> > verified on all these machines...
>>
>> What if we can come up with algorithm on the ring buffer that would
>> satisfy both cases without special casing it ? Is removing this VM
>> check impossible really?
>
> Yes, it's impossible practically, see my comment above.
> Whatever you change, you need to verify it on real machines.  And it's
> very difficult to achieve.

But, given what I think you're saying, you only need to test one way:
if the non-VM code works and is just slow on a VM, then wouldn't it be
okay if there were some heuristic that were always right on bare metal
and mostly right on a VM?

Anyway, I still don't see what's wrong with just measuring how long an
iteration of your loop takes.  Sure, on both bare metal and on a VM,
there are all kinds of timing errors due to SMI and such, but I don't
think it's true at all that hypervisors will show you only guest time.
The sound drivers don't run early in boot -- they run when full kernel
functionality is available.  Both the ktime_* APIs and
CLOCK_MONTONIC_RAW should give actual physical elapsed time.  After
all, if they didn't, then simply reading the clock in a VM guest would
be completely broken.

In other words, a simple heuristic could be that, if each of the first
four iterations takes >100 microseconds (or whatever the actual number
is that starts causing real problems on a VM), then switch to the VM
variant.  After all, if you run on native hardware that's so slow that
your loop will just time out, then you don't gain anything by actually
letting it time out, and, if you're on a VM that's so fast that it
doesn't matter, then it shouldn't matter what you do.

--Andy


-- 
Andy Lutomirski
AMA Capital Management, LLC
