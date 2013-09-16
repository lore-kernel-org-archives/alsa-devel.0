From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mic Boost channel is unused
Date: Mon, 16 Sep 2013 23:57:48 +0200
Message-ID: <52377EDC.6040105@canonical.com>
References: <5231E348.8020204@gnat.ca> <52333782.9070402@gnat.ca>
 <5233AEFC.8000907@canonical.com> <5237204A.7040602@gnat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CA8265043
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 23:57:50 +0200 (CEST)
In-Reply-To: <5237204A.7040602@gnat.ca>
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

On 09/16/2013 05:14 PM, Nathanael D. Noblet wrote:
> On 09/13/2013 06:34 PM, David Henningsson wrote:
>>>>  >  2) The internal microphone requires that the mic boost channel be
>>>> something other than 0 to function properly.
>>>>
>>>> You have to find out whether node 0x1a or 0x1b can be used as the
>>>> headset
>>>> jack (headphone with Mic using TRRS connector)
>>>
>>> So basically I need to plug a microphone into each port and figure out
>>> if both of them work as microphone. A couple things.
>>>
>>> 1) What if both can be a microphone?
>>> 2) If only one can be a microphone, I have no idea how to tell you if
>>> its 0x1a or 0x1b.. hda-analyzer/alsa low level stuff is completely new
>>> to me.
>>
>> When you plug something in, you can look at the output of "amixer -D
>> hw:<cardname> contents" to see what, if anything switched to "values=on"
>> instead of "values=off".
>>
>> We would like you to plug a mic into the mic jack and see in what way
>> the output of "amixer -D hw:<cardname> contents" changes.
>> Then we would like you to plug a headset (with both headphone and mic,
>> like most smartphones have), and again see if there's a difference in
>> amixer.
>> You can also try this with a headphone only in the headphone jack, if
>> you like.
>>
> 
> So here's what I did. I didn't have a combo headphone/mic thing handy.
> 
> 1) nothing.out is the netbook with nothing external plugged in.
> 2) mic.out is when I plugged in a microphone into the mic jack
> 3) head.out is when there were headphones plugged into the headphone jack
> 4) both.out is when something was plugged into both (mic into mic and
> headphone into headphones...
> 
> A quick diff shows that amixer is seeing differences.
> --- nothing.out    2013-09-16 09:11:54.678168182 -0600
> +++ mic.out    2013-09-16 09:11:54.675168245 -0600
> @@ -6,7 +6,7 @@
>    : values=on
>  numid=18,iface=CARD,name='Mic Jack'
>    ; type=BOOLEAN,access=r-------,values=1
> -  : values=off
> +  : values=on
>  numid=20,iface=CARD,name='Mic Jack',index=1
>    ; type=BOOLEAN,access=r-------,values=1
>    : values=off
> 
> 
> Given this information... what's the next step?

Matching this with your alsa-info, we can see that 'Mic Jack'
corresponds to 0x1b and 'Mic Jack', index=1 corresponds to 0x1a.

Hence you could try turning pin 0x1a to "not connected" in
hda-jack-retask. (I don't know how/if hda-jack-retask is packaged in
Fedora, but it is part of alsa-tools.)

If this resolves your problem, we could then try making that the default
in upcoming kernels, but the question is we really dare to do that,
without clear confirmation that 0x1a is actually useless. In current
state it's a bit buggy, but if the headphone jack is actually a headset
jack turning that off would make the headset mic go from "needs manual
adjustment to work" to "completely unusuable".


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
