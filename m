From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 0/3] Fallback mechanism for pulse plugin
Date: Tue, 13 Sep 2011 12:00:20 +0100
Message-ID: <4E6F37C4.5090704@colin.guthr.ie>
References: <s5hk4b5w7aq.wl%tiwai@suse.de> <4E624761.5000305@colin.guthr.ie>
	<s5hipoy89ss.wl%tiwai@suse.de> <4E6DC6DB.7080204@colin.guthr.ie>
	<s5hbouq868a.wl%tiwai@suse.de> <4E6E51FF.9070508@colin.guthr.ie>
	<s5hty8gvpuz.wl%tiwai@suse.de> <4E6F188A.1040404@colin.guthr.ie>
	<s5hk49cvkhw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 303AE2437E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 13:00:28 +0200 (CEST)
In-Reply-To: <s5hk49cvkhw.wl%tiwai@suse.de>
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

Hiya,

[ Cheat note: There are various agreements and disagreements throughout
this reply - I hope I've stated clearly the reasons why I disagree
(quite strongly) with certain elements and I do firmly believe there is
a way to make this all work, but it needs to be done carefully and I
really hope you will not ship a new library/plugins version with this
stuff enabled until the relevant stuff is in place ]


'Twas brillig, and Takashi Iwai at 13/09/11 10:50 did gyre and gimble:

>>> But one problem is that this setup is a global one.  There is no
>>> trivial way for setting up for each user.
>>
>> Yes, I did the same in Mandriva/Mageia, but it's global only. An option
>> to do this officially in PA configs would IMO solve this issue - the PA
>> configs can already be set to global (/etc/pulse/daemon.conf) or local
>> (~/.pulse/daemon.conf), so if that's all we use to define whether or not
>> we want PA, then we should be all set.
> 
> Or, can we introduce an environment variable to indicate globally
> whether the system is supposed to use PA or not explicitly?  It's
> easier than looking through config files.

I don't think an env var makes sense. Think of console logins, we'd have
to push this env var into the bash profile and deal with other shells
too. It's just too much setup and config to implement at a packaging
level IMO.

> Alternatively, if PA-lib provides a simple function to return the
> enablement state, it'd be fine, too.

I think this is better.

>>>> So the problem I have is thus:
>>>>
>>>>  1. If the user wants to use PA and it's configure in the system that
>>>> way, then ALSA (or any other PA client) will autospawn PA if it's not
>>>> running. If that doesn't work, I would prefer that no ALSA-only fallback
>>>> happens as it masks where the real problem lies.
>>>
>>> Right.  In this case, PA should have been started beforehand.  But,
>>> the start-up is always racy, so it might happen that ALSA-pulse app is
>>> kicked off before PA daemon gets started.  This is one possible
>>> problem.
>>
>> I've still not been able to nail down any races but I've had a handful
>> of bug reports that seem to suggest *something* racy is going on. I'll
>> be damned if I can spot it in the code tho'. :(
> 
> I remember vaguely XDG startup conflicts.  There are two startups, one
> for GNOME and one for KDE, and both are started on KDE.  In addition,
> the GNOME login sound might autospawns PA during/before PA-start
> desktop file is processed.

Re the XDGs, there are two; one for X11 generally (all DE's) and one
specifically for KDE. The latter will disappear eventually when I've
managed to rewrite a bunch of stuff.

But these shouldn't cause any conflicts per-se. "pulseaudio --start"
(which is what is used in both script) shouldn't return until PA is
started and ready and it *should* work happily if both are run at the
same time (emphasis on "should" - I'm not going to rule out any bug
there whatsoever. I'll have to inject some delays into it to try and
test some theories here).

But anyway, if PA is autospawned or started by XDG, all scripts should
work fine. If there are races there, then they are just bugs that need
fixing. The general MO is sound.

>>> Another possible problem is when PA daemon crashes by some reason and
>>> ALSA-pulse app is started just after it.
>>
>> That shouldn't generally be a problem. We should autospawn in that case.
>> That said, I'm not sure if there is a sequence of precise timings that
>> would cause a problem here?
>>
>>>>  2. If a given user does not want to use PA, but the system is
>>>> configured to run PA, then that user will typically have a PA daemon
>>>> started anyway via XDG autostart, unless they have specifically chosen
>>>> via their DE to override this startup option. In this scenario, PA is
>>>> running already and the automatic fallback stuff in the alsa-plugin
>>>> won't work as intended.
>>>
>>> XDG isn't used in every environment.  Many window managers won't use
>>> it.  So, there are two cases: 2a) PA starts up via XDG but user
>>> doesn't want to use.  2b) PA doesn't start up and user doesn't want to
>>> use PA.
>>
>> Well GNOME and KDE do and there are xdg compliance wrappers for others
>> too, so I wouldn't worry about the cases where it's not present (at
>> least for this example).
> 
> Oh no, you just ignore the cases without XDG.  There are many people
> who don't use XDG startup at all (including me), who are using a
> light-weight WM like fluxbox, icewm or whatever.  The fallback
> mechanism is really for this case.
> 
>> We have to deal with the "fallout" when it is
>> present. i.e. the 2a).
> 
> The case 2a is that user needs manual adjustment anyway.  If XDG is
> used, the adjustment is unavoidable.  So, the only sane solution for
> this is a static configuration.

I disagree. The fact that XDG doesn't work should be totally irrelevant.
Any solution that works by virtue of XDG not working is fundamentally
broken.

> But case 2b is different.  The system doesn't start PA, and thus you
> assume you don't use PA.  But, then ALSA-native app starts PA because
> of the pulse plugin.  This is what annoys most people.

That's how it should be. They've configured alsa to use the pulse plugin
by default and thus it should start PA if it's not running by default.
Doing anything else is very, very broken. I very strongly oppose this
approach. Very strongly.

The fact that an app is alsa native or PA native should be completely
irrelevant. How is an average user supposed to cope with the differences
between how various apps work in order to understand that behaviour?
It's a very bad idea to behave differently in this way.


>> Remember this is an app that supports "PA natively + ALSA fallback" -
>> i.e. there are *two* layers of fallback in this case. That's what I'd
>> like to avoid.
>>
>> HOwever, I can see steps 7-8 not being required.
>>
>>> The problem by fallback is that the autospawn isn't triggered -- that
>>> is, when ALSA-pulse app is started before PA daemon, it fails.
>>> It means that the fallback option assumes that PA daemon is started
>>> already in a certain way like XDG.  And the scenario 3 above is a
>>> problem, indeed.  (The scenario 1 might have races in exceptional
>>> cases, too.)
>>
>> Ugg, so it breaks autospawn too :( That *really* sucks. So all it takes
>> if for someone to have an aplay startup sound script and it breaks their
>> entire setup? :(
> 
> Only if the system is supposed to use PA :)

Exactly. And using PA is the recommended setup of pretty much every
distro and of the main DEs. I accept that there may be reasons for
people not to do this, but you should not cripple the majority case!!

> And remember that this is done in the same way like other apps
> (e.g. mplayer) with fallback.

I thought that too, but after your last make I realise it's not. If
mplayer uses it's native PA output, then it will autospawn the PA daemon
if needed, but any ALSA-only app will not have this behaviour in the
current setup. This is really wrong and inconsistent. Users need to know
how each and every audio-producing app works in order to understand the
behaviour. That totally sucks.

>> This system is just keeps creating corner cases!!! I really don't like
>> it :( For one thing this means you cannot have console alsa apps using
>> PA anymore. While I don't personally care about this, we did get quite a
>> few complaints about it before autospawn was default. We'll be the ones
>> taking the flack for this configuration.
> 
> Actually, this is another issue.  People who are working on console
> don't want PA in many cases.  But let's stop arguing whether to use PA
> or not here.

Yeah and many do. That's totally not the point tho'. The point is that
I'm all for giving someone an easy way to opt out. The decision is on
their head if they want a sucky desktop experience. But the fact is you
can't give them this choice without actually making it work properly. If
you do a half hearted job, it'll cause a sucky user experience and it'll
cause *me* more support overhead.

>> So you're saying that PA+non-PA should be treated as equal citizens in
>> the Desktop Environment. Becasue that's not the case. Both GNOME and KDE
>> are both targeting the recommended setup of PA.
> 
> Well, the world is neither GNOME nor KDE.  That's the whole point of a
> tricky way like fallback.  There are systems without PA, and both PA
> and non-PA systems can coexist on a single machine.  It's just a
> matter of configuration.
> 
>> If you don't use PA,
>> then the user certainly gets a second class experience. This is 100%
>> intended and isn't going to change.
> 
> It doesn't matter whether non-PA is a second class or not.  It's
> irrelevant from the discussion here.  The fact is that still many
> people want a non-PA system.  A second-class is cheaper, and easier to
> manage.  Such people prefer it to too complex system.  This won't be
> changed no matter how advertising PA's merit.  So, please accept this
> fact, then continue a constructive discussion.

I've never argued the contrary. I'm fully supporting a mechanism to
allow this, even if it will be a degraded experience for the user. Users
who choose this typically have their own good reasons and I'm not going
to analyse the merits of those reasons here. I'm just stating that your
approach is broken with many use cases and you need to understand that
the primary target - the one that should work as smoothly as possible
without any corners - is the PA case. I'm not against giving users a way
to work without PA, but not at the expense of those that do, and not at
the expense of extra support burden for me.

>> So you really have to consider these changes very carefully. I will
>> fully support and help develop a deterministic system here, but I just
>> cannot see any scenario where automatic checks will work reliably and
>> deterministically, especially now I learn that autospawn is disabled :(
> 
> The autospawn is really a drastic thing.  It can help much but also it
> annoys much...
> 
> The current fallback mechanism is far from perfect.  It should be
> improved.  But please see the key point of it is that the system can 
> use the same alsa-lib config for both PA and non-PA cases.  As said,
> if we have an easy way to set / check PA's activity, the fallback
> check can be replaced in a better & reliable way.

I'll certainly look into this, but as I asked before, please do not ship
this as is.


>> 1. Check PA with full autospawn support.
>> 2. I'll look at adding some kind of error state into the connection
>> stuff in libpulse that would give information about whether or not PA
>> should have been used or not, but something stopped us. The following
>> scenarios should be covered by this check:
>>  a. Attempted to connect to remote daemon, but failed (e.g. due to
>> firewall or simply a daemon not running on the remote end).
>>  b. No remote config, attempt to run PA (autospawn=yes, enable=yes) but
>> PA didn't start.
>>
>> Under those two scenarios, you should fail. But if libpulse can somehow
>> tell you "no PA is not meant to be used here" (i.e. "no local daemon +
>> (autospawn=no || enable=no)") then you can undertake your fallback scheme.
>>
>> I think this approach is more robust, and still gives you most of your
>> auto-configuration desires.
> 
> Yeah, sounds reasonable.

Good :)

>> The user would very much still have to run $something do disable his PA
>> if the system uses it (i.e. echo "enable=no" > ~/.pulse/daemon.conf),
>> but that is something I think we'd have to live with.
> 
> Hm, I guess the point would be how easy you can achieve this.

As well as the config file we could have a PULSEAUDIO_ENABLE=0 env var.
If not present or non-zero PA works, otherwise it doesn't.

That way people could just define an export in their ~/.bashrc. Not sure
if that's better or worse however than the variable in the config file,
but I'm trying to think of ways to make it easy for the user to opt out.

>>>> I really don't think this would work anyway. As I outlined above, if the
>>>> user opts out they *have* to touch some things (disabling PA autospawn
>>>> and preventing XDG autostart), so I think it's likely worth abandoning
>>>> the whole idea of "[not] touching anything".
>>>
>>> Well, PA autospawn is a problem, but it happens only after starting an
>>> PA-native app.  With the fallback, ALSA-native app won't autospawn.
>>> XDG autostart isn't used by many DEs.  So, this use-case isn't so
>>> unrealistic at all.
>>
>> I think that's very wrong. "ALSA native" shouldn't be considered
>> differently to any other pulse client.
> 
> No, no, in the case of non-PA use, ALSA-native is no longer pulse
> client.  User never thinks of PA.  The fallback is just for that
> purpose.

But before you check for PA, you don't know whether you are a pulse
client or not, so defining the env var to prevent autospawning you are
making a concious decision to *favour* the non-PA case. Unsurprisingly,
I've very against this. I'd rather alsa clients were good pulse clients
and played the game. Sure we can offer a mechanism to opt out, but don't
degrade the experience for people who are opting in!!!


>> 2b is easy. PA autospawn should work and start PA. It's then the same
>> case as 2a.
> 
> Ah, maybe this is the misunderstanding.  In 2b, you do _not_ want to
> use PA.  PA isn't started by XDG, and you want dmix via aplay.

No. There is nothing in the 2b case that specifically says you do not
want to use PA. It's just that XDG has failed. That's totally irrelevant
to the question of "Does the user want to use PA?".

So 2b == 2a. The fact that PA was not started by XDG is NOT considered
in anyway a fatal error by libpulse. That's why it has autospawn
support. It's specifically designed to deal with this scenario. Please
do not break it.

> Ideally, for these environment, user should set enable=no or
> whatever.  But it's optional unless user starts PA-native apps, as
> long as the fallback works, because PA daemon is never triggered.

Nope, I could not disagree with this statement more. A failure of XDG
does not indicate that the user does not want PA. We need a more
deterministic system to deal with user choices, this is simply a valid
case for PA to autospawn and you're current approach breaks this
specific implementation.



>> The fact it was started by XDG or autospawn should be 100%
>> irrelevant to audio apps. It's an implementation detail. Maybe we'll be
>> started by systemds session lingering in the future? Who knows. The
>> point is that if the system is configured for PA it should use PA.
>>
>> I want to avoid all the strange rules. I don't want to have to explain
>> to someone on our IRC channel (and believe me, *I'd* be the one getting
>> the fallout from this option, not you!) "Oh pulseaudio automatically
>> spawns if it's not running except if the app is an alsa app in which
>> case it doesn't but only if you've configured your alsa setup that way
>> so it really depends" Users don't really want to know *anything* about
>> Pulse or ALSA. They shouldn't care, they just want a system that works.
>> and I don't want to have to jump through hoops to do it.
>>
>> I will help get the necessary info from libpulse about how to proceed,
>> but only after 1.0 is out the door (which should be soon). All I ask is
>> that you try to appreciate my concerns here and how there are many
>> legitimate use cases and operational steps that would be jeopardised by
>> the current implementation and do not do a release with the code as it
>> currently stands.
> 
> Yeah, let's take a bit more deeper look.

Agreed!

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
