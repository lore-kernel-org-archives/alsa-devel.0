From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sequencer buffer
Date: Fri, 07 Nov 2003 08:08:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311071308.hA7D8vq9029278@oud.linuxaudiosystems.com>
References: <3FAB7B68.8020007@emt.iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 07 Nov 2003 12:00:56 +0100."
             <3FAB7B68.8020007@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>again I've got a question regarding the ALSA midi sequencer. I tried to 
>generate Midi time code. 

you cannot send 100% valid MIDI time code on a Linux system without
the high resolution timers patch or some other interrupt source that provides
a suitable timing resolution.

MIDI time code is not just a sequence of bytes, it has very precise
semantics about when those bytes are to be delivered. there is no
mechanism in a default linux kernel on 99%-100% of all hardware today
that can implement those semantics.

i know that this isn't directly related to your question, but i wanted
to alert you to this issue. although other devices will be able to
chase your MTC data stream, some or even all will not lock to it
because it is jittery/bursty.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
