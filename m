From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 6/7] ALSA: VIA HDA: Correct stream names for
	VT1818S
Date: Tue, 22 Mar 2011 16:25:56 +0800
Message-ID: <4D885D14.7080007@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id E78D41038FD
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 09:26:06 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Correct stream names for VT1818S.

Correct stream names of analog playback and capture streams 
for VT1818S.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -4173,6 +4173,11 @@
 		spec->stream_name_analog = "VT1708BCE Analog";
 		spec->stream_name_digital = "VT1708BCE Digital";
 	}
+	/* correct names for VT1818S */
+	if (codec->vendor_id == 0x11060440) {
+		spec->stream_name_analog = "VT1818S Analog";
+		spec->stream_name_digital = "VT1818S Digital";
+	}
 	return 0;
 }
