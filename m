From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [Jackit-devel] One drop-out per xrun?
Date: Wed, 10 Dec 2003 22:00:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312110300.hBB300vq020366@oud.linuxaudiosystems.com>
References: <000601c3bf73$c2cbb460$264440ab@roboserv1>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 10 Dec 2003 15:17:20 PST."
             <000601c3bf73$c2cbb460$264440ab@roboserv1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rcassidy@stanford.edu
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I wanted to check my knowledge of something: does an xrun necessarily
>correspond to a "drop-out" in the audio stream?  In other words, could
>you have a drop-out WITHOUT an xrun, or an xrun WITHOUT a drop-out?  Is
>there a strict one-to-one correspondence between the two?

a dropout occurs when the h/w playback pointer gets ahead of the data
already written by the s/w (i.e. repeating data already played). its
therefore a 1:1 correspondence with an xrun, which is defined in the
same way.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
