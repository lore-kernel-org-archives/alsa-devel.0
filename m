From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 01:38:55 -0500
Message-ID: <1142145536.25358.116.camel@mindpipe>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
	 <1142126427.9496.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 36C96144
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 07:38:58 +0100 (MET)
In-Reply-To: <1142126427.9496.56.camel@localhost.localdomain>
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
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 01:20 +0000, Adrian McMenamin wrote:
> > > http://newgolddream.dyndns.info/cgi-bin/cvsweb
> > > 
> 

> 	dreamcastcard->clicks++;
> 	if (dreamcastcard->clicks == 8) dreamcastcard->clicks = 0;

dreamcastcard->clicks %= 8

;-)

> 	/* reschedule the timer */
> 	dreamcastcard->timer.expires = jiffies + 2;

What exactly do you mean to do here - I suspect there's an unintended
dependency on HZ.  Do you intend to delay for $FOO ms?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
