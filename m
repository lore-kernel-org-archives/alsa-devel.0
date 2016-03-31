From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Getting rid of inside_vm in intel8x0
Date: Fri, 1 Apr 2016 00:26:18 +0200
Message-ID: <20160331222618.GE1990@wotan.suse.de>
References: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
 <s5h60w48po7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h60w48po7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Stephen Hemminger <stephen@networkplumber.org>, Jim Gettys <jg@freedesktop.org>, Dario Faggioli <dario.faggioli@citrix.com>, George.Dunlap@eu.citrix.com, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Konstantin Ozerkov <kozerkov@parallels.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>, Matt Fleming <matt@codeblueprint.co.uk>, Borislav Petkov <bp@alien8.de>, xen-devel <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2016 at 08:07:04AM +0200, Takashi Iwai wrote:
> On Tue, 29 Mar 2016 23:37:32 +0200,
> Andy Lutomirski wrote:
> > 
> > Would it be possible to revert:
> > 
> > commit 228cf79376f13b98f2e1ac10586311312757675c
> > Author: Konstantin Ozerkov <kozerkov@parallels.com>
> > Date:   Wed Oct 26 19:11:01 2011 +0400
> > 
> >     ALSA: intel8x0: Improve performance in virtual environment
> > 
> > Presumably one or more of the following is true:
> > 
> > a) The inside_vm == true case is just an optimization and should apply
> > unconditionally.
> > 
> > b) The inside_vm == true case is incorrect and should be fixed or disabled.
> > 
> > c) The inside_vm == true case is a special case that makes sense then
> > IO is very very slow but doesn't make sense when IO is fast.  If so,
> > why not literally measure the time that the IO takes and switch over
> > to the "inside VM" path when IO is slow?

BTW can we simulate this on bare metal by throttling an IO bus, or
perhaps mucking with the scheduler ?

I ask as I wonder if similar type of optimization may be useful
to first simulate with other types of buses for other IO devices
we might use in virtualization environments. If so, I'd be curious
to know if similar type of optimizations might be possible for
other sounds cards, or other IO devices.

> More important condition is rather that the register updates of CIV
> and PICB are atomic.

To help with this can you perhaps elaborate a bit more on what the code
does? As I read it snd_intel8x0_pcm_pointer() gets a pointer to some
sort of audio frame we are in and uses two values to see if we are
going to be evaluating the right frame, we use an optimization of
some sort to skip one check for virtual environments. We seem to need
this given that on a virtual environment it is assumed that the sound
card is emulated, and as such an IO read there is rather expensive.

Can you confirm and/or elaborate a bit more what this does ?

To try to help understand what is going on can you describe what CIV
and PICB are exactly ?

> This is satisfied mostly only on VM, and can't
> be measured easily unlike the IO read speed.

Interesting, note the original patch claimed it was for KVM and
Parallels hypervisor only, but since the code uses:

+#if defined(__i386__) || defined(__x86_64__)
+               inside_vm = inside_vm || boot_cpu_has(X86_FEATURE_HYPERVISOR);
+#endif

This makes it apply also to Xen as well, this makes this hack more
broad, but does is it only applicable when an emulated device is
used ? What about if a hypervisor is used and PCI passthrough is
used ?

> > There are a pile of nonsensical "are we in a VM" checks of various
> > sorts scattered throughout the kernel, they're all a mess to maintain
> > (there are lots of kinds of VMs in the world, and Linux may not even
> > know it's a guest), and, in most cases, it appears that the correct
> > solution is to delete the checks.  I just removed a nasty one in the
> > x86_32 entry asm, and this one is written in C so it should be a piece
> > of cake :)
> 
> This cake looks sweet, but a worm is hidden behind the cream.
> The loop in the code itself is already a kludge for the buggy hardware
> where the inconsistent read happens not so often (only at the boundary
> and in a racy way).  It would be nice if we can have a more reliably
> way to know the hardware buggyness, but it's difficult,
> unsurprisingly.

The concern here is setting precedents for VM cases sprinkled in the kernel.
The assumption here is such special cases are really paper'ing over another
type of issue, so its best to ultimately try to root cause the issue in
a more generalized fashion.

Stephen Hemminger pointer out to me a while ago that the Linux scheduler 
really can't tell apart between latencies incurred for instance due to
network IO and say latencies incurred high computation. We also don't
have information to feed the scheduler to provide reasonable latency
guarantees. The same should apply to sound IO latency issues, however
this example seems to reveal very type-of-device specifics which are
used to make certain compromises. If the issue can be tied to discrepancies
on the scheduler in differentiating latencies incurred by IO or CPU bound
work loads, and certain compromises are indeed very device specific it
would make a generic solution perhaps really hard to address.

Virtual environments have another subtle issue, which I've been suspecting for
a while might get worse over time, and that is that in certain types of
virtualized environments you have to deal with at least (unless you are using
nested virtual environments) two schedulers, each making perhaps very different
decisions, and each perhaps perceiving different conditions, and reacting
perhaps at different times to the same exact event. In the networking world
where two different solutions in two separate layers worked trying to solve
a similar issue with different algorithms has now proven to have wreaked
havoc, its what we know as bufferbloat. Ignoring IO, if we just consider the
discrepancy on scheduler information between a guest on a hypervisor or
a bare metal box, we already know odd issues can occur on external situations
such large number of guest ramp up (say booting 100 guests) or dynamic
topology changes. To address these things there have been IMHO knee-jerk
reactions to the problem on hypervisors, for instance:

a) CPU pinning [0]
b) CPU affinity [0]
c) CPU pools [1]
d) NUMA aware scheduling [2]

[0] http://wiki.xen.org/wiki/Automatic_NUMA_Placement
[1] http://wiki.xen.org/wiki/Cpupools_Howto
[2] http://wiki.xen.org/wiki/Xen_4.3_NUMA_Aware_Scheduling

I have suspected these are just paper work-arounds over the real
issues... but I have no evidence to confirm this yet. If there
is a possibility that is true, the discrepancies on types of
latencies incurred by CPU bound or IO bound should exacerbate
this issue even further.

Would a real time scheduler provide any semantics / heuristics
to help with any of this ?

  Luis
