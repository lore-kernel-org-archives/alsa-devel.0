From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Wed, 22 Oct 2003 13:39:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
References: <20031022162219.GA29956@chapus.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 22 Oct 2003 12:22:19 EDT."
             <20031022162219.GA29956@chapus.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Eloy A. Paris" <peloy@chapus.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>This problem happens randomly but is very annoying, specially if I
>program my PVR (MythTV) to automatically record a show - the show can
>get recorded with metallic sound, which makes it very hard to understand
>during playback.
>
>This is not MythTV-specific since I have been able to reproduce the
>problem using other applications, like the Gnome sound recorder. It is
>unrelated to full-duplex operation since when recording a show MythTV
>doesn't open /dev/dsp for writing.
>
>I really have no idea about how to troubleshoot this. I don't think
>the problem is hardware, but is driver-related instead.

its almost certainly a software problem in mythTV and gnome sound
recorder. i've written code that does this several times - every time
it takes me ages to figure out why, and then i can never remember when
i do it the next time. its related to off-by-1 errors in processing
incoming audio.

not necessarily, of course, just a point of view.



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
