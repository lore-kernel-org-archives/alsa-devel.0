From: Pawel Krzesniak <pawel.krzesniak@gmail.com>
Subject: Re: [PATCH] add the nvidia HDMI
	codec	driverfor	MCP77/79
Date: Fri, 26 Sep 2008 12:22:51 +0200
Message-ID: <48DCB7FB.3010700@gmail.com>
References: <200809031558156739794@gmail.com><s5hhc8xpq6z.wl%tiwai@suse.de><15F501D1A78BD343BE8F4D8DB854566B31F8F744@hkemmail01.nvidia.com><s5h4p4xph6x.wl%tiwai@suse.de><48BE7EE4.8020800@insite.cz><s5h63ouvpfc.wl%tiwai@suse.de><15F501D1A78BD343BE8F4D8DB854566B3332408C@hkemmail01.nvidia.com><s5hljxky01t.wl%tiwai@suse.de><15F501D1A78BD343BE8F4D8DB854566B33942E5A@hkemmail01.nvidia.com>	<s5h63oktur5.wl%tiwai@suse.de>
	<15F501D1A78BD343BE8F4D8DB854566B33943353@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020304060503040802040300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 6315E10380E
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 12:22:59 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1302010fka.0
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 03:22:59 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B33943353@hkemmail01.nvidia.com>
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

This is a multi-part message in MIME format.
--------------020304060503040802040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

did we forgot alsa-driver/pci/hda/patch_nvhdmi.c file?

this is my first posting to the list so be tolerant, please.

regards,
-- 
Pawel

--------------020304060503040802040300
Content-Type: text/plain;
 name="0001-Missing-file-for-NVIDIA-HDMI-HD-audio-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Missing-file-for-NVIDIA-HDMI-HD-audio-support.patch"

>From bc19dfbcc8458ebecd8f458b6566ccef119a3d4c Mon Sep 17 00:00:00 2001
From: Pawel Krzesniak <pawel.krzesniak@gmail.com>
Date: Fri, 26 Sep 2008 11:39:02 +0200
Subject: [PATCH] Missing file for NVIDIA HDMI HD-audio support.

Missing file for NVIDIA HDMI HD-audio support.

Signed-off-by: Pawel Krzesniak <pawel.krzesniak@gmail.com>
---
 pci/hda/patch_nvhdmi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 pci/hda/patch_nvhdmi.c

diff --git a/pci/hda/patch_nvhdmi.c b/pci/hda/patch_nvhdmi.c
new file mode 100644
index 0000000..3e700fd
--- /dev/null
+++ b/pci/hda/patch_nvhdmi.c
@@ -0,0 +1,3 @@
+#define __NO_VERSION__
+#include "adriver.h"
+#include "../../alsa-kernel/pci/hda/patch_nvhdmi.c"
-- 
1.5.4.3


--------------020304060503040802040300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020304060503040802040300--
