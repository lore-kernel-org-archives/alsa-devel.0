From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 07 Dec 2003 14:56:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312071956.hB7Juq18004807@oud.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 07 Dec 2003 20:38:48 +0100."
             <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Arve Knudsen <aknuds-1@broadpark.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>We all think in the same way, but there's no simple solution for this
>problem. I prefer to have such configuration information in an user-space 
>database accessed via an alsa-lib API. It's nothing for the kernel space.

i'm not sure i agree with that. a user-space config DB could be used
to describe the possibilities. but it doesn't address the approach i
outlined where a program can present the *current* state of the
system as configured using the control API.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
