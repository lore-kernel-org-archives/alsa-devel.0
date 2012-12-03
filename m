From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Mon, 03 Dec 2012 15:47:20 +0100
Message-ID: <50BCBB78.2030703@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
 <50B7FED7.4030900@canonical.com> <s5ha9tz4j6z.wl%tiwai@suse.de>
 <50B87265.60509@canonical.com> <s5h4nk74egt.wl%tiwai@suse.de>
 <50BCAC89.7070400@canonical.com> <s5hr4n7z0sv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D62261641
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 15:47:21 +0100 (CET)
In-Reply-To: <s5hr4n7z0sv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/03/2012 03:07 PM, Takashi Iwai wrote:
> At Mon, 03 Dec 2012 14:43:37 +0100,
> David Henningsson wrote:
>>
>> On 11/30/2012 10:39 AM, Takashi Iwai wrote:
>>> At Fri, 30 Nov 2012 09:46:29 +0100,
>>> David Henningsson wrote:
>>>>
>>>> On 11/30/2012 08:57 AM, Takashi Iwai wrote:
>>>>> At Fri, 30 Nov 2012 01:33:27 +0100,
>>>>> David Henningsson wrote:
>>>>>> I would recommend a user to use hda-jack-retask in these cases, instead
>>>>>> of cluttering the kernel code.
>>>>>
>>>>> Well, hda-jack-retask is a nice debugging tool, but it's not intended
>>>>> for the actual user interface for daily use.
>>>>
>>>> Maybe we should consider making the reconfiguration more lightweight in
>>>> the kernel then, so that hda-jack-retask (or a more simplistic GUI) can
>>>> be used for daily use?
>>>
>>> I don't think any tool accessing hwdep to fiddle with the codec verb
>>> isn't suitable for normal usage.  For any normal usage, the only
>>> access is via control API.
>>
>> Trying to summarise this long thread, we seem to advocate these two
>> options as I see it:
>>
>> 1) Use the hwdep interface:
>>
>> Pro: Simplest kernel code
>>
>> Pro: Can support more options, higher degree of freedom for user
>>
>> Con: Any reconfiguration is a bit disturbing and can e g break currently
>> running audio streams.
>>
>> Con: (Currently) requires root privileges to change, since it works
>> through the hwdep interface.
>
> Con: how can you ensure the exclusive setup and the exclusive access?
> Imagine multiple sessions are using different configurations.
>
> Con: how would you manage the mixer elements from hwdep at all?
> There are independent mixer applications.
>
>> 2) Base reconfiguration on jack-mode controls
>>
>> Pro: Simpler for user to reconfigure jacks
>>
>> Con: More complex kernel code than first option
>>
>> Con: It might be difficult to get the volume/switch control names right
>> in all scenarios.
>>
>> Con: Needs work in PulseAudios and GUIs to support jack retasking
>> better, or it will be either unsupported (for the average user) or
>> confusing.
>
> Hmm...  I don't get it.  How can hda-jack-retask or whatever be a
> better option than PA?  The integration work for PA is more or less
> necessary.  Launching another application may be more confusion for
> user, no?

The integration work for PA in hda-jack-retask is such that 
hda-jack-retask kills PA before making a change (to avoid EBUSY and to 
make PA adjust to the new config).

But anyway. I agree that if we get a good mixer/kcontrol interface, the 
second solution has the advantage of an existing infrastructure for 
saving and restoring volumes between sessions, and support for different 
mixer application will already be in place.

>> Also; since the parsing code is still separate between codecs, we have
>> to implement all of this complexity over and over again...
>
> It's "still".  They will be merged sooner or later, anyway.

I believe that when I see it - surprise me :-)

>> Probably we can sort out most stuff with option 2) too, I mean, with the
>> capture source, automute and autoswitch, rerouting paths, repurposing
>> DACs, and all that, but the question is really, should we? Are we
>> willing to take the cost of the added complexity that comes with it? Are
>> we be able to get it right, or do we get several broken kernel versions
>> before we get something that works really well?
>
> I don't think it'll be too complex in the end.  We'll be reducing the
> code while merging such a new feature, especially by unifying the
> codes from multiple drivers.  Once after this gets done, the driver
> will cover all needed demands for IDT, Conexant, Cirrus and VIA, and
> most of AD and C-Media codecs.  Let's see.
>
>
>>>>> Also, a big missing
>>>>> piece is the automatic retasking via jack detection as a headphone.
>>>>
>>>> Through impedance sensing? Does the ALC221 support that?
>>>
>>> No.  Otherwise it'd be easier :)
>>
>> Ok, so what do you mean with "automatic"?
>
> Sorry, it wasn't automatic "retasking" but muting.

Ok, that makes sense.

>
>
>>>>> Windows have capabilities to tune each jack as well.  This is a
>>>>> long-standing TODO, and I think "* Jack Mode" enum is the natural way
>>>>> to implement it.  (How to let user setting it is another question.
>>>>> I can imagine that PA could ask user once when a jack is detected.)
>>
>> Btw, how "disturbing" is it when you retask jacks on Windows? What
>> happens e g if you try to retask a jack you're currently outputting
>> audio to?
>
> I don't know exactly, too.
>
>
>>>>> But if we
>>>>> expose the capture source, it may conflict.  One way to avoid it is to
>>>>> make the capture source inactive on the fly in auto mic mode.
>>>>> The question is how robust PA is, whether it's screwed up by such a
>>>>> change...
>>>>
>>>> I don't know either...I mean, there is no dynamic reconfiguration, but
>>>> whether it will crash or just simply ignore that it can't set the
>>>> capture source I don't know. Try and see :-)
>>>>
>>>> Btw, I was trying to figure out what PulseAudio version you're actually
>>>> using for your enablement. I guess it's 0.9.23? [1]
>>>
>>> Yeah, the primary requirement is that one, but I've been checking also
>>> with 2.0 and 2.1.
>>
>> How important is it for you to actually get support for this stuff in
>> PulseAudio? I mean, you're certainly more than capable of adding
>> kcontrols, but I've never seen you - or anyone else from your team -
>> submitting patches against PulseAudio to have support for these things
>> all the way through to the user.
>
> Honestly, I don't care at this moment at all.  A part of the reason is
> that I don't use PulseAudio on my machines.
>
> But for normal users, PA support would be a really "good to have".

Right, but you begin this thread by saying you didn't like the patch, 
but there was "demand for such feature". Doesn't the 
person/boss/customer/etc who demanded that feature care about it being 
accessible to the "normal users"?

>>>> But still I think the method of creating more and more Jack Mode
>>>> controls will lead to more long term maintenance problems (as the kernel
>>>> code complexity increases), compared to implementing a more lightweight
>>>> reconfiguration mechanism.
>>>
>>> I don't think jack mode control itself would be too messy.  From the
>>> top view, it provides either bias level and possibly I/O switch that
>>> makes this jack hooking to the existing output route.  Thus, this
>>> doesn't disturb others.
>>>
>>> Of course, your concern is about the combination of auto-mic and jack
>>> mode enums.  That can be more different.
>>
>> As an example. Say that we have three DACs with amp-outs. In standard
>> configuration the first DAC's volume control is called "Speaker Volume"
>> and the second DAC's volume is called "Headphone Volume". Suddenly you
>> get a Jack Mode switch or multi-I/O switch, so that the three DACs now
>> go to "Front", "C/LFE" and "Rear". The headphone must then be rerouted
>> to the first DAC. But what happens to the volume controls now?
>
> No.  This doesn't happen.
>
> The additional output via jack mode enum is just a hook to the
> existing I/O topology.  It can hook to "Headphone" volume as a
> secondary headphone, but nothing else.  If it can't to hook the
> headphone volume, no option will be provided.
>
> If more drastic change is needed, user has to reconfigure the whole
> topology by setting the initial pin configs.
>
>
>>> Instead of my previous patches, we can start of implementing jack mode
>>> enums at first.  This allows the implementation of a lightweight jack
>>> retasking in user-space.  Again, these enum controls won't provide the
>>> all possible retasking.  They provide only cases where no drastic
>>> topology change is needed.  This will serve most of user's demands, I
>>> guess.  If not, user needs to create a better initial configuration
>>> for own demands.
>>
>> What if there suddenly is "demand for such feature" for something that
>> *does* change the topology a lot?
>
> Again, it doesn't change the topology.  If it needs to change the
> topology, it's not what we support in the mixer API.
> This needs reconfiguration, thus it essentially needs to restart the
> whole driver functionality.

Yes, this time around. But what about the next time there is a "demand 
for such feature" on a codec which has a different graph? Then you might 
not be so lucky that you can handle the same retasking without changing 
topology. That's the scenario I was wondering about.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
