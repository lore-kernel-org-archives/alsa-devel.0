From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: buffer_size and period_size
Date: Mon, 27 Jan 2003 13:39:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18dE4z-0004Go-00@sc8-sf-list1.sourceforge.net>
References: <NDBBLGIKBJENLAMOLFHGCEGKBDAB.mknecht@controlnet.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Jan 2003 09:48:15 PST."
             <NDBBLGIKBJENLAMOLFHGCEGKBDAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Paul,
>   So with -p 64 -n 2 settings, what number of bytes of audio data is
>transferred across the PCI bus between each interrupt?

the period size is always (as with almost all ALSA metrics) in units
of audio frames (1 sample for each channel). so with JACK running at
-p 64, 64 frames of data are transferred. how many bytes that is
depends on the sample width and the number of channels.

>   Also, does the number of bytes transferred change based on how many
>channels are enabled? Or does my RME always transfer 26 channels of data
>even if I am not using some channels?

its hardware dependent. for the RME, the same amount is always moved,
regardless of how many channels are enabled. in the case of the RME
Hammerfall series, its more accurate to say that you cannot change the
number of channels enabled. this is not true of all other hardware.

>   I am assuming that a card like the RME is a bus master, moves so many
>bytes, and then interrupts to tell the system that the bytes are there. Is
>this basically the case?

yes. keep in mind that this only covers 1 direction: the interrupt
also tells the system that its possible to put data into the "hardware
buffer". 

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
