From: linux@audioscience.com
Subject: [PATCH - ASIHPI 4/8] Include pci table again,
 avoiding warning about extern.
Date: Thu, 05 Jun 2008 16:06:57 +1200
Message-ID: <1212638821-2779-4-git-send-email-linux@audioscience.com>
References: <1212638821-2779-1-git-send-email-linux@audioscience.com>
	<1212638821-2779-2-git-send-email-linux@audioscience.com>
	<1212638821-2779-3-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 0237F2448A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 06:07:04 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1Z0043N23FR170@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jun 2008 16:07:03 +1200 (NZST)
In-reply-to: <1212638821-2779-3-git-send-email-linux@audioscience.com>
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

diff --git a/pci/asihpi/hpimsgx.c b/pci/asihpi/hpimsgx.c
index ac56a24..b843e9f 100644
--- a/pci/asihpi/hpimsgx.c
+++ b/pci/asihpi/hpimsgx.c
@@ -25,7 +25,9 @@ Extended Message Function With Response Cacheing
 #include "hpimsgx.h"
 #include "hpidebug.h"
 
-extern struct pci_device_id asihpi_pci_tbl[];	/* hpimod.c mod device tbl */
+static struct pci_device_id asihpi_pci_tbl[] = {
+#include "hpipcida.h"
+};
 
 static struct hpios_spinlock msgxLock;
 
-- 
1.5.4.3
