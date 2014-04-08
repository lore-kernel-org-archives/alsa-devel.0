From: Kailang <kailang@realtek.com>
Subject: Add eapd shutup to alc283
Date: Tue, 8 Apr 2014 17:22:21 +0800
Message-ID: <B086C5BB8E334BD386E7D68003C02373@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw><s5hmwfxmt5o.wl%tiwai@suse.de><00A5C335971D4A02A0E52B6C7F5C64CF@realtek.com.tw><s5hy4zhl97y.wl%tiwai@suse.de><11F2A2679416461E8E3E3A151B84C12E@realtek.com.tw><s5hob0cqmkk.wl%tiwai@suse.de><F14645DC77054988BFE9667657F51B9C@realtek.com.tw>
 <s5hk3b0xlje.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0137_01CF534F.19A884F0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CF6232674D9
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 11:22:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_0137_01CF534F.19A884F0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Maybe internal speaker will have pop noise when system enter to suspend.
Add eapd shutup to alc283_shutup.
Thanks.

BR,
Kailang
------=_NextPart_000_0137_01CF534F.19A884F0
Content-Type: application/octet-stream;
	name="0000-add-eapd-shutup-for-alc283.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-eapd-shutup-for-alc283.patch"

>From 81b05a94bb3d9d29bf3f431766ba95b5cce43e68 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Tue, 8 Apr 2014 17:14:14 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add eapd shutup to ALC283=0A=
=0A=
Add eapd shutup function to alc283_shutup.=0A=
It could avoid pop noise from speaker.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index ca1298a..5a9879a 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -3095,6 +3095,7 @@ static void alc283_shutup(struct hda_codec *codec)=0A=
 =0A=
 	if (hp_pin_sense)=0A=
 		msleep(100);=0A=
+	alc_auto_setup_eapd(codec, false);=0A=
 	snd_hda_shutup_pins(codec);=0A=
 	alc_write_coef_idx(codec, 0x43, 0x9614);=0A=
 }=0A=

------=_NextPart_000_0137_01CF534F.19A884F0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0137_01CF534F.19A884F0--
