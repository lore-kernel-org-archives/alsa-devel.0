From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel threads etc
Date: Mon, 06 Mar 2006 19:22:09 -0500
Message-ID: <1141690930.25487.104.camel@mindpipe>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
	 <1141688891.25487.91.camel@mindpipe>
	 <1141690313.9230.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5D1FB1A1
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 01:22:19 +0100 (MET)
In-Reply-To: <1141690313.9230.32.camel@localhost.localdomain>
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

On Tue, 2006-03-07 at 00:11 +0000, Adrian McMenamin wrote:
> It transfers - without CPU intervention - memory from the SH4 (main
> CPU)
> memory to the ARM7 (sound processing chip) memory (ie the playback
> ring
> buffer). The function simply sets the register values and off it goes
> 
> 

OK - so it's the same DMA I am familiar with, it just needs to be
reprogrammed every period - IOW you can't tell it "repeatedly transfer
audio to this location until I tell you to stop".

If this is the case then I would say forget about the kernel thread and
the copy/silence callbacks - just do all the work in the interrupt
handler.

Lee







-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
