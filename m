From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Couple of questions
Date: Fri, 17 Mar 2006 18:46:21 -0500
Message-ID: <1142639182.25258.126.camel@mindpipe>
References: <1142467271.9298.7.camel@localhost.localdomain>
	 <s5hirqer7r5.wl%tiwai@suse.de>
	 <1142552045.9236.9.camel@localhost.localdomain>
	 <1142554597.9395.25.camel@mindpipe> <s5hirqdv0oj.wl%tiwai@suse.de>
	 <1142627252.9449.9.camel@localhost.localdomain>
	 <s5hr750stlr.wl%tiwai@suse.de>
	 <1142638164.9449.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 47FBB1BB
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 00:46:34 +0100 (MET)
In-Reply-To: <1142638164.9449.16.camel@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-17 at 23:29 +0000, Adrian McMenamin wrote:
> 
> So, just to be clear. When I am transferring a "period" I should
> actually stream half a period's worth of bytes into the channel
> playing
> the left and half a period into the right - and can advance each dma
> transfer through the buffer by half a period length on both the left
> and
> the right side of the buffer 

No, one period.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
