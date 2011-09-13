From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 0/3] Fallback mechanism for pulse plugin
Date: Tue, 13 Sep 2011 13:38:54 +0100
Message-ID: <4E6F4EDE.9080805@colin.guthr.ie>
References: <s5hk4b5w7aq.wl%tiwai@suse.de> <4E624761.5000305@colin.guthr.ie>
	<s5hipoy89ss.wl%tiwai@suse.de> <4E6DC6DB.7080204@colin.guthr.ie>
	<s5hbouq868a.wl%tiwai@suse.de> <4E6E51FF.9070508@colin.guthr.ie>
	<s5hty8gvpuz.wl%tiwai@suse.de> <4E6F188A.1040404@colin.guthr.ie>
	<s5hk49cvkhw.wl%tiwai@suse.de> <4E6F37C4.5090704@colin.guthr.ie>
	<s5h62kwvdom.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id C68B024159
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 14:39:01 +0200 (CEST)
In-Reply-To: <s5h62kwvdom.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 13/09/11 13:18 did gyre and gimble:

>>>> We have to deal with the "fallout" when it is
>>>> present. i.e. the 2a).
>>>
>>> The case 2a is that user needs manual adjustment anyway.  If XDG is
>>> used, the adjustment is unavoidable.  So, the only sane solution for
>>> this is a static configuration.
>>
>> I disagree. The fact that XDG doesn't work should be totally irrelevant.
>> Any solution that works by virtue of XDG not working is fundamentally
>> broken.
> 
> Err, sorry, you are screwing up the argument.
> Both 2a and 2b are cases where user don't want PA.  It's the
> assumption.  The only difference is that 2a is with XDG while 2b is
> without XDG.

OK, so perhaps 2a and 2b are cases where the user doesn't want to use
PA, but then there are corresponding cases where the user *does* want to
use PA. I need the 2b case where the user does want to use PA to work
smoothly and with your current approach it does not.

I'm trying to consider all cases, both with and without PA running and
both with and without PA being desired. I wasn't clear in the previous
point tho', so I apologise.

> The case without XDG but user wants PA would be (if any) case 1b.
> And obviously the current fallback doesn't fit with this, of course. 

Yeah, sorry I probably should have reworded things to related it to 1b
instead. Sorry. As you say the principle is still valid tho'.


>> I thought that too, but after your last make I realise it's not. If
>> mplayer uses it's native PA output, then it will autospawn the PA daemon
>> if needed, but any ALSA-only app will not have this behaviour in the
>> current setup. This is really wrong and inconsistent. Users need to know
>> how each and every audio-producing app works in order to understand the
>> behaviour. That totally sucks.
> 
> Hm, maybe I was misinformed then.  But there seem other apps doing
> that, too (that's how I was told about NOAUTOSPAWN flag).

Can you let me know which apps? Defining NOAUTOSPAWN when using the alsa
mode *after* using the PA-native mode is something I have no problem
with (we've tried PA and it doesn't work so no use in ALSA trying to
autospawn PA too), but defining it before using PA-native mode or when
only alsa mode is available is a pretty bad idea and should be fixed.


>> I've never argued the contrary. I'm fully supporting a mechanism to
>> allow this, even if it will be a degraded experience for the user. Users
>> who choose this typically have their own good reasons and I'm not going
>> to analyse the merits of those reasons here. I'm just stating that your
>> approach is broken with many use cases and you need to understand that
>> the primary target - the one that should work as smoothly as possible
>> without any corners - is the PA case. I'm not against giving users a way
>> to work without PA, but not at the expense of those that do, and not at
>> the expense of extra support burden for me.
> 
> Yeah, I do understand it.  But try to look to another side: what if a
> non-PA system doesn't work any more smoothly suddenly after installing
> pulseaudio package but without touching anything else?  This is the
> problem I've seen and we are trying to solve.

I don't think papering over the cracks with work arounds is the right
approach in this scenario. The user may get the mistaken impression that
all is well simply because they can hear sound but then get all confused
as to why his DE doesn't offer him a mixer to control volume and why his
bluetooth headset doesn't just magically work with Skype etc. I think if
the user has opted to use PA and something breaks, then the user should
be told about it quite obviously and then they can take appropriate
action, not limp on with an incomplete setup.

> So, this is partly a problem of packaging.  Installing a package may
> break other environments, but it shouldn't happen brutally.  We'd need
> to provide a good way to give the coexistence of both PA and non-PA
> systems.

I agree with the "good way to.." bit, but I actually disagree about the
brutality :p I think I've voiced that sufficiently in the above segment
tho'.

>>> The current fallback mechanism is far from perfect.  It should be
>>> improved.  But please see the key point of it is that the system can 
>>> use the same alsa-lib config for both PA and non-PA cases.  As said,
>>> if we have an easy way to set / check PA's activity, the fallback
>>> check can be replaced in a better & reliable way.
>>
>> I'll certainly look into this, but as I asked before, please do not ship
>> this as is.
> 
> Yeah, I'm considering either changing or reverting it, but let me do
> it later (I'm in a conference for a couple of days).

Awesome thanks. I'll put this at the top of my list before any of the
fun things after we get 1.0 out the way :)


> Well, again, if a good mechanism is introduced to identify the use of
> PA, the things gets really easier.  I'm not stuck with the current
> fallback mechanism at all.  But some automatic way to route either PA
> or non-PA plugin is needed.  Otherwise user would need to re-define
> the asoundrc by himself, and it's a bigger burden, especially when you
> think of cryptical syntax of asoundrc.

Yeah I think this is the crux of it all. When we have this I'll have a
much better case for convincing of any points we disagree on :D

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
