From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amixer issues
Date: Tue, 04 Apr 2006 18:56:06 +0200
Message-ID: <20060404165606.GC18884@turing.informatik.uni-halle.de>
References: <1143907666.9228.31.camel@localhost.localdomain>
 <20060404161719.GB18884@turing.informatik.uni-halle.de>
 <1144168240.26668.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3474B1A1
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 18:56:18 +0200 (MEST)
In-reply-to: <1144168240.26668.6.camel@mindpipe>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Tue, 2006-04-04 at 18:17 +0200, Clemens Ladisch wrote:
> > Does /dev/snd/controlC0 exist, and does it point to the control device
> > listed in /proc/asound/devices?
> 
> $ ls -al /dev/snd/controlC0
> crw-rw---- 1 root audio 116, 0 Apr  1 10:06 /dev/snd/controlC0
> 
> $ cat /proc/asound/devices 
>   0: [ 0]   : control
>   ...
> 
> Can you please clarify?  How does a device node "point to" something?

The minor number of the device node (here: 0) must be the same as the
minor number of the actual device.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
