From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Mon, 06 Nov 2006 11:50:57 +0100
Message-ID: <1162810257.2762.19.camel@ux156>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162456168.3241.2.camel@ux156>
	<17738.26872.275355.217147@cargo.ozlabs.ibm.com>
	<1162508394.3381.4.camel@johannes.berg> <s5hy7qosvv6.wl%tiwai@suse.de>
	<17743.4433.435455.686127@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31045242
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 11:49:50 +0100 (MET)
In-Reply-To: <17743.4433.435455.686127@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-11-06 at 21:41 +1100, Paul Mackerras wrote:

> OK, this sounds like the suspend trigger should just abort the DMA, on
> the basis that the hardware will get reset in the suspend/resume
> process and so there will be no bytes queued up to cause trouble
> later.  I'll whip up a patch.

I think we should cleanly stop the hardware in this case as well, for
suspend to disk I think it can happen that we suspend the driver and
then suspend is aborted. Not entirely sure about this though.

Btw. What happens when we abort the DMA engine, reset the command
pointer to a stop command, and start it again? Does it drain the FIFO
properly? I'm thinking it should, but ...

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
