From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Couple of questions
Date: Thu, 16 Mar 2006 19:20:32 -0500
Message-ID: <1142554833.9395.30.camel@mindpipe>
References: <1142467271.9298.7.camel@localhost.localdomain>
	 <s5hirqer7r5.wl%tiwai@suse.de>
	 <1142543316.9236.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 803211BB
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 01:20:35 +0100 (MET)
In-Reply-To: <1142543316.9236.1.camel@localhost.localdomain>
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

On Thu, 2006-03-16 at 21:08 +0000, Adrian McMenamin wrote:
> Thanks. My problem is I cannot get the alsa utilities to compile/work
> (they compile but seg fault on use).

It would be useful to debug this now that your driver works...

>  Is there a good OSS only app I can
> use to test the basic play stuff?
> 

/usr/bin/play.  I thought it used to be an independent app but the one I
have seems to be part of sox.

Or just write one in C, it will take you 5 minutes.  It's basically cat
file.wav > /dev/dsp and just add ioctls to set the format, sample rate,
etc.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
