From: "Wolke Liu" <wolke.liu@amd.com>
Subject: [patch]Add ATI RS780,R600 HDMI audio support
Date: Fri, 27 Apr 2007 18:04:47 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201927679@shacnexch2.atitech.com>
References: <20070426171643.GA27510@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16]) by alsa0.perex.cz (Postfix) with ESMTP id 2762024B18
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 12:05:03 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <20070426171643.GA27510@roarinelk.homelinux.net>
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
Cc: Takashi Iwai <tiwai@suse.de>, Yufei Ma <yufei.ma@amd.com>
List-Id: alsa-devel@alsa-project.org

This patch is for ATI RS780 and R600 HDMI support.
Signed-off-by: Wolke Liu <wolke.liu <at> amd.com>

diff -r 67cb6a84c18a pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c       Fri Apr 20 16:11:43 2007 +0200
+++ b/pci/hda/hda_intel.c       Fri Apr 27 04:56:54 2007 -0400
@@ -88,6 +88,8 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},
                         "{ATI, SB600},"
                         "{ATI, RS600},"
                         "{ATI, RS690},"
+                        "{ATI, RS780},"
+                        "{ATI, R600},"
                         "{VIA, VT8251},"
                         "{VIA, VT8237A},"
                         "{SiS, SIS966},"
@@ -1770,6 +1772,8 @@ static struct pci_device_id azx_ids[] =
        { 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
}, /* ATI SB600 */
        { 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */
        { 0x1002, 0x7919, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS690 HDMI */
+       { 0x1002, 0x960c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS780 HDMI */
+       { 0x1002, 0xaa00, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI R600 HDMI */
        { 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
        { 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
        { 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
diff -r 67cb6a84c18a pci/hda/patch_atihdmi.c
--- a/pci/hda/patch_atihdmi.c   Fri Apr 20 16:11:43 2007 +0200
+++ b/pci/hda/patch_atihdmi.c   Fri Apr 27 04:57:29 2007 -0400
@@ -173,6 +173,7 @@ static int patch_atihdmi(struct hda_code
  */
 struct hda_codec_preset snd_hda_preset_atihdmi[] = {
        { .id = 0x1002793c, .name = "ATI RS600 HDMI", .patch =
patch_atihdmi },
-       { .id = 0x1002791a, .name = "ATI RS690 HDMI", .patch =
patch_atihdmi },
+       { .id = 0x1002791a, .name = "ATI RS690/780 HDMI", .patch =
patch_atihdmi },
+       { .id = 0x1002aa01, .name = "ATI R600 HDMI", .patch =
patch_atihdmi },
        {} /* terminator */
 };
