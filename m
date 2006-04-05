From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amixer issues
Date: Wed, 05 Apr 2006 10:36:35 +0200
Message-ID: <20060405083635.GB11178@turing.informatik.uni-halle.de>
References: <1143907666.9228.31.camel@localhost.localdomain>
 <20060404161719.GB18884@turing.informatik.uni-halle.de>
 <1144174060.9472.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A149221
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 10:37:00 +0200 (MEST)
In-reply-to: <1144174060.9472.10.camel@localhost.localdomain>
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
> On Tue, 2006-04-04 at 18:17 +0200, Clemens Ladisch wrote:
> > Adrian McMenamin wrote:
> > > / # amixer -c 0
> > > Invalid card number.
> > > Usage: amixer <options> command
> > 
> > Does /dev/snd/controlC0 exist, and does it point to the control device
> > listed in /proc/asound/devices?
> 
> / # ls -l /dev/snd
> crw-rw-rw-    1 root     sys      116,   0 Apr  4 19:13 controlC0
> 
> / # cat /proc/asound/devices
>   0: [0- 0]: ctl

Looks OK.

What is the output of "strace amixer -c0 controls"?


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
