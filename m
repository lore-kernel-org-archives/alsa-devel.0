From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel threads etc
Date: Mon, 06 Mar 2006 19:26:49 -0500
Message-ID: <1141691210.25487.110.camel@mindpipe>
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
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 693141A1
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 01:26:53 +0100 (MET)
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
> > When I think of soundcard DMA I mean that you tell the card where in
> > host memory the buffer is, then to start the DMA, and from then on,
> > until you stop it, the device will automatically write audio into
> that
> > area of host memory until you tell it to stop.
> > 
> By buffer you mean the sound card buffer? I don't have that luxury I'm
> afraid. I've got real dma though, just not of that kind.
> 

Modern PCI soundcards don't have any buffers of their own - all they can
do is DMA to/from host memory.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
