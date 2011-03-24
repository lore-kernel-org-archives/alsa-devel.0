From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 2/6] ALSA: VIA HDA: Add VT1802 check in
 via_speaker_automute function
Date: Thu, 24 Mar 2011 12:40:10 +0800
Message-ID: <4D8ACB2A.8030400@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id E052F103948
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 05:40:13 +0100 (CET)
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
Subject: ALSA: VIA HDA: Add VT1802 check in via_speaker_automute function.

Add VT1802 check in via_speaker_automute() function.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>


 sound/pci/hda/patch_via.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1685,7 +1685,7 @@
 	unsigned int hp_present;
 	struct via_spec *spec = codec->spec;
 
-	if (spec->codec_type != VT2002P && spec->codec_type != VT1812)
+	if (!VT2002P_COMPATIBLE(spec))
 		return;
 
 	hp_present = snd_hda_jack_detect(codec, spec->autocfg.hp_pins[0]);
