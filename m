From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1:
 add interval timer support)
Date: Fri, 24 Sep 2004 18:57:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096066620.12083.17.camel@krustophenia.net>
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
> >Also with kX ASIO you can lower the CPU load by only opening as many
> >playback channels as you will use, because with multiple mono channels
> >the amount of work you do in the interrupt handler is proportional to
> >the number of channels.
> 
> maybe so with kX ASIO, but this not true of ALSA. the work done by the
> interrupt handler is proportional to the number of open streams, not
> channels. a 26 channel device consumes the same number of cycles at
> interrupt time as a single channel device.
> 
> the only thing that goes is required down with the channel count is
> the bus bandwidth utilized. the CPU cycles used will depend on the
> mixer configuration etc (i.e. do you have to silence the unused
> channel buffers each time, or can you just mute them) ...

OK, makes sense.  Maybe the kX driver behaves this way because of the
way ASIO calls the process callback from the interrupt handler.

Anyway, using a few more voices than necessary is not as much of an
issue.  The only important use of multiple open with this device is to
work around a non-JACK aware app by having it output to the FX bus.  It
seems that the single 16 channel device will be easier to implement, so
I am going to start with that, and the initial implementation will not
support multiple open for playback.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
