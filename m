From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 13/16] ALSA: VIA HDA: Fix VT1708 can't build up
 Headphone control issue
Date: Mon, 21 Mar 2011 15:35:49 +0800
Message-ID: <4D86FFD5.3050501@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 236FF10385C
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:35:52 +0100 (CET)
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
Subject: ALSA: VIA HDA: Fix VT1708 can't build up Headphone control issue.

Since VT1708 didn't support the control of getting connection number, 
building of headphone control will fail in via_hp_build() function.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -816,9 +816,12 @@
 		break;
 	}
 
-	nums = snd_hda_get_connections(codec, nid, conn, HDA_MAX_CONNECTIONS);
-	if (nums <= 1)
-		return 0;
+	if (spec->codec_type != VT1708) {
+		nums = snd_hda_get_connections(codec, nid,
+					       conn, HDA_MAX_CONNECTIONS);
+		if (nums <= 1)
+			return 0;
+	}
 
 	knew = via_clone_control(spec, &via_hp_mixer[0]);
 	if (knew == NULL)
