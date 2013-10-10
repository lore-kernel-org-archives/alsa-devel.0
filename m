From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mic Boost channel is unused
Date: Thu, 10 Oct 2013 15:33:07 +0200
Message-ID: <5256AC93.6050400@canonical.com>
References: <5231E348.8020204@gnat.ca> <52333782.9070402@gnat.ca>
 <5233AEFC.8000907@canonical.com> <5237204A.7040602@gnat.ca>
 <52377EDC.6040105@canonical.com> <5255B2A8.6060507@gnat.ca>
 <5255B550.6070001@gnat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 34FF82655A9
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 15:33:08 +0200 (CEST)
In-Reply-To: <5255B550.6070001@gnat.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nathanael D. Noblet" <nathanael@gnat.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/09/2013 09:58 PM, Nathanael D. Noblet wrote:
> On 10/09/2013 01:46 PM, Nathanael D. Noblet wrote:
>> On 09/16/2013 03:57 PM, David Henningsson wrote:
>>> Matching this with your alsa-info, we can see that 'Mic Jack'
>>> corresponds to 0x1b and 'Mic Jack', index=1 corresponds to 0x1a.
>>>
>>> Hence you could try turning pin 0x1a to "not connected" in
>>> hda-jack-retask. (I don't know how/if hda-jack-retask is packaged in
>>> Fedora, but it is part of alsa-tools.)
>>>
>>> If this resolves your problem, we could then try making that the default
>>> in upcoming kernels, but the question is we really dare to do that,
>>> without clear confirmation that 0x1a is actually useless. In current
>>> state it's a bit buggy, but if the headphone jack is actually a headset
>>> jack turning that off would make the headset mic go from "needs manual
>>> adjustment to work" to "completely unusuable".
>>
>> So that adjustment allows the internal microphone to be useable. However
>> the mic in jack is now completely unusable. With a headset or a plain
>> microphone.
>>
>> Thoughts?
> 
> 
> Actually I was wrong. I plugged it into the wrong jack. With that retask
> everything seems to work now. Plugging in a microphone into the mic jack
> picks up that audio, unplugging it uses the built in mic. So that's
> good. What's the next step?

Ok, so I made a patch (just sent it) that properly names the headset mic
as such, so we don't end up with "Mic" and "Mic 1" but "Mic" and
"Headset Mic" instead.

It is a step in the right direction and I encourage you to test it - but
it does not solve the more difficult problem with the parser: that all
three inputs go through node 0x17, and that node gets a control "xxx
Boost" that's named after one of them, without indication that it
actually controls boost for all three of them.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
