From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (0/2)
Date: Tue, 26 Jul 2005 12:47:05 +0200
Message-ID: <200507261247.05684.rjw__30020.7618195147$1122375577$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.sisk.pl (grendel.sisk.pl [217.67.200.140])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 93C9B1C1
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 12:58:30 +0200 (MEST)
Received: from mail.sisk.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 30188-02 for <alsa-devel@alsa-project.org>;
 Tue, 26 Jul 2005 12:50:31 +0200 (CEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The following two patches are necessary to prevent my box (Asus L5D) from
hanging solid during resume from disk.

The problem is that, apparently, some out-of-order interrupts may be
generated during resume and if some drivers do not call free_irq() on
suspend, these interrupts are mishandled.  For reference please see
http://bugzilla.kernel.org/show_bug.cgi?id=4416
and
http://sourceforge.net/mailarchive/message.php?msg_id=12448907

The first patch adds free_irq() and request_irq() to the suspend and resume
routines, respectively, in the snd_intel8x0 driver.

The second one adds basic suspend/resume support to the sk98lin driver.

Please consider for applying,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
