From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP 9652: Input channel corruption
Date: Wed, 15 Oct 2003 20:18:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310160018.h9G0I5UW002143@oud>
References: <1066255261.3f8dc39da8799@scorpio.lunarpages.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Oct 2003 15:01:01 PDT."
             <1066255261.3f8dc39da8799@scorpio.lunarpages.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@robdye.net
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>It sounds to me that the problem Nick Arnold is describing is that in
>single-speed (48kS/s) mode, channels 0, 8, and 16 have a 1-sample delay
>with respect to all the other channels (using 0-based indexing for
>channel numbers here).  This is irrelevant when recording uncorrelated
>signals, and subtle when dealing with time-coherent signals
>(single-point stereo or Ambisonic for example).  When splitting one
>signal across two channels, it is deadly.

i just want to mention the possibility that this is caused by hdsp
firmware. and if it is, and you tried to ask RME about it, and told
them that you were emulating their emulation of 96kHz in your own
software, i doubt you'd get much help from them.

i cannot think of *anything* in the hdsp driver that would have any
effect on this, and i can easily imagine a situation where there was a
1 sample delay between ADAT connectors written into the
(hard|firm)ware (though it does seem unlikely). one thing, for
example, is that i know on the old digi9652, the hardware cannot
guarantee that all channels are operating at the same point in the DMA
buffer, although this should not cause the effect nick has seen.

i really encourage nick to drop (even if its only for testing) his own
double speed operation and try out RME's own stuff (implemented in
their firmware).

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
