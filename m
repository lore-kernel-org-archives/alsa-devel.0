From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Questions: hw_param rules in rme9652, hdsp.c, also for hdspm.c ?
Date: Wed, 08 Oct 2003 15:07:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310081907.h98J7NBv032021@oud>
References: <1065636181.3f8451558cf65@iem.at>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 08 Oct 2003 20:03:01 +0200."
             <1065636181.3f8451558cf65@iem.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ritsch@iem.at
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>(in hdsp double speed channels is 13 and ss speed are 26, 
>in hdspm they are 32 and 64)
>
>Why ? Is there a reason to let channels min not to be 1 ?

ALSA kernel drivers mirror hardware capabilities. its not possible to
configure the hardware to use just 1 channel. user space (alsa-lib)
allows use of other numbers of channels.

>B) Rule set channel according to rate
 [ ... ]
>-> So i suggest to set t interval to min=1 (or .channels_min from the subinfo).

same reason.

>C) Rule set rate according to channels:
   [ ... ]
>Why is it not allowed to use single speed wenn less channels than double speed
>can handle are needed ?

same reason.

to repeat: ALSA kernel drivers mirror hardware capabilities. all other
stuff is in user-space, where it can exist just once and be shared
across all cards, without polluting the kernel with policy decisions.
the MADI driver should reflect what the hardware can do, nothing more
and nothing less. alsalib will handle the rest.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
