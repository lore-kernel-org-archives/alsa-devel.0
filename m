From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek ACL892: audio gap ~ each 10 seconds?
	[SOLVED]
Date: Fri, 11 May 2012 06:45:30 -0700
Message-ID: <4FAD17FA.3060904@canonical.com>
References: <jnue8p$8li$1@dough.gmane.org> <jo53ht$j45$2@dough.gmane.org>
	<jobd2a$bj$1@dough.gmane.org> <johqka$tn$1@dough.gmane.org>
	<s5hehqruvh9.wl%tiwai@suse.de>
	<4facb947.541b340a.08eb.130c@mx.google.com>
	<s5hy5oztb63.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id E5F552442F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 15:45:35 +0200 (CEST)
In-Reply-To: <s5hy5oztb63.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
List-Id: alsa-devel@alsa-project.org

2012-05-11 00:43, Takashi Iwai skrev:
> At Fri, 11 May 2012 04:01:23 -0300,
> D=E2niel Fraga wrote:
>> On Fri, 11 May 2012 07:39:46 +0200
>> Takashi Iwai<tiwai@suse.de>  wrote:
>>
>>> Ah, it's the case...  Yes, some mobos are badly designed not to handle
>>> the jack detection properly.
>>>
>>> Did the auto-mute actually work on your machine?  If not, we can
>>> blacklist the device.  Please give alsa-info.sh output.
>> 	Hi Takashi! Disabling the auto-mute solved the issue. Regarding
>> your question: in fact, I don't know why auto-mute was enabled, because
>> I never use a headphone.
> It's a driver feature that is enabled as default, no matter whether
> you use or not :)
>
>> So I can't test it.
> Does it mean that you have no headphone, or does the machine have no
> headphone jack?
>
>> But you can be sure that
>> with this motherboard (Asus P8Z68-V Pro/gen3) there's this "pop and
>> click" problem when Auto-mute is enabled.
> That's why I'm asking to test.  Usually when such a noise occurs due
> to the auto-mute feature, it's because the bogus unsolicited events
> are fired up too much although no jack is plugged actually.  Thus
> usually the auto-mute feature itself doesn't work in such a case
> (either no hardware implementation or the hardware has its own
>   switching mechanism.)

In the long term, I think we should filter out short jack sense events. =

That is, when we get an unsol jack event, check the current status and =

set a timer for 200 ms.
200 ms later, in the timer callback, we would only accept the jack sense =

event as valid (and do automute/autoswitch/kcontrol update) if
  - The current status is the same as 200 ms earlier
  - If there has not been more unsol events in the mean time

Question is whether to do this by default, or only for devices we know =

are flickering.

I haven't seen this a lot, but the few I have seen have had times with =

the wrong state below 100 ms, so I think 200 ms could be a good value to =

start with.

-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
