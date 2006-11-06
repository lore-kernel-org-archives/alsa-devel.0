From: Andi Kleen <ak@suse.de>
Subject: Re:
	=?iso-8859-1?q?double_fault_in_2=2E6=2E19rc4-git5_wh?=
	=?iso-8859-1?q?ile=09unplugging/replugging_a_USB_headset?=
Date: Mon, 6 Nov 2006 18:03:42 +0100
Message-ID: <200611061803.42297.ak@suse.de>
References: <200611060220.07024.ak@suse.de> <s5h4ptchdvz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A0FC162
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 18:03:46 +0100 (MET)
In-Reply-To: <s5h4ptchdvz.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> 
> How did it happen?  You plugged out a usb adaptor during xmms is
> running with OSS output mode?

xmms was running yes. But I think the oops happened on replug.

Long story: i had the headset connected during boot and my XMMS
insisted on outputing its music on it, which wasn't intended -- 
i wanted it on the speakers connected to the motherboard sound chip.

So i unplug the headset and restarted alsa initialization,
but it was very unhappy about cleaning up and couldn't initialize
the other sound card. I replugged the headset and then
I got the oops.

-Andi


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
