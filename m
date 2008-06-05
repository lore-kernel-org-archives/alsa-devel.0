From: linux@audioscience.com
Subject: [PATCH - ASIHPI 3/8] Replace hpimod.c with hpioctl.c
Date: Thu, 05 Jun 2008 16:06:56 +1200
Message-ID: <1212638821-2779-3-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 475E924562
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:03 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:02 +1200 (NZST)
In-reply-to: <1212638821-2779-2-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <linux@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/Makefile b/pci/asihpi/Makefile
index 6d81cab..942dd84 100644
--- a/pci/asihpi/Makefile
+++ b/pci/asihpi/Makefile
@@ -5,7 +5,7 @@ endif
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
-snd-asihpi-objs := asihpi.o hpimod.o hpimsginit.o\
+snd-asihpi-objs := asihpi.o hpioctl.o hpimsginit.o\
 	hpicmn.o hpifunc.o hpidebug.o hpidspcd.o\
 	hpios_linux_kernel.o hpi6000.o hpi6205.o hpimsgx.o
 
-- 
1.5.4.3
