From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: capture with non-interleaved mode
Date: Thu, 16 Oct 2003 08:04:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310161204.h9GC4KHA013898@oud>
References: <1066244996.3f8d9b8432ca9@webmail.utbm.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Oct 2003 21:09:56 +0200."
             <1066244996.3f8d9b8432ca9@webmail.utbm.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Cyril.Coquilleau@UTBM.fr" <Cyril.Coquilleau@utbm.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I've not managed to fix this bug into my program... Do you see the error on my
> 
>code (bad soundcard initialization or other) or have you got another way to 
>propose me to capture the two channels of my soundcard separately ?

try increasing BUF_SIZE to 4096 and see what happens. 128
frames/period is in seriously low-latency territory, and i doubt that
your program is designed for that. if i was to make a guess, you
probably try to write to disk after reading from the audio interface,
in the same thread, yes? sorry, you can't do that for 128
frames/period, and a general design rule, you shouldn't ever do it
(though it obviously works for some simple programs with just stereo
in).

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
