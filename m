From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Mono to stereo ?
Date: Thu, 27 Mar 2003 06:43:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18yVi8-0003Mx-00@sc8-sf-list1.sourceforge.net>
References: <XFMail.20030327122719.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 27 Mar 2003 12:27:19 +0100."
             <XFMail.20030327122719.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>When an application opens a mono substream, the sound has to
>be sent to one channel only or must the low level driver
>transparently convert it to stereo ?

one channel only.

in ALSA, low level drivers do not do any kind of format
conversion. that is accomplished (if necessary) by code running in
user-space, typically part of alsa-lib. the low level driver simply
advertises the capabilities of the hardware, provides ways to use
those capabilities, and lets the midlevel code and alsa-lib do the rest.

--p



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
