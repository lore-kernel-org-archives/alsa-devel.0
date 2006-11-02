From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Fri, 3 Nov 2006 08:54:00 +1100
Message-ID: <17738.26872.275355.217147@cargo.ozlabs.ibm.com>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162456168.3241.2.camel@ux156>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B77472A7
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2006 23:25:26 +0100 (MET)
In-Reply-To: <1162456168.3241.2.camel@ux156>
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

> Something that just crossed my mind because Ben was complaining about
> suspend/resume breakage... In the suspend case we actually have to make
> sure to have DMA stopped, no?

True.  Can the trigger function sleep in the suspend case?  And
presumably the resume trigger should only restart the DMA if it was
running when the suspend trigger was called, but how does it know
that?

Paul.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
