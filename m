From: Gert Vervoort <gert.vervoort@hccnet.nl>
Subject: VIA VT8237
Date: Wed, 02 Jun 2004 22:48:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40BE3D0E.5050804@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The following patch adds a reference to the VIA VT8237 southbridge:

--- via82xx.c.orig      2004-06-02 22:09:04.509536136 +0200
+++ via82xx.c   2004-06-02 22:40:35.773020384 +0200
@@ -136,6 +136,7 @@
 #define VIA_REV_8233           0x30    /* 2 rec, 4 pb, 1 multi-pb, spdif */
 #define VIA_REV_8233A          0x40    /* 1 rec, 1 multi-pb, spdf */
 #define VIA_REV_8235           0x50    /* 2 rec, 4 pb, 1 multi-pb, spdif */
+#define VIA_REV_8237           0x60    /* 2 rec, 4 pb, 1 multi-pb, spdif */
 
 /*
  *  Direct registers
@@ -2070,6 +2071,7 @@
        { VIA_REV_8233, "VIA 8233", TYPE_VIA8233 },
        { VIA_REV_8233A, "VIA 8233A", TYPE_VIA8233A },
        { VIA_REV_8235, "VIA 8235", TYPE_VIA8233 },
+       { VIA_REV_8237, "VIA 8237", TYPE_VIA8233 },
 };
 
 /*

When playing back 6 channel audio on this card, it looks like the rear 
left/right and center/LFE are switched.

Gert



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
