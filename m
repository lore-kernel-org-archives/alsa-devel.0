From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel threads etc
Date: Tue, 07 Mar 2006 16:36:02 -0500
Message-ID: <1141767363.767.76.camel@mindpipe>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
	 <1141688891.25487.91.camel@mindpipe>
	 <1141690313.9230.32.camel@localhost.localdomain>
	 <1141690930.25487.104.camel@mindpipe>
	 <1141766382.9232.10.camel@localhost.localdomain>
	 <1141766941.767.73.camel@mindpipe>
	 <1141767139.9232.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C5B18196
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 22:36:05 +0100 (MET)
In-Reply-To: <1141767139.9232.17.camel@localhost.localdomain>
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

On Tue, 2006-03-07 at 21:32 +0000, Adrian McMenamin wrote:
> Because you or someone else in an earlier conversation suggested most
> people partitioned their buffer in this way. makes no odds :)
> 

That's just because it's simpler to explain how ALSA drivers work if you
assume two periods per buffer, and because most hardware supports it and
it gives the lowest latency.  But if your hardware doesn't support two
periods per buffer then you can't do it.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
