From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: emufx.c bug/LiveDrive capture is finally working
Date: Sat, 6 Dec 2003 18:09:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S18298AbTLFQJB/20031206160901Z+8248@nic.funet.fi>
References: <E1AQu78-0006RG-00@sc8-sf-list2.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1AQu78-0006RG-00@sc8-sf-list2.sourceforge.net>
	(alsa-devel-request@lists.sourceforge.net)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From:	Juhana Sadeharju <kouhia@nic.funet.fi>
>
>  Line2/Mic2 LiveDrive: 100 <rec>
>  Line2/Mic2 LiveDrive Capture: 100
>  Aux2 LiveDrive: 0 <no rec>
>  Aux2 LiveDrive Capture: 0

I noticed that Peter Zubaj already provided the patch a few days ago.
But, could those names appearing in Alsamixer be changed to the names
suggested above? Like having the same names what appears in the
front panel of LiveDrive; no guesswork required in setting the mixer.

 Line2/Mic2 == EXTIN_LINE1
       Aux2 == EXTIN_LINE2

Regards,
Juhana


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
