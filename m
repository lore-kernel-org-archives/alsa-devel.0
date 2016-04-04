From: George Dunlap <george.dunlap@citrix.com>
Subject: Re: Getting rid of inside_vm in intel8x0
Date: Mon, 4 Apr 2016 10:05:43 +0100
Message-ID: <57022E67.7050907@citrix.com>
References: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
 <s5h60w48po7.wl-tiwai@suse.de> <20160331222618.GE1990@wotan.suse.de>
 <s5hvb4151v1.wl-tiwai@suse.de> <20160401222831.GX1990@wotan.suse.de>
 <s5hwpog377v.wl-tiwai@suse.de>
 <CALCETrW6Og2_cNnmgMWkGhfFNdLyJjtojqn6_s+BfFCsdzzczg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrW6Og2_cNnmgMWkGhfFNdLyJjtojqn6_s+BfFCsdzzczg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, Takashi Iwai <tiwai@suse.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Stephen Hemminger <stephen@networkplumber.org>, Jim Gettys <jg@freedesktop.org>, Dario Faggioli <dario.faggioli@citrix.com>, George.Dunlap@eu.citrix.com, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Konstantin Ozerkov <kozerkov@parallels.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>, Matt Fleming <matt@codeblueprint.co.uk>, Borislav Petkov <bp@alien8.de>, xen-devel <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>
List-Id: alsa-devel@alsa-project.org

On 02/04/16 13:57, Andy Lutomirski wrote:
> On Fri, Apr 1, 2016 at 10:33 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Sat, 02 Apr 2016 00:28:31 +0200,
>> Luis R. Rodriguez wrote:
>>> If the former, could a we somehow detect an emulated device other than through
>>> this type of check ? Or could we *add* a capability of some sort to detect it
>>> on the driver ? This would not address the removal, but it could mean finding a
>>> way to address emulation issues.
>>>
>>> If its an IO issue -- exactly what is the causing the delays in IO ?
>>
>> Luis, there is no problem about emulation itself.  It's rather an
>> optimization to lighten the host side load, as I/O access on a VM is
>> much heavier.
>>
>>>>>> This is satisfied mostly only on VM, and can't
>>>>>> be measured easily unlike the IO read speed.
>>>>>
>>>>> Interesting, note the original patch claimed it was for KVM and
>>>>> Parallels hypervisor only, but since the code uses:
>>>>>
>>>>> +#if defined(__i386__) || defined(__x86_64__)
>>>>> +               inside_vm = inside_vm || boot_cpu_has(X86_FEATURE_HYPERVISOR);
>>>>> +#endif
>>>>>
>>>>> This makes it apply also to Xen as well, this makes this hack more
>>>>> broad, but does is it only applicable when an emulated device is
>>>>> used ? What about if a hypervisor is used and PCI passthrough is
>>>>> used ?
>>>>
>>>> A good question.  Xen was added there at the time from positive
>>>> results by quick tests, but it might show an issue if it's running on
>>>> a very old chip with PCI passthrough.  But I'm not sure whether PCI
>>>> passthrough would work on such old chipsets at all.
>>>
>>> If it did have an issue then that would have to be special cased, that
>>> is the module parameter would not need to be enabled for such type of
>>> systems, and heuristics would be needed. As you note, fortunately this
>>> may not be common though...
>>
>> Actually this *is* module parametered.  If set to a boolean value, it
>> can be applied / skipped forcibly.  So, if there has been a problem on
>> Xen, this should have been reported.  That's why I wrote it's no
>> common case.  This comes from the real experience.
>>
>>> but if this type of work around may be
>>> taken as a precedent to enable other types of hacks in other drivers
>>> I'm very fearful of more hacks later needing these considerations as
>>> well.
>>>
>>>>>>> There are a pile of nonsensical "are we in a VM" checks of various
>>>>>>> sorts scattered throughout the kernel, they're all a mess to maintain
>>>>>>> (there are lots of kinds of VMs in the world, and Linux may not even
>>>>>>> know it's a guest), and, in most cases, it appears that the correct
>>>>>>> solution is to delete the checks.  I just removed a nasty one in the
>>>>>>> x86_32 entry asm, and this one is written in C so it should be a piece
>>>>>>> of cake :)
>>>>>>
>>>>>> This cake looks sweet, but a worm is hidden behind the cream.
>>>>>> The loop in the code itself is already a kludge for the buggy hardware
>>>>>> where the inconsistent read happens not so often (only at the boundary
>>>>>> and in a racy way).  It would be nice if we can have a more reliably
>>>>>> way to know the hardware buggyness, but it's difficult,
>>>>>> unsurprisingly.
>>>>>
>>>>> The concern here is setting precedents for VM cases sprinkled in the kernel.
>>>>> The assumption here is such special cases are really paper'ing over another
>>>>> type of issue, so its best to ultimately try to root cause the issue in
>>>>> a more generalized fashion.
>>>>
>>>> Well, it's rather bare metal that shows the buggy behavior, thus we
>>>> need to paper over it.   In that sense, it's other way round; we don't
>>>> tune for VM.  The VM check we're discussing is rather for skipping the
>>>> strange workaround.
>>>
>>> What is it exactly about a VM that enables this work around to be skipped?
>>> I don't quite get it yet.
>>
>> VM -- at least the full one with the sound hardware emulation --
>> doesn't have the hardware bug.  So, the check isn't needed.
> 
> Here's the issue, though: asking "am I in a VM" is not a good way to
> learn properties of hardware.  Just off the top of my head, here are
> some types of VM and what they might imply about hardware:
> 
> Intel Kernel Guard: your sound card is passed through from real hardware.
> 
> Xen: could go either way.  In dom0, it's likely passed through.  In
> domU, it could be passed through or emulated, and I believe this is
> the case for all of the Xen variants.
> 
> KVM: Probably emulated, but could be passed through.

I'm not sure exactly why I was CC'd into this thread, but this is an
important point -- even if you're running in a VM, you may actually have
direct un-emulated IO access to a real (buggy) piece of hardware; in
which case it sounds like you still need the work-around.  So
boot_cpu_has(X86_FEATURE_HYPERVISOR) is probably not the right check.

 -George
