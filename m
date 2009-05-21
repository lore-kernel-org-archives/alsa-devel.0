From: Chuck Ebbert <cebbert@redhat.com>
Subject: [patch] ALSA: fix audio on HP TX25xx series notebooks
Date: Thu, 21 May 2009 18:32:59 -0400
Message-ID: <20090521183259.61dc1305@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id F0F5E2456F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 00:33:28 +0200 (CEST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4LMXPqZ017936
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 18:33:27 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4LMXOwt018358
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 18:33:25 -0400
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com
	[10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4LMXN1v021816
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 18:33:24 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA: fix audio on HP TX25xx series notebooks

Fixes https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4121

Taken from https://bugzilla.redhat.com/show_bug.cgi?id=498060

Signed-off-by: Adam Williamson <awilliam@redhat.com>

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12058,6 +12058,7 @@
 	SND_PCI_QUIRK(0x1028, 0x0253, "Dell OEM", ALC268_DELL),
 	SND_PCI_QUIRK(0x1028, 0x02b0, "Dell Inspiron Mini9", ALC268_DELL),
 	SND_PCI_QUIRK(0x103c, 0x30cc, "TOSHIBA", ALC268_TOSHIBA),
+	SND_PCI_QUIRK(0x103c, 0x30f1, "HP TX25xx series", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x1043, 0x1205, "ASUS W7J", ALC268_3ST),
 	SND_PCI_QUIRK(0x1179, 0xff10, "TOSHIBA A205", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x1179, 0xff50, "TOSHIBA A305", ALC268_TOSHIBA),
