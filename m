From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: Improving wine support for alsa.
Date: Fri, 07 May 2004 03:14:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1083892456.18258.55.camel@renegade>
References: <409A80DC.2080601@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail48.e.nsc.no (mail48.e.nsc.no [193.213.115.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17507
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 03:14:57 +0200
In-Reply-To: <409A80DC.2080601@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

tor, 06.05.2004 kl. 20.15 skrev James Courtier-Dutton:
> I have been updating the wine alsa driver to work better with alsa.
> So far, all I have done is update it to use the new alsa api.
> Windows uses an api called Direct Sound.

I think this problem has been discussed on this list before, with
WineX's version of winealsa delivering good performance as a result. You
can see the current code at

http://cvs.transgaming.org/cgi-bin/viewcvs.cgi/winex/dlls/winmm/winealsa/

and

http://cvs.transgaming.org/cgi-bin/viewcvs.cgi/winex/dlls/dsound/
(there are some changes to how the mixer thread puts changes into the
primary buffer, specifically the primary buffer is locked/unlocked
before data is written to it)

TransGaming is currently willing to donate at least the winealsa parts
to ReWind and Wine under the MIT license, so you should be able to merge
any winealsa changes you like into Wine.

> Direct Sound uses direct hardware buffer access.

If possible. It can do without.

> A Win32 program can quiry the sound driver and ask for the currently 
> playing position, together with the first available possition that the 
> application could write to. I will call these "PlayPos" and "WritePos" 
> respectively.
> E.g. If the hardware is halfway through playing one period(the PlayPos 
> is in the middle of a period), the beginning of the next period's 
> position is returned as the "WritePos".
> 
> The problem arrives because the Win32 app expects to have full write 
> access to the hardware buffer, and can write to any parts of it at any 
> time.

Well, not exactly at any time. It must lock the portion it wants to
write to first. But perhaps you're talking about not the Win32 app, but
Wine's mixer thread. This thread should also lock the primary buffer;
not doing so is a bug, which is now fixed in WineX. This would allow
operation where the software mixer does not write to the hardware
buffer, but the driver transfers the data there upon unlock, without
most of the problems associated with using a pcm callback that attempts
to copy data just in time. It even allows operation where the software
mixer *does* write directly to the hardware buffer...

And when the mixer thread does the proper locking, then the driver's
Lock/Unlock calls can be implemented in terms of ALSA's mmap_begin and
mmap_commit calls, it just takes some juggling with the application
frame pointer. And you end up as close to the hardware as you need to
be, without using a PCM callback. Using this design, WineX's winealsa
seems to perform about as well as wineoss.

> The sound card should just happily move through the buffer playing 
> each sample as it goes, and when it reaches the end, just start at the 
> beginning again.

The set_stop_threshold call in WineX's winealsa kinda lets the card do
this (thanks Jaroslav).

> Another problem is that if I want to stop the stream, I call 
> "snd_pcm_drop(). With this I would expect snd_pcm_delay()==0 and 
> snd_pcm_avail_update()==buffer_size.
> It seems that these values are only reset to 0 after first calling 
> snd_pcm_prepare().
> After stopping the stream in this way, I want to restart it again 
> without having to close/open the pcm.

Well, the solution is pretty simple. After calling snd_pcm_drop(), just
call snd_pcm_prepare(). Works for us.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
