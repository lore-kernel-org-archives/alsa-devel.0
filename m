From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: How to detect whether OSS mixer is emulated by ALSA
Date: Sat, 05 Apr 2003 11:40:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E191qfA-0001Fp-00@sc8-sf-list1.sourceforge.net>
References: <200304051821.19599.c.esken@cityweb.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 05 Apr 2003 18:21:19 +0200."
             <200304051821.19599.c.esken@cityweb.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Esken <c.esken@cityweb.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>my mixer (kmix) supports OSS and ALSA at the same time. This is good for a 
>mixed-mode environment (e.g. if there is a TV card w/o ALSA support).
>
>Unfortunately this means that kmix finds some mixers twice.
>- One time the real thing (ALSA)
>- One time the OSS-emulation
>
>This will confuse users.
>
>Is there any way to find out those OSS mixers which are just emulated?

check for the existence of /proc/asound and the absence of
/proc/sndstat. if the first is there and the second is not, then any
OSS mixers are emulated.

--p



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
