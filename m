From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Wed, 1 Nov 2006 12:05:40 +1100
Message-ID: <17735.62180.65780.364256@cargo.ozlabs.ibm.com>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<s5h4ptkvafz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C4D42C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2006 02:21:01 +0100 (MET)
In-Reply-To: <s5h4ptkvafz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai writes:

> We need no irqsave/irqrestore but here since the function is supposed
> to be called always in schedulable situation.  spin_lock_irq() should
> be enough.

OK.

> Any reason to put extra inline here?  It's no time-critical funciton,
> so let compiler do optimization.

Sure.

> BTW, shoud this go to 2.6.19 although the fix isn't so trivial, or
> could wait for the next?

I don't have a strong feeling either way.  It is a bug fix, but for a
bug which doesn't seem to have affected many people (although perhaps
people were avoiding using capture because it didn't work properly),
but it's not a bug which can lead to any crash or vulnerability as far
as I can see.

Paul.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
