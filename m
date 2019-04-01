From: Kailang <kailang@realtek.com>
Subject: alc295_fixup_chromebook function
Date: Mon, 1 Apr 2019 07:29:35 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBAE8F@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8821F89610
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 09:29:41 +0200 (CEST)
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

You applied below patch.
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=c8a9afa632f0fd45731d3353525faf1fdb362c89

But I think ALC225_FIXUP_HEADSET_JACK will applicate for enable for headset button.
It was not only use for Chrome OS.
So, ALC225_FIXUP_HEADSET_JACK and alc295_fixup_chromebook separation were be better.

Intel test https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=10f5b1b85ed10a80d45bc2db450e65bd792efaad this patch.
Mic JD was also not stable. (I don't know why. It passed with Ubuntu OS.)
It need to change to initial state would be better. (original was HDA_FIXUP_ACT_PRE_PROBE)

+static void alc295_fixup_chromebook(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+
+	switch (action) {
+	case HDA_FIXUP_ACT_INIT:
+		switch (codec->core.vendor_id) {
+		case 0x10ec0295:
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
+			break;
+		case 0x10ec0236:
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
+			break;
+		}
+		break;
+	}
+}

How could I create a fix patch for this?
Thanks.

BR,
Kailang
