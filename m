From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/12] ALSA: hda - Enable parsing the
	independent HP mode as default for VIA codecs
Date: Mon, 21 Jan 2013 17:06:13 +0100
Message-ID: <1358784377-26102-9-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 939E2262602
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id F1B9BA51F2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:18 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

The original VIA codec parser enabled it as default, so let's keep the
behavior as it was.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index eade21c..9d9583c 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -135,6 +135,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	if (spec->codec_type == VT1708BCE)
 		spec->codec_type = VT1708S;
 	spec->no_pin_power_ctl = 1;
+	spec->gen.indep_hp = 1;
 	spec->gen.pcm_playback_hook = via_playback_pcm_hook;
 	return spec;
 }
-- 
1.8.1.1
