From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Can't set 88.2/96kHz samplerate with Hammerfall
Date: Fri, 05 Dec 2003 09:30:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312051430.hB5EUFfj025740@oud.linuxaudiosystems.com>
References: <XFMail.20031205145725.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 05 Dec 2003 14:57:25 +0100."
             <XFMail.20031205145725.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Arve Knudsen <aknuds-1@broadpark.no>, alsa-devel@lists.sourceforge.net, Mark Knecht <mknecht@controlnet.com>
List-Id: alsa-devel@alsa-project.org

>
>> Actually, I'm not completely opposed to the idea. But I am totally
>> clueless when it comes to writing device drivers, and would have no
>> idea where to start.
>
>Start here: http://www.alsa-project.org/documentation.php3#Driver
>
>You don't have to start writing the driver from scratch. You only
>have to fix the current driver so you can also select 96KHz from
>the PCM interface. The API is not difficult to learn.

there's almost no API work to do. the problem is really simple and
already solved in a closely related driver.

when you change between an SS (44.1/48) and DS rate (88.2/96), it
changes the channel count. this would be a bad thing if the PCM device
is open, because it alters all the addresses of the channel buffers
etc. etc. so the driver prevents you from doing this if the PCM device
is open. this creates a paradox, because you've already got the device
open.

the hdsp driver takes a different approach to this, even though it
faces an identical problem. its a better design, one based on our
experience with the digi9652 driver and its shortcomings. i'd love to
go in and fix the digi9652, but short of some compelling reason for me
to do so, with the work on ardour+jack at the level it is right now, i
just don't have time.

>> Do you know if RME were forthcoming with specs?
>
>I asked for infos one year ago, but they just said no.

they don't want to get involved with lots of people being sent
specs. the driver itself is the best source of documentation - its
more accurate than the information they sent me :)

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
