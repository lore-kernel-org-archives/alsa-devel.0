From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 14 Dec 2003 11:38:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312141638.hBEGcpco011444@oud.linuxaudiosystems.com>
References: <3FDC8D16.6070608@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 15 Dec 2003 01:17:26 +0900."
             <3FDC8D16.6070608@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Arve Knudsen <aknuds-1@broadpark.no>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>My opinion is that a simple function could be included in alsactl which 
>scans for available devices, makes a list of their abilities. Everyone 
>uses "post-insert alsactl restore" in the modules.conf file so it would 
>be essentially a non issue from a user perspective.

i think it needs to be slightly more complex than that (because of the
way the configuration space is reduced as various parameters are set).

we need a structure that is somewhat equivalent to hw_params. the
program fills it out, in effect asking for "16 bit, stereo, 48kHz,
1024 frames/period" and then queries to see what devices can satisfy
that. it will be hard for the program to use this if it thinks it can
handle multiple configurations, but there are not many programs that
work this way: most know what configuration they want, and just want
to find devices that can work that way.

otoh, one may counter that the plughw layer in alsa-lib is there to
allow *any* h/w device to be used with *any* configuration, so this is
all a bit ridiculous. 

of course, the devices may be busy, so the program needs to be ready
for that as well (this applies to multiopen cards just the same, even
if its much less likely that they are "fully" busy).


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
