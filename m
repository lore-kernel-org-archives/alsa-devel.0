From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Query devices in a non-blocking fashion
Date: Mon, 08 Dec 2003 12:04:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312081704.hB8H46oa006023@oud.linuxaudiosystems.com>
References: <20031208161936.310df2cb.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 08 Dec 2003 16:19:36 +0100."
             <20031208161936.310df2cb.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: aknuds-1@broadpark.no, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I don't agree. The control API (usually) is for things that don't affect
>the way data is transferred between the card the the computer. 

it is *now*. i was just imagining a different conception of what it
could be used for.

>								Sample rate,
>format, etc. are used to configure the hardware at the driver level, but
>from the point of view of the application they are attributes of the
>substream. The application has to take them into account. It can't just
>open the PCM device and play/record something without knowing the
>format. 

if the app can't do that, it should first configure the device. no
question about that. the question is: what API do you use to do it? i
was just imagining that the PCM interface doesn't do any of it. this
would then decouple one from the other - you could interrogate
configuration possibilities independently of accessing the PCM device
itself, as arve suggests also.

>									   So
>you'll end up always using two different APIs to do the same things you now
>can do with only one.

i was imagining removing the capability from the PCM API.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
