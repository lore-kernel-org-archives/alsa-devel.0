From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: fatal oops in current CVS confirmed
Date: Mon, 10 Mar 2003 09:17:08 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18sO2D-0003sB-00@sc8-sf-list1.sourceforge.net>
References: <s5h65qr5nr7.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 10 Mar 2003 14:56:12 +0100."
             <s5h65qr5nr7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>oops, sorry.  the bug had lived more than two months, so i wonder why 
>this wasn't reported at all... 

  [ ... ]

>yes, and please remember that 0.9.0-final is not the final for ALSA.
>we'll be able to release the fixed version ASAP.
>
>i guess you won't expect that, for example, the 2.6.0 kernel is
>so perfect that all components work without any bugs :)

oh sure. i mean, i've known for more than 1 year that the PCM output
on the cs4231 driver doesn't work anymore (at least not for the
tropez+), but that's not going to get fixed any time soon, i
suspect. someone has to get 0.5 installed, add some code to print all
the registers, and then figure out why 0.9 doesn't do the right thing.

i wonder who that will be :)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
