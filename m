From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix single internal mic on ALC275
	(Sony Vaio VPCSB1C5E)
Date: Thu, 07 Apr 2011 11:59:12 +0200
Message-ID: <4D9D8AF0.6000208@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040806060705030004040103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B4806103856
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 11:59:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040806060705030004040103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Codec information available here: 
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/752792/+attachment/1989746/+files/Card0.Codecs.codec.0.txt

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040806060705030004040103
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-single-internal-mic-on-ALC275-Sony-Vaio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-single-internal-mic-on-ALC275-Sony-Vaio.pa";
 filename*1="tch"

>From ff0f34b61eb6fec456de8e589bde3b6b05af97e1 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 7 Apr 2011 11:43:00 +0200
Subject: [PATCH] ALSA: HDA: Fix single internal mic on ALC275 (Sony Vaio VPCSB1C5E)

In cases where there is only one internal mic connected to ADC 0x11,
alc275_setup_dual_adc won't handle the case, so we need to add the
ADC node to the array of candidates.

Cc: stable@kernel.org
BugLink: http://bugs.launchpad.net/bugs/752792
Reported-by: Vincenzo Pii
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 12c6f45..d9f1ef7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14124,7 +14124,7 @@ static hda_nid_t alc269vb_capsrc_nids[1] = {
 };
 
 static hda_nid_t alc269_adc_candidates[] = {
-	0x08, 0x09, 0x07,
+	0x08, 0x09, 0x07, 0x11,
 };
 
 #define alc269_modes		alc260_modes
-- 
1.7.4.1


--------------040806060705030004040103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040806060705030004040103--
