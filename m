From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re:
	[PATCH] emu10k1: add interval timer support)
Date: Sat, 25 Sep 2004 23:10:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096168244.1357.12.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de> <1096059735.11589.45.camel@krustophenia.net>
	 <1096160120.3697.35.camel@krustophenia.net>
	 <1096167105.1357.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096167105.1357.5.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 22:51, Lee Revell wrote:
> OK, I fixed the voice allocator to handle multichannel PCM.  Now it
> looks like the prepare callback is being called over and over in a loop.
> 
> I am still missing parts of the driver, like the interrupt handler.  But
> it seems like the prepare callback should not loop this way.  Am I doing
> something wrong?
> 

Never mind, I answered my own question - because I don't have an
interrupt handler yet jackd keeps restarting the stream when it gets
woken up by the capture interrupt and sees that nothing has happened on
the playback side.

So, jackd opens the 16 channel device correctly.  But speaker-test
doesn't seem to work.  I tried it like this:

rlrevell@mindpipe:~$ speaker-test -c 16 -D hw:0,3

speaker-test 1.0.5

Playback device is hw:0,3
Stream parameters are 48000Hz, S16_LE, 16 channels
Sine wave rate is 440.0000Hz
Access type not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument

But, you can see in the logs that it does not even try to open the pcm. 
Is there a hardcoded limit of how many channels speaker-test supports?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
