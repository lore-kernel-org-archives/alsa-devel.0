From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 0/8] snd-aoa: add snd-aoa
Date: Thu, 01 Jun 2006 13:58:44 +0200
Message-ID: <20060601115844.343214000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5BCAD140
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 15:06:12 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

The following patches would add snd-aoa to the Linux source tree. I'm
posting them here in the spirit of getting review fairly early, it works
fine for those machines it handles and even implements headphone/line-out
detection now.

One thing that still needs to be done is fix this on the mac-mini where
apparently some things are missing from the device-tree, and on the
PowerMac7,2/7,3 where the device tree has a bug that prevents the i2sbus
module from working properly.

Other than that, it replaces snd-powermac for all layout-id machines, and
handles many more already, so once those two issues are fixed I'll also add
a patch to this patchset that removes support for any machines with a
layout-id from snd-powermac to allow snd-aoa and snd-powermac to coexist
nicely.

Any comments are appreciated.

--
