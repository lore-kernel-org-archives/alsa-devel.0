From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP and the hw: interface
Date: Tue, 26 Nov 2002 22:16:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18GsdE-0008Sa-00@sc8-sf-list1.sourceforge.net>
References: <20021126214232.GA18717@dogsolitude.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 26 Nov 2002 16:42:32 EST."
             <20021126214232.GA18717@dogsolitude.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: drclaw@dogsolitude.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Ok, thanks for the line out help, and I think I understand how the
>matrix mixer works, and I can hear stuff through my monitors, but now I
>can't figure out how to get alsa input or output functioning.  I can
>plug in my mic/pre and hear that through the monitors, and I can use the
>oss compatability layer to play oss compatible programs through the
>monitors as well, but whenever I try to use an alsa program with hw:0,0
>(hw:0,some_other_number gets a "this device doesn't exist" error with
>everything) I constantly get something like -
>
>aplay: set_params:781: Access type not available
>
>Other programs give various other errors, when I try aplay with
>plughw:0,0 instead, it outputs the format info and hangs (must ctrl-c).  

this is probably a bug in current ALSA. i can use plughw:0,0 on my
h-dsp/pci and it works with all "native" ALSA apps that i've tried.

does aplay do this?

>Note, again, everything works fine with my ali5451.  Do I have to use
>some other for of addressing to specify the ports I want this all to go
>to?  From previous mail it seems that the matrix mixer deal with audio
>"streams" and physical ports.  I get how you set things in there, but I
>don't get how you tell a program to send its data one on one of these
>"streams" if that's the way it's supposed to work.  Of course then
>there's recording (and do any sample rates above 48kHz work right now?).  

you don't have to adjust the matrix mixer at all to get basic stuff
audible. its necessary *only* to:

	a) adjust the mix being sent to the line outs
	b) do cross-channel routing (e.g. input 23 + playback 16 to
		output 12)

you can use the regular "simple mixer" controls (accessible with any
regular ALSA mixer) to adjust the "matched channel" levels (ie. how
much of playback 16 appears on output 16).

by default, the plughw device will multiplex output across *every*
channel of the hardware device.

--p



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
