From: Kailang <kailang@realtek.com>
Subject: EAPD trun on time
Date: Wed, 17 Apr 2019 03:15:54 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBBD24@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21973F89616
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 05:16:03 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Our AE told me, that EAPD turn on timing which need to set pin out first.
It's the safe application. It could avoid pop noise via speaker.

So, could I do the modify as below patch.

BR,
Kailang

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 810479766090..efcd21b8e0d7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -804,9 +804,8 @@ static int alc_init(struct hda_codec *codec)
 		spec->init_hook(codec);
 
 	alc_fix_pll(codec);
-	alc_auto_init_amp(codec, spec->init_amp);
-
 	snd_hda_gen_init(codec);
+	alc_auto_init_amp(codec, spec->init_amp);
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
