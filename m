From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: OpenAL - ALSA interface proposal. I request for comments...
Date: Sun, 14 Dec 2003 21:34:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312150234.hBF2Y1DH012310@oud.linuxaudiosystems.com>
References: <1071455606.17638.45.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 14 Dec 2003 22:33:27 -0400."
             <1071455606.17638.45.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: manuel.jander@mat.utfsm.cl
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Since there is almost nothing else to do to support the Aureal Vortex 
>3D processor on Linux, just as i announced some time ago i started
>designing a OpenAL interface for ALSA. The design is meant to be
>applicable to other hardware too.
<
>I made a preliminary description, from what i have done so far, because
>i want to allow other more experienced people to comment and give input
>to this.
>
>I posted it in plain text. I hope that is compatible enough.
>http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/OpenAL-ALSA.txt
>
>Well, please give it a read, and tell what do you think about. Thank you
>very much.

i think this is not a very good idea. if you want to wrap OpenAL
around ALSA, then wrap it around alsa-lib. don't go messing with the
kernel API, that just doesn't make any sense.

but more importantly, i don't see how any of what you are proposing
aids the use of the aureal vortex 3d processor. a device driver isn't
a library, its code that writes data to registers and handles
interrupts. nothing about OpenAL deals with that side of things.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
