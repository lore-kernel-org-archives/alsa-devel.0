From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH] ALSA: VIA HDA: Add VT1708S power management
	function
Date: Wed, 23 Mar 2011 16:35:44 +0800
Message-ID: <4D89B0E0.8010500@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id B1735243AC
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 09:35:59 +0100 (CET)
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
Subject: ALSA: VIA HDA: Add VT1708S power management function.

Define set_widgets_power_state() function for VT1708S.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
 sound/pci/hda/patch_via.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3785,6 +3785,7 @@
 		spec->stream_name_analog = "VT1818S Analog";
 		spec->stream_name_digital = "VT1818S Digital";
 	}
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
 	return 0;
 }
