From: Paul Davis <pbd@op.net>
Subject: Re: Configuration Spaces
Date: Tue, 17 Sep 2002 10:08:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rJ03-0005lg-00@usw-sf-list1.sourceforge.net>
References: <20020917094800.A3340@atl.lmco.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 17 Sep 2002 09:48:00 EDT."
             <20020917094800.A3340@atl.lmco.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Chuck Winters <cwinters@atl.lmco.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>My knowledge of signals is that the period is the time it takes a signal to 
>complete 1 cycle.  So what is the snd_pcm_hw_params_set_period used for?
>Is the "period" a property of the signal, or an arbitrary property set by
>the programmer for performance, fidelity, etc.

no, a period in ALSA is, put relatively simply, the interval between
interrupts from the audio interface. it defines the latency for audio
handling. 

if you set the buffer size to 256 frames, and the period size to 64
frames, there will be 4 interrupts per iteration over the buffer:
every time the card has 64 frames of audio or space in the buffer, it
will interrupt the CPU. 

for background on how an audio interface works and some perspectives
on programming with ALSA, check out

    http://www.op.net/~pbd/alsa-audio.html

--p


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
