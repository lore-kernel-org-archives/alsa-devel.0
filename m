From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1:
 add interval timer support)
Date: Sat, 25 Sep 2004 00:05:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096085131.1407.18.camel@krustophenia.net>
References: <200409242232.i8OMWXao032444@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409242232.i8OMWXao032444@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-24 at 18:32, Paul Davis wrote:
> >It is more efficient to use a single 16 channel non-interleaved device
> >if, as in the case of JACK, only one app will be using the device and it
> >will use all channels.  Individual mono streams become more efficient as
> >the channel count gets lower.
> 
> this is a reasonable point. 
> 

OK, thanks everyone for your help.  I now have the basic device working.
At least, it compiles and I can open it...

I noticed the RME drivers use an interesting hack, of checking whether
the playback and capture device are open by the same PID.  My device
will require something similar, as it also requires the same period size
in both directions.  Would you recommend using the same method, or is
there a "better" way?  Seems like this will work fine for jack, which is
the targeted user anyway.

With ASIO, I think this problem is solved by some kind of system wide
hook.  If I use different ASIO apps, each will have a button in the
config that opens the system-wide ASIO control panel widget where I can
set the buffer size; changing it will change it for all apps.  Some
handle this better than others; some will hiccup and some will have to
have their audio engine restarted.

Maybe ALSA should implement a system-wide method to set properties like
this that apply to playback and capture devices.  Or maybe this is
better handled with a hardware specific app.

Lee









-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
