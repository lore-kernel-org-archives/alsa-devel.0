From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] ALSA: hda - Disable AA-loopback on ALC668
Date: Wed, 14 May 2014 16:31:13 +0200
Message-ID: <1784940.JdFq8Pv96a@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f65.google.com (mail-ee0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF4626007E
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 16:31:18 +0200 (CEST)
Received: by mail-ee0-f65.google.com with SMTP id b57so950834eek.4
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 07:31:18 -0700 (PDT)
Received: from xps13.localnet ([2a02:2c40:400::1:fafe])
 by mx.google.com with ESMTPSA id z44sm5485730eep.39.2014.05.14.07.31.13
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 May 2014 07:31:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Disable the AA-loopback path to get rid of the constant white noise
that can be heard when headphones are used.

This patch was tested only on a Dell XPS13 9333.

Fix based on d2e92709e88d ("ALSA: hda - Disable AA-loopback on ALC283
Chromebook").

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5f7c765..21c94e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5690,6 +5690,13 @@ static int patch_alc662(struct hda_codec *codec)
 	if (has_cdefine_beep(codec))
 		spec->gen.beep_nid = 0x01;
 
+	switch (codec->vendor_id) {
+	case 0x10ec0668:
+		/* Disable AA-loopback as it causes white noise */
+		spec->gen.mixer_nid = 0;
+		break;
+	}
+
 	if ((alc_get_coef0(codec) & (1 << 14)) &&
 	    codec->bus->pci && codec->bus->pci->subsystem_vendor == 0x1025 &&
 	    spec->cdefine.platform_type == 1) {
-- 
2.0.0.rc2
