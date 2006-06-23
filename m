From: Paul Collins <paul@briny.ondioline.org>
Subject: snd-aoa: headphone detection wonky on PowerBook5,4
Date: Fri, 23 Jun 2006 21:43:58 +1000
Message-ID: <87lkrom70h.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC97B10D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 13:48:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: johannes@sipsolutions.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Where "wonky" means: only unplugging is detected, not plugging.  I'm
not sure why I didn't spot this earlier.  I dug down a bit with printk
to discover that ftr_handle_notify_irq is being called only on unplug.
And the interrupt count in /proc/interrupts increases only on unplug.

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
