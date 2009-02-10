From: Sean McNamara <smcnam@gmail.com>
Subject: Re: Software mixer at kernel level
Date: Tue, 10 Feb 2009 00:00:35 -0500
Message-ID: <74eb1fe20902092100k46015792k922b9af5a00956c2@mail.gmail.com>
References: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>
	<74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
	<4990FB35.8050205@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id E7F7010384A
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 06:00:36 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so686923ywa.2
	for <alsa-devel@alsa-project.org>; Mon, 09 Feb 2009 21:00:36 -0800 (PST)
In-Reply-To: <4990FB35.8050205@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 9, 2009 at 10:57 PM, stan <ghjeold_i_mwee@cox.net> wrote:
> Sean McNamara wrote:
>>
>> Hi,
>>
>
>>
>> However, the point about "everybody needs it" is a valid one. If I had
>> my druthers, it would be impossible for anyone in usermode to
>> initialize an ALSA pcm in a mode which does not provide software
>> mixing. We can still provide the software mixing in usermode, but my
>> reasoning is that
>>
>
> <rant>
> I disagree.  I have one of those applications that doesn't do softwae
> mixing, deliberately because I want it to have good sound (it's a brainwave
> entrainment app).  It calls functions in alsa that *can't* be accessed
> through pulse, and allows users to set the frame rate to any hardware rate
> their card supports (in pulse, one size fits all).
>
> Pulse is great for those who want its functionality, and I would love to see
> it replace dmix in alsa so that when it received a request for a function it
> doesn't support it would have the ability to step aside and allow the
> application to take over the sound device.
>
> Linux is about freedom, and I think you are wanting to restrict that freedom
> for me to use my hardware the way I want. If you want to put a switch in
> place that does that, but allows it to be turned off, great, but not hard
> wired to only behave a single way.  Wait!  We already have such a switch,
> it's called /home/.asoundrc.

Sorry, but I think you misinterpreted my suggestion.

Let me sort of imagineer the kind of functionality I was discussing in
a bit more detail, and then you can re-evaluate whether I'm trying to
restrict things in a way that you need to rant about, ok?

First, let's review how it is today.

Let's say I'm using dmix, and it's in my /etc/asound.conf as the
"default" PCM. I am happily going along, starting applications that
obey the tacit convention of opening the device named "default", which
by convention is supposed to contain whatever PCM pluggage that the
user wants.

Now let's say I open some application that, for some reason, wants to
access hw:0. As soon as I try to do this while dmix-using apps aren't
playing sound, hw:0 is now taken, and the dmix apps can no longer play
sound.

This, to me, is a very bad idea for the use case of the desktop. This
should be worked from two sides. Most importantly, we need to make
sure that desktop apps (i.e., the vast majority of apps) should be
able to use dmix or maybe even PulseAudio through the ALSA plug layer.
But an adjunct possibility would be to have a setting somewhere in
ALSA which _prevents_ applications from directly accessing hw:0 in a
way that does not use software mixing. We can then define a set of
plugins (jack, pulse, dmix, dsnoop... any others?) which safely enable
software mixing, and maybe we can have policy exceptions for
individual binaries, to support daemons.

With the changes I was referring to when I wrote my original post, the
new functionality would be thus:

1. [Prerequisite] Start PulseAudio or JACK if desired; if not, set up
dmix as the pcm.!default.
2. Set an option somewhere in the ALSA configs that says "Apps [which
are not in the exception list] may no longer hog the soundcard."
3. Apps that want to play nice with the desktop will access
dmix/pulseaudio/JACK using the "safe" ALSA subset and will open the
"default" device, and not hw:0.
4. An app that wants to open a direct PCM (ignoring the "default"
device) tries to access hw:0 while the other apps are temporarily
quiet. alsa-lib immediately returns an error, whether or not the
device is in use.
5. The apps designed to use software mixing continue on their way uninterrupted.

We could also have a distro-supplied hook which displays a GUI when an
app tries to directly access hw:0. It will be disallowed regardless of
whether the device is busy or not, if the configuration bit is set.

This behavior has the benefit of increasing the reliability of apps
which _do_ use software mixing, because it ensures they will never be
blocked by an app that directly accesses "hw:x". For desktop software
that _should_ be compatible with software mixing but is not, it has
the side-effect of bringing them into the limelight as ones that the
community should try to fix, if possible, to live with the safe subset
and open "default" instead of "hw:x". But as you can see, it in no way
entails that you will no longer be able to open a direct hw PCM.

I guess I can see how you /could/ interpret my original post as
implying some sort of draconian prevention of direct PCM access (with
no way around it), but please, let's be charitable: this is the FOSS
world, and wherever there is need for a bit-flip on points of
disagreement, there usually is one.

The change I've recommended here is merely air code, but its intention
is to suggest one way of making the desktop sound experience more
reliable, _not_ to close off paths for very special use cases like
brainwave entrainment. I'm sure you already realize the consequences
of hogging the "hw:x" devices, so it goes without saying that your app
can't work well in a desktop environment using sounds from many
programs at once. But that's a design decision you have planned for
and accepted, and as such, your program is not designed to be desktop
software on the order of Firefox, Rhythmbox, Pidgin, Evolution,
Phonon, and so on. Since your requirements are so very different, we
can not ignore either the desktop use case or your own special use
case. But that doesn't mean our hands are tied in terms of trying to
make the desktop experience better.

How many times have users wondered why their
Pidgin/Skype/Rhythmbox/Flash stuff won't play sound after they fire up
Audacity, or Second Life? This _is_ a problem with the applications
and not ALSA, but unless we try to encourage use of software mixing,
the issues don't seem to be getting addressed.

Anyway, back on topic to the OP, this matter of "firmer" software
mixing is the only valid point I could salvage from their idea, so
hopefully you'll take me with a grain of salt for talking through his
issue to its logical conclusion :)

Thanks,

Sean

>
> You are welcome to do whatever you want on your system, but don't assume
> that everyone wants what you want.
> </rant>
>
