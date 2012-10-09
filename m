From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2.6.32.y,
 2.6.34.y] ALSA: hda - ALSA HD Audio patch for Intel Panther Point
 DeviceIDs
Date: Mon, 8 Oct 2012 18:07:34 -0700
Message-ID: <20121009010734.GA24147@elie.Belkin>
References: <201104201059.57882.seth.heasley@intel.com>
 <s5htydsiw20.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3163126520E
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 03:07:51 +0200 (CEST)
Received: by mail-da0-f51.google.com with SMTP id t11so1816354daj.38
 for <alsa-devel@alsa-project.org>; Mon, 08 Oct 2012 18:07:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5htydsiw20.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Seth Heasley <seth.heasley@intel.com>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ana Guerrero <ana@debian.org>, Willy Tarreau <w@1wt.eu>
List-Id: alsa-devel@alsa-project.org

From: Seth Heasley <seth.heasley@intel.com>
Date: Wed, 20 Apr 2011 10:59:57 -0700

commit d2edeb7c6f1dada8ca7d5c23e42d604e92ae0c76 upstream.

This patch adds the HD Audio Controller DeviceIDs for the Intel Panther Point PCH.

[jn: backported for 2.6.32.y by Ana Guerrero]

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Ana Guerrero <ana@debian.org> # EliteBook 8570w
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Willy and Paul,

Please consider

  d2edeb7c6f1d ALSA: hda - ALSA HD Audio patch for Intel Panther Point
               DeviceIDs

for application to the 2.6.32.y and 2.6.34.y trees.

It does what it says on the cover.  The patch was merged in the 3.0
cycle, so newer stable kernels don't need it.  Backported and
tested[1] against Debian's 2.6.32.y-based kernel by Ana (cc-ed) --
thanks!

Thoughts of all kinds welcome, as always.

Regards,
Jonathan

[1] http://bugs.debian.org/689928

 sound/pci/hda/hda_intel.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3cf21ffc7c5f..dc812838ea8b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -126,6 +126,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
 			 "{Intel, ICH10},"
 			 "{Intel, PCH},"
 			 "{Intel, CPT},"
+			 "{Intel, PPT},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
@@ -2730,6 +2731,8 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x8086, 0x3b57), .driver_data = AZX_DRIVER_ICH },
 	/* CPT */
 	{ PCI_DEVICE(0x8086, 0x1c20), .driver_data = AZX_DRIVER_PCH },
+	/* Panther Point */
+	{ PCI_DEVICE(0x8086, 0x1e20), .driver_data = AZX_DRIVER_PCH },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b), .driver_data = AZX_DRIVER_SCH },
 	/* ATI SB 450/600 */
-- 
1.7.10.4
