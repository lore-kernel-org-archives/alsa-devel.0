From: andoru <andoru.blah@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Tue, 1 Apr 2014 18:48:12 +0000 (UTC)
Message-ID: <loom.20140401T193432-364@post.gmane.org>
References: <CAAvHfitJ2B1sr7_6h=ww_SVGgsuy4iNLGc3CjDyiNtwdpJTSUw@mail.gmail.com>
 <533AA4F9.4040508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EA5C265476
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 20:48:30 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WV3jS-0000KU-Nk
 for alsa-devel@alsa-project.org; Tue, 01 Apr 2014 20:48:23 +0200
Received: from cl-86-125-143-50.cablelink.mures.rdsnet.ro ([86.125.143.50])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2014 20:48:22 +0200
Received: from andoru.blah by cl-86-125-143-50.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2014 20:48:22 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> Andoru wrote:
> > The last time you replied you said that it's a hardware error. If it
> > is that way then how come the card otherwise works flawlessly in
> > Windows, and this doesn't happen on Debian when watching videos or
> > with certain programs?
> 
> It's still a hardware error, but, apparently, it happens only when the
> Linux driver accesses it in a certain way.
> 
> Which programs work?  Which do not?
> 
> Regards,
> Clemens
> 

Thanks and sorry again for contacting you through your private e-mail, Gmane
wasn't working yesterday.
I thought of letting VLC play along in the background and leave the Messages
window open with verbosity on 2 to see if any error pops up or any clue as
to why this happens. The ironic thing is that I've been listening to music
for about 4 hours and a half and nothing happened, even now it still plays
flawlessly... This is the longest period I've listened to music without
causing VLC to send this PC into error oblivion. I'll post if anything pops out.

Before I continue with the detailed list of programs that work or don't, I
wanted to ask if there's any way to stop the audio server when the PC
becomes unresponsive. So far this is what I've tried while the PC was
struggling to swich to the TTY:

$ alsa force unload

and

$ sudo invoke-rc.d alsa-utils stop

One closes ALSA completely and the other stops some components of ALSA, but
none of those two actually bring the PC/OS back to responsiveness. Nothing
shows up in top that takes that much CPU.

So now onto the list:
- VLC - Audio works fine when watching videos, but as soon as I disable the
video stream (Video -> Video Track -> Disable) same thing happens as when I
try to play audio-only files.
- cmus, moc, Banshee, MPlayer, Rythmbox - same problems as VLC, except cmus,
which instead of flooding the TTY with errors it just displays 3 and exits,
the OS is still unresponsive though.
- any midi interpreter/player - same as the above two
- PCSXR - worked until I changed asound.conf at the suggestions of Raymond
Yau earlier, no audio errors reported in the console before.
- pSX - Reports quite a few buffer underrun errors:
_______________________________________________________
sound: underrun
_______________________________________________________

This occurs 1-2 times every odd second, but I've emulated a game for over 6
hours and nothing bad happened.
But for whatever reason when I tried now to run the emulator it doesn't show
that many of these errors as it used to.
- DosBox - Audio works flawlessly, except midi emulation (see above), MUNT
(below), no errors reported in the terminal. When using any midi interface
this (single) error shows up and renders the OS/PC unresponsive: 
ALSA-lib pcm.c:7843:(snd_pcm_recover), underrun occured
- MUNT (https://github.com/munt/munt) - When using the stand-alone qt
client, I get this error in a dialogue window:
________________________________________________________
snd_pcm_writei failed: Broken pipe
ALSA audio: Processing thread stopped
________________________________________________________

Although admittedly it doesn't end with the OS being unresponsive
thankfully, but it happens exactly after playing 5 secs through a midi.
Now MUNT doesn't work either just like PCSXR

What I haven't tried:
Audio over wine. I don't know how well it works, but I'll try to run
foobar2000 through it to see if it changes anything.


Other stuff that don't work (properly):
- I some apps that use ALSA don't work (as PCSXR that I mentioned above)
- Can't control PCM channel volume
- alsamixer doesn't work except the controls for alsa-equal (see below)
- Screeching and popping when the audio is too loud or has cutoffs
- alsa-equal doesn't work even when properly configured (asound.conf here:
http://pastebin.com/c92CBZfQ and .asoundrc: http://pastebin.com/fmst4sJD)
and similar screeching when explicitly using aplay -D equal and setting some
controls "too high" it through alsamixer -D equal
- can't have more that one sound source (even with dmix set up)

Here's also what VLC outputs when playing a typical mp3 file in case you
need it: http://pastebin.com/gvZ4R4ZP
It shows some ALSA debug info.

Hope I was descriptive enough. Let me know if you need any additional info.
