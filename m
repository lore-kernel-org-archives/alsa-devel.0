From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Mon, 14 Mar 2011 22:54:08 +0000
Message-ID: <4D7E9C90.1090807@colin.guthr.ie>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>	<4D7E2BB0.7080108@colin.guthr.ie>
	<AANLkTi=MXXxkcbA2h=jkJzm4BWm7_4vEwuNoaNDGE-CN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 26425103827
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 23:54:11 +0100 (CET)
In-Reply-To: <AANLkTi=MXXxkcbA2h=jkJzm4BWm7_4vEwuNoaNDGE-CN@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Craig Bourne <craigbourne@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[Friendly request: If possible, please try to keep replies to plain text
only, and use standard mailing list quoting styles. This makes it much
easier for people who read many hundreds of such emails every day to get
a consistent style and thus human-parse emails more easily and
reply-to-the-reply in a standard way too :) Thanks.]

'Twas brillig, and Craig Bourne at 14/03/11 18:00 did gyre and gimble:
> "Have you guessed the riddle yet?" the Hatter said, turning to Alice again.
> "No, I give it up," Alice replied. "What's the answer?"

:D

> Thank you very much for the feedback. I appreciate it and would
> appreciate further suggestions on a more functional approach to dealing
> with these issues.
> 
> With respect to this advice:
> 
> On a typical desktop, audio will work fine as root, provided the root
> privileges have been obtained via a graphical login as a normal user and
> the "su" command. By virtue of being able to access the X11 root window,
> the root user will be able to communicate with the PA daemon of the
> running user just fine. It relies on the start-pulseaudio-x11 script
> having been run which is the case on a typical login.
> 
> As a general rule however, you should not need to do anything as root.
> Using root for purposes other than sysadmin is generally discouraged and
> unnecessary.
> 
> This experience is at variance with your assertions:
> 
> *Graphical login as cbourne [an unprivileged user] from a terminal
> session su as root*
> 
> [root@speedy cbourne]# audacity
> 
> (Audacity:20310): GnomeUI-WARNING **: While connecting to session manager:
> None of the authentication protocols specified are supported.
> **
> GLib-GIO:ERROR:gdbusconnection.c:2270:initable_init: assertion failed:
> (connection->initialization_error == NULL)
> Aborted (core dumped)
> [root@speedy cbourne]#

Running audacity as root is very different to "accessing pulseaudio as
root". There are lots of other things that may get in the way, for
numerous reasons, of running a full blown GUI app that is beyond the
scope of libalsa and libpulse.

On my system here for example:
[colin@jimmy ~]$ xprop -root | grep PULSE_SERVER
PULSE_SERVER(STRING) =
"{6cb2a4b2bd6df042e57da8a4000001d4}unix:/home/colin/.pulse/6cb2a4b2bd6df042e57da8a4000001d4-runtime/native
tcp:jimmy:4713 tcp6:jimmy:4713"
[colin@jimmy ~]$ sudo -i
[root@jimmy ~]# xprop -root | grep PULSE_SERVER
PULSE_SERVER(STRING) =
"{6cb2a4b2bd6df042e57da8a4000001d4}unix:/home/colin/.pulse/6cb2a4b2bd6df042e57da8a4000001d4-runtime/native
tcp:jimmy:4713 tcp6:jimmy:4713"
[root@jimmy ~]# paplay /usr/share/sounds/pop.wav

Provided the root user can access the X11 window of the user in question
(the user with the active session - see ck-list-sessions) and provided
the root user can access the physical socket file, then it will be able
to talk to and communicate with the user's PA daemon.

What I've not included here is the PULSE_COOKIE X11 prop, which is also
used so that root can authenticate to the user's PA. Access to the X11
root window is considered enough for us to allow the user to access the
sound too.

> *Graphical login**as cbourne from a normal terminal session *
> 
> [cbourne@speedy ~]$ audacity
> Cannot connect to server socket err = No such file or directory
> Cannot connect to server socket
> jack server is not running or cannot be started
> Expression 'stream->capture.pcm' failed in
> 'src/hostapi/alsa/pa_linux_alsa.c', line: 3653
> VST_PATH not set, defaulting to
> /home/cbourne/vst:/usr/local/lib/vst:/usr/lib/vst
> 
> (Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xac3e758' has no handler with id `6850'
> 
> (Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xa64a490' has no handler with id `124'
> 
> (Audacity:20315): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xa932080' has no handler with id `197'
> 
> ... (more warnings)
> 
> [ It should be noted that, despite the error response, audacity produce
> audible output only if jack is NOT running-- else, if jack is running,
> everything looks normal but there is no sound ]

I can run audacity fine:

[colin@jimmy ~]$ audacity
Cannot connect to server socket err = No such file or directory
Cannot connect to server socket
jack server is not running or cannot be started
Expression 'stream->capture.pcm' failed in
'src/hostapi/alsa/pa_linux_alsa.c', line: 3653

Everything works fine with PA underneath.

As far as the sound setup is considered, the Host is "ALSA" with
playback and recording devices set to "default".

> *Graphical login**in as root **from a terminal session under that login
> *
> [root@speedy ~]# audacity
> Cannot connect to server socket err = No such file or directory
> Cannot connect to server socket
> jack server is not running or cannot be started
> Expression 'stream->capture.pcm' failed in
> 'src/hostapi/alsa/pa_linux_alsa.c', line: 3653
> VST_PATH not set, defaulting to /root/vst:/usr/local/lib/vst:/usr/lib/vst
> 
> (Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xabe5758' has no handler with id `6880'
> 
> (Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xa666490' has no handler with id `124'
> 
> (Audacity:20805): GLib-GObject-WARNING **: gsignal.c:2392: instance
> `0xa9cc080' has no handler with id `197'
> 
> ... (more warnings)
> 
> [ Here sound is produced by audacity 1) without jack running, 2)  with
> jack running using the startup/shutdown scripts 3) with jack running but
> without the scripts.  Though I have no metrics to share with you to
> support this, it is my repeated observation that procedures 1) and 3)
> produce far more noise than does procedure 2) in this testing scenario. ]

I can't really comment on the JACK setup as I don't have it running.

> I would of course prefer to adhere to current best practice as I attempt
> to address these issues rather than flailing about with deprecated and
> inappropriate methods. The means of doing this is less clear to me than
> you may suppose, and not for want of exploring the material posted
> on-line where, e.g.,, the ALSA web site offers what I presume to be
> current information along with articles that are, in whole or in part,
> clearly out of date. But what is out of date is not always clearly so.

I presume you have a direct need and desire for running JACK? I won't
question that, just want to make sure you're genuinely wanting it or
seeing it as a "means to an end" (which I don't think is the case, but
you gotta ask :D)

> As of Fedora 12 I was able (with some considerable struggle) to get all
> of the jack/ALSA and all the applications that use them functioning
> properly. With the change to Fedora 14 the struggle started again-- but
> I was able to get most of the applications that I had come to rely on
> working again. With the latest set of changes in fedora 14 (including
> many changes in ALSA) nothing works.

I suspect this is party a hangover from upgrades.

Running system-wide PA is generally not recommended - tho' it's not
clear that this is the case.

Things to check:

1. ck-list-sessions: Make sure you user is correctly setup and that you
are the "active=TRUE" session.
2. getfacl /dev/snd/*: Make sure that when your session is active, your
user is included with rw access in the ACL.
3. Make sure your user is NOT in the audio group.
4. Make sure PA autospawn is active (check both /etc/pulse/client.conf
and ~/.pulse/client.conf)
5. Ensure that start-pulseaudio-x11 is installed and run at login
(checking via xprop as indicated above is a good test).
6. Check that becoming root still allows you to access the X11 root
window of the user (xprop again)
7. Test paplay as root to confirm the above fully.
8. Run pavucontrol and confirm:
 8a) aplay /path/to/file.wav: shows up under the "Playback" tab when
running.
 8b) arecord: shows up under "Recording" tab when running.

This confirms a typical setup with PA is all working and correct.

If you want to run jack, you can use the jack-dbus stuff for a graceful
handover and suspension of PA or you can use "pasuspender -- myaudioapp"
to ensure that pulseaudio will suspend it's access to the audio devices
when running myaudioapp. You will have to ensure that myaudioapp does
not use the "default" audio devices as these map to PA. You can
theoretically configure audacity to run jack as needed and if you run it
via pasuspender then you don't have to worry about PA accessing the
audio devices.

I hope this info helps you find a more graceful solution and explains a
bit how things fit together.

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
