From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: periods,packets and driver patterns not to mention patience!!!
Date: Fri, 09 Apr 2004 11:43:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404091543.i39FhJFa031807@dhin.linuxaudiosystems.com>
References: <20040409151357.81599.qmail@web25109.mail.ukl.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 09 Apr 2004 16:13:57 BST."
             <20040409151357.81599.qmail@web25109.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Given that the alsa driv interrupts at period
>boundaries(which are defined in bytes), the tests i
>have carried out prove otherwise..i.e that the driver
>operates in millisecond power-of-two based periods.

on most PCI-based hardware, the audio interface interrupts every N
audio frames, where N is generally a power of two.

on USB-based hardware, the audio interface interrupts every N
milliseconds. 

asking ALSA for a period size of B bytes and expecting to get that
from the hardware is, uhm, unrealistic. to be honest, i wasn't even
aware that ALSA provided an API for this. 

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
