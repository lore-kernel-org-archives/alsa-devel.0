From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/38] ALSA: hda/realtek - Improve the
	signel-connection check
Date: Fri, 24 Feb 2012 17:36:04 +0100
Message-ID: <1330101391-8788-12-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E0AA104316
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6F79191240
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

When the connections from the pin selector contain only two
widgets, a route to DAC and the aa-mixer, it's certainly a
single connection.  In such a case, get_dac_if_single() should
return the connected DAC, too.

This will improve the detection of the individual DAC
assignment for each pin.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ffccc1..a5697c3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2972,8 +2972,12 @@ static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
 
 static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 {
+	struct alc_spec *spec = codec->spec;
 	hda_nid_t sel = alc_go_down_to_selector(codec, pin);
-	if (snd_hda_get_conn_list(codec, sel, NULL) == 1)
+	hda_nid_t srcs[5];
+	int num = snd_hda_get_connections(codec, sel, srcs,
+					  ARRAY_SIZE(srcs));
+	if (num == 1 || (num == 2 && srcs[1] == spec->mixer_nid))
 		return alc_auto_look_for_dac(codec, pin);
 	return 0;
 }
-- 
1.7.9
