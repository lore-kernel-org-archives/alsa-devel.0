From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Fri, 30 Nov 2012 09:46:29 +0100
Message-ID: <50B87265.60509@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
 <50B7FED7.4030900@canonical.com> <s5ha9tz4j6z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C4283261620
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:46:30 +0100 (CET)
In-Reply-To: <s5ha9tz4j6z.wl%tiwai@suse.de>
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

On 11/30/2012 08:57 AM, Takashi Iwai wrote:
> At Fri, 30 Nov 2012 01:33:27 +0100,
> David Henningsson wrote:
>>
>> On 11/29/2012 04:21 PM, Takashi Iwai wrote:
>>> HP Z220 with ALC221 codec has a front jack that should work as both
>>> the front mic and the secondary headphone.  This patch adds a new
>>> mixer enum to change the jack behavior.
>>
>> Hmm, in principle I don't like this hack.
>
> I don't like either, but there was some demand for such feature...

Heh, that was not too surprising :-)

>> In many machines, both front
>> jacks could probably work as anything (line in, line out, headphones,
>> mic, etc), and that goes for many pins on many machines, and we would
>> end up with a ton of ALSA kcontrols and an incredibly complex parsing
>> machine.
>
> Actually we can (or should) add "xxx Jack Mode" enum to every jack in
> future.  See below.
>
>> I would recommend a user to use hda-jack-retask in these cases, instead
>> of cluttering the kernel code.
>
> Well, hda-jack-retask is a nice debugging tool, but it's not intended
> for the actual user interface for daily use.

Maybe we should consider making the reconfiguration more lightweight in 
the kernel then, so that hda-jack-retask (or a more simplistic GUI) can 
be used for daily use?

> Also, a big missing
> piece is the automatic retasking via jack detection as a headphone.

Through impedance sensing? Does the ALC221 support that?

>> If you insist though, a slightly more consistent mechanism would be to
>> use the same approach as we did with the single 3-pin jacks (on some
>> Asus machines, IIRC), where selecting the Capture/Input Source would
>> retask the pin, instead of adding a separate "Jack Mode" switch.
>
> I thought of that, too.  OTOH, "xx Jack Mode" enum is already present
> for IDT codecs over years.  This isn't used for configuring the I/O
> direction of jacks but choosing bias levels.  Why not applying the
> same logic for I/O direction switch?

This might work for this particular case, but sounds like it could 
become a confusing set of alsa-mixer controls (and hairy kernel code to 
control them all!) - e g, what if two jacks that currently are not 
headphones both want to be headphones, and they have independent volume 
controls? Which one will be controlled by "Headphone Volume"?

As an example of current code that I have trouble understanding and 
fixing bugs in, is the badness calculation feature. This sounds like it 
could be even worse.

> Windows have capabilities to tune each jack as well.  This is a
> long-standing TODO, and I think "* Jack Mode" enum is the natural way
> to implement it.  (How to let user setting it is another question.
> I can imagine that PA could ask user once when a jack is detected.)

Yes, some kind of "advanced" tab in the sound settings where things can 
be reconfigured would be nice.

> About your alternative proposal: the problem by extending the input
> source selection is that this jack is supposed to be a front mic jack
> as default.  So, this is always listed in the capture source imux.

Well, if the "Capture Source" switches to "Rear Line In", then it does 
not hurt if we retask the front to headphone automatically.
But if you're going to implement auto-switching based on impedance 
sensing, this alternative proposal might fail anyway?

>> Also, the jack detection won't work well with PulseAudio, if I read the
>> code correctly PulseAudio will think a front mic has been inserted
>> regardless of the mode. You have been warned :-)
>
> Yeah, it's a concern.  Currently it's no issue because no capture
> source enum is exposed, so PA can't do anything wrong.

If PA detects the "Front Mic Jack" kcontrol to be plugged in, and I 
implement the priority order as I suggested in the other comment, we 
have now disabled the rear line in because the user plugged in a 
headphone in the front mic jack.

> But if we
> expose the capture source, it may conflict.  One way to avoid it is to
> make the capture source inactive on the fly in auto mic mode.
> The question is how robust PA is, whether it's screwed up by such a
> change...

I don't know either...I mean, there is no dynamic reconfiguration, but 
whether it will crash or just simply ignore that it can't set the 
capture source I don't know. Try and see :-)

Btw, I was trying to figure out what PulseAudio version you're actually 
using for your enablement. I guess it's 0.9.23? [1]

>> Now; if you have a very strong reason why this machine would need this
>> special retask mechanism and all other machines don't, I'm willing to
>> listen...
>
> A strong reason for adding the feature to this machine is that this
> has a print on the top of the front mic jack indicating it's a shared
> front-mic / headphone jack.  Thus it must behave as advertised.  This
> is user's expectation.
>
> If other machines have such a print, the similar method should be
> implemented, too.

Yeah, that's a reasonable point.

But still I think the method of creating more and more Jack Mode 
controls will lead to more long term maintenance problems (as the kernel 
code complexity increases), compared to implementing a more lightweight 
reconfiguration mechanism.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] 
https://www.suse.com/LinuxPackages/packageRouter.jsp?product=desktop&version=11&service_pack=sp2&architecture=i386&package_name=index_all
