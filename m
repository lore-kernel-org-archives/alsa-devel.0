From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1: add interval timer support)
Date: Fri, 24 Sep 2004 18:32:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409242232.i8OMWXao032444@localhost.localdomain>
References: <1096059735.11589.45.camel@krustophenia.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 24 Sep 2004 17:02:16 EDT."
             <1096059735.11589.45.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>It is more efficient to use a single 16 channel non-interleaved device
>if, as in the case of JACK, only one app will be using the device and it
>will use all channels.  Individual mono streams become more efficient as
>the channel count gets lower.

this is a reasonable point. 

>Also with kX ASIO you can lower the CPU load by only opening as many
>playback channels as you will use, because with multiple mono channels
>the amount of work you do in the interrupt handler is proportional to
>the number of channels.

maybe so with kX ASIO, but this not true of ALSA. the work done by the
interrupt handler is proportional to the number of open streams, not
channels. a 26 channel device consumes the same number of cycles at
interrupt time as a single channel device.

the only thing that goes is required down with the channel count is
the bus bandwidth utilized. the CPU cycles used will depend on the
mixer configuration etc (i.e. do you have to silence the unused
channel buffers each time, or can you just mute them) ...

--p





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
