From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Fri, 03 Mar 2006 03:45:43 -0500
Message-ID: <1141375544.3042.103.camel@mindpipe>
References: <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
	 <20060228170824.GA24675@turing.informatik.uni-halle.de>
	 <61111.217.150.108.178.1141148175.squirrel@newgolddream.dyndns.info>
	 <1141240231.9233.11.camel@localhost.localdomain>
	 <1141241474.5860.183.camel@mindpipe>
	 <1141242058.9233.17.camel@localhost.localdomain>
	 <1141243152.5860.197.camel@mindpipe>
	 <1141244926.9233.32.camel@localhost.localdomain>
	 <1141245699.5860.224.camel@mindpipe>
	 <1141332564.9233.6.camel@localhost.localdomain>
	 <20060303072743.GB8569@turing.informatik.uni-halle.de>
	 <1141371753.9229.0.camel@localhost.localdomain>
	 <1141373567.3042.84.camel@mindpipe>
	 <1141373843.9229.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141373843.9229.4.camel@localhost.localdomain>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-03 at 08:17 +0000, Adrian McMenamin wrote:
> I need a thread because the SH DMAC routine that does the DMA handling
> is not atomic and therefore cannot be started from the trigger
> callback.
> The idea is that the interrupt handler reschedules the worker thread
> which is sleeping in an endless loop... something is very wrong with
> it
> all at the moment though as it causes kernel panics 

Actually this raises an interesting question - if the hardware has no
real DMA and must rely on the copy/silence callbacks to transfer the
data, what should be done in the trigger callback when the PCM is
started?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
