From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: pcm interfaces questions
Date: Tue, 25 Mar 2003 12:51:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18xsVR-0005cL-00@sc8-sf-list1.sourceforge.net>
References: <XFMail.20030325182413.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 25 Mar 2003 18:24:13 +0100."
             <XFMail.20030325182413.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>snd_pcm_new() has two parameters for the number of substreams
>for playback and capture. 

its a language problem. its not the number of substreams as in "the
quantity of substreams". rather, it means "the ID of the substream".

>			   Yes, but what does it mean ? If I
>have N playback substreams, can I service N applications that
>use one stream ? Can channels be allocated on demand, to allow
>the user to use 4 xmms or 1 xmms and a dvd player (5.1) at the
>same time ? :))

this depends on (1) whether the underlying hardware supports it and
(2) whether you use a "dmix" PCM device rather than a "hw" PCM
device. the "hw" PCM device only offers the capabilities of the
hardware, nothing more.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
