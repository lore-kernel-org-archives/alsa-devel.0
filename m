From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: kernel threads etc
Date: Tue, 07 Mar 2006 23:28:53 +0000
Message-ID: <1141774133.9232.31.camel__7178.78232612765$1141774217$gmane$org@localhost.localdomain>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
	 <1141688891.25487.91.camel@mindpipe>
	 <1141690313.9230.32.camel@localhost.localdomain>
	 <1141690930.25487.104.camel@mindpipe>
	 <1141766382.9232.10.camel@localhost.localdomain>
	 <1141766941.767.73.camel@mindpipe>
	 <1141767139.9232.17.camel@localhost.localdomain>
	 <1141767363.767.76.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 1D5681BA
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2006 00:29:00 +0100 (MET)
In-Reply-To: <1141767363.767.76.camel@mindpipe>
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

On Tue, 2006-03-07 at 16:36 -0500, Lee Revell wrote:
> On Tue, 2006-03-07 at 21:32 +0000, Adrian McMenamin wrote:
> > Because you or someone else in an earlier conversation suggested most
> > people partitioned their buffer in this way. makes no odds :)
> > 
> 
> That's just because it's simpler to explain how ALSA drivers work if you
> assume two periods per buffer, and because most hardware supports it and
> it gives the lowest latency.  But if your hardware doesn't support two
> periods per buffer then you can't do it.
> 

I've done this and now I have a familiar problem - I can play out quite
long samples, but they loop around for ever - for some reason 'close' is
not being called on the /dev/dsp device file



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
