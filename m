From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 5/8] ALSA: VIA HDA: Modify mute_aa_path()
	function
Date: Tue, 22 Mar 2011 14:32:12 +0800
Message-ID: <4D88426C.40102@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id B4DCF103826
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:32:21 +0100 (CET)
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
Subject: ALSA: VIA HDA: Modify mute_aa_path() function.

Modify mute_aa_path() function to support VT1718S codec.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -855,6 +855,11 @@
 		start_idx = 2;
 		end_idx = 4;
 		break;
+	case VT1718S:
+		nid_mixer = 0x21;
+		start_idx = 1;
+		end_idx = 3;
+		break;
 	default:
 		return;
 	}
