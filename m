From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Sun, 29 Oct 2006 21:47:18 +1100
Message-ID: <17732.34486.450034.459264@cargo.ozlabs.ibm.com>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162111764.14051.32.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB98B296
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 11:47:26 +0100 (MET)
In-Reply-To: <1162111764.14051.32.camel@johannes.berg>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

Johannes Berg writes:

> Maybe we should clear the S0 bit and then check if it's active?

That's what I do, exactly.

> Clearing the S0 bit when the DMA engine has already stopped doesn't make
> a difference, and when it is still active we want to clear S0 in this
> 'play again case' anyway. Then if we clear it and check the ACTIVE bit
> afterwards we can be sure that if it is still set the engine will
> continue running.

The possible race is that the DBDMA might see the S0 bit set just
before we clear it, but it will still take a little while for it to do
the branch, fetch the stop command, and execute it.  So it is possible
that we clear S0 and then check the ACTIVE bit and see that it is
still set, but in fact the DBDMA did see the S0 bit set and is in the
process of stopping, and if we do nothing it will stop and the input
or output will stall.

That's why I put the udelay(10) in there.  It may be possible to do
better by telling the DBDMA to do a flush and looking at the status
words in the DBDMA command list.  If we see the status from the flush
then the DBDMA didn't see S0; if the DBDMA stops before writing out
the status from the flush then it did see it.  However, the udelay
seems to work OK and is simple.

Regards,
Paul.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
