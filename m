From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Alsa + 2.6 kernel + Program freezee
Date: Sun, 19 Oct 2003 12:06:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310191606.h9JG6hKx030568@oud.linuxaudiosystems.com>
References: <200310171255.26909.boci@coder.hu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 17 Oct 2003 12:55:26 +0200."
             <200310171255.26909.boci@coder.hu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?H=E1ber=20J=E1nos?= <boci@coder.hu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I use kernel 2.6 with Alsa (2.6 kernel internal ALSA). And some program is 
>freezee or going to zombie.
>Example KDE artsd use alsa and some program want to acces it (example 
>MozillaFirebird flash plugin) the accessing program going to zombie. (I try 
>to desable artsD because if I use mplayer and Mozilla, or I rerun mplayer too 
>fast)...
>Anybody have some idea?

you've got hardware that doesn't support multiopen, artsd has it in
use already, and the other program is not opening in non-blocking
mode. this means it waits for the device to be closed by artsd.

shutdown artsd and stop running it. thats my best guess.


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
