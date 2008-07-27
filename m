From: "Peter Dolding" <oiaohm@gmail.com>
Subject: Re: alsa-lib has anyone looked at taking it cross
	platform?
Date: Sun, 27 Jul 2008 13:18:46 +1000
Message-ID: <e7d8f83e0807262018u1755c890u7f4ec945be14bea2@mail.gmail.com>
References: <mailman.1.1217066401.19372.alsa-devel@alsa-project.org>
	<e7d8f83e0807260548j4892fb2cga6149a6d3c8e4f13@mail.gmail.com>
	<20080726212400.GA2415@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 807DC244DD
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 05:18:48 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2873914rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2008 20:18:46 -0700 (PDT)
In-Reply-To: <20080726212400.GA2415@localhost>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 27, 2008 at 7:24 AM, John Rigg <aldev@sound-man.co.uk> wrote:
> On Sat, Jul 26, 2008 at 10:48:14PM +1000, Peter Dolding wrote:
>> Note its imposable to get nested sound server to work perfectly.   But
>> its more than possible to get a single sound server to do all the jobs
>> of all the other sound servers so giving perfect API coverage.
>
> Where does JACK fit into this? It's aimed at a completely different
> set of users from the other sound servers for Linux.
>
> The requirements for pro audio, eg. music recording, sound for film
> etc. are totally different from those of the average desktop user.
> A single sound server that tries to do everything for everybody
> sounds to me like a potential nightmare of conflicting requirements.
>
> John
>
I need to be more correct.   Only 1 sound server wanting all audio
threw it with only 1 config system.   No point having to fight with
Alsa and pulse, Network Audio System and esd to get sound up.   You
know you are going to have a fight sections are going to conflit with
each other so you cannot have all features of them at once because you
have a few too many sound servers trying to do exactly the same thing.
  Control all audio output.   There is only room for 1 sound server
doing that job.

Jack really does not go after that.   Jack is built as patch table.
Applications say I have these inputs and these output connect me to
something or nothing I don't care.   Commonly called a sound server
but its really not a sound server in the traditional idea.   Its also
like NMM that way gets labeled a Sound Server when people sort them
but really its nothing like it.

Stuff like pulse and esd did one sound server take the api of the
other one in a never ending process until there is only 1 left wanting
to control all audio is the only way forward.

I will layout how I see that pulse should be taken on by alsa and its
way different to current method.

The true driver system of pulse that is unique to it is its transfer
protocol over network.  That needs to be a plugin into alsa for output
as a client.   And a demon to feed into alsa for receiving network
traffic.

This way neither end need pulse to use its protocol.

Mixer of Alsa upgraded to support the new requirement of per
application volume control.

Pulse and ESD API's turned into nothing more than wrappers going
straight into alsa api.

This is basically the end of pulse.  Same for Network Audio System.
These basically need to be killed off duplication on a task that there
can only be 1 thing doing it at a time.   This also sees only 1 mixer
in use.   Alsa design does not make this even restrictive you could
have a PA, Dmix,ESD and NAS mixers as all Alsa mixer plugins.  So we
don't stop development and redesigns we move to a module method of it
as ALSA was designed.   Mistake has been using pulseaudio and other
things like its application input api's from ALSA instead of looking
at where it should be cut into segments so it cannot cause conflicts
with Alsa.

Jackaudio is lower down the list on need to worry about.   Reasons its
specialist they are not aiming to control every and take over ALSA job
of controlling everything.   But still as Advanced Linux Sound
Architecture.  We do need to look at what we can provide jack with and
if Jack should be included and directly promoted as part of the design
of the Linux Sound Architecture for applications to use.

Due to a Architecture having the right to have many api's over time
Jack's features could appear as a segment of ALSA.

Here the thing.  Jack's features of being able to control
interconnects between applications and do it low lag.  Is a feature
Alsa will most likely be need of for containers/cgroup features being
added to linux.   Same with pulseaudio the control of sound on a per
application base or per container base will become needed as part of
the Architecture over time.  Really per process sound control could be
done all the way down into kernel level.  Allowing hardware
acceleration if hardware supported.

Then there are the issues of openal where alsa is not that functional
for 3d sound that needs to be fixed.   Basically lots and lots of work
needs doing correctly.   Cross platform of Alsa-lib would to be to
prevent feature adds like 3d sound having to go threw non alsa api's.
Reason openal was formed for 3d sound is a lot of applications 3d use
opengl that is cross platform so also need cross platform audio.  So
now we don't have the programmers that know exactly what 3d developers
want all here because we have openal in existance.  Going cross
platform is supporting the developers using Alsa to have less work
porting there applications as well as discouraging development of
these extra layers.

Working 3d sound processing chips could also add some interesting
effects to per process sound like taging a process sound to a location
behind you when its hidden and moves forward past to in frount you
when its activated.

We need as many of those skilled developers in alsa or with the
expanding kernel features ALSA will more and more not fit correctly.

Its house cleaning time.  Pulseaudio has started the process.  About
time everyone here takes the hint alsa is lacking because its always
being looked at that alsa cannot rip the other projects into segments
and intergrate.

Peter Dolding
