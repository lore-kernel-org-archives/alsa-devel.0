From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amixer issues
Date: Tue, 04 Apr 2006 18:17:19 +0200
Message-ID: <20060404161719.GB18884@turing.informatik.uni-halle.de>
References: <1143907666.9228.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0715121E
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 18:17:51 +0200 (MEST)
In-reply-to: <1143907666.9228.31.camel@localhost.localdomain>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> I have a working sound card with a working (if basic) PCM mixer:
> 
> /proc/asound # cat cards
> 0 [AICA           ]: snd_card_aica - AICA
>                      Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast
> 
> but when I try to use amixer nothing seems to work:
> 
> / # amixer -c 0
> Invalid card number.
> Usage: amixer <options> command

Does /dev/snd/controlC0 exist, and does it point to the control device
listed in /proc/asound/devices?


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
