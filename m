From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-driver annoyance
Date: Mon, 17 Apr 2006 14:01:06 +0200
Message-ID: <20060417120106.GA25991@turing.informatik.uni-halle.de>
References: <1145048699.9434.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 503A3199
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 14:01:10 +0200 (MEST)
In-reply-to: <1145048699.9434.7.camel@localhost.localdomain>
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
> I am cross compiling alsa driver for use on an NFS root mounted
> partition hosted on my development box for use by a box running a 2.6.15
> kernel - the development box uses a 2.6.12 kernel
> 
> Alsa-driver insists on creating a 2.6.15 modules directory on the
> development box hierarchy and then installing modules in that directory
> and not in the NFS root partition.

What are the parameters and the output of the configure script?


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
