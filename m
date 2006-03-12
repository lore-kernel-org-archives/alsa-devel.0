From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 10:58:02 +0000
Message-ID: <1142161082.9555.0.camel@localhost.localdomain>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
	 <1142126427.9496.56.camel@localhost.localdomain>
	 <1142145536.25358.116.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9E0ED1D5
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 11:58:07 +0100 (MET)
In-Reply-To: <1142145536.25358.116.camel@mindpipe>
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
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 01:38 -0500, Lee Revell wrote:
> On Sun, 2006-03-12 at 01:20 +0000, Adrian McMenamin wrote:
> > > > http://newgolddream.dyndns.info/cgi-bin/cvsweb
> > > > 
> > 
> 
> > 	dreamcastcard->clicks++;
> > 	if (dreamcastcard->clicks == 8) dreamcastcard->clicks = 0;
> 
> dreamcastcard->clicks %= 8
> 
> ;-)
> 
> > 	/* reschedule the timer */
> > 	dreamcastcard->timer.expires = jiffies + 2;
> 
> What exactly do you mean to do here - I suspect there's an unintended
> dependency on HZ.  Do you intend to delay for $FOO ms?

Just copied that off the dummy driver in the kernel but yes it's just an
arbitrary delay



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
