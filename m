From: Kailang <kailang@realtek.com>
Subject: Re: Change module name for Chrome
Date: Tue, 8 Apr 2014 16:06:22 +0800
Message-ID: <F14645DC77054988BFE9667657F51B9C@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw><s5hmwfxmt5o.wl%tiwai@suse.de><00A5C335971D4A02A0E52B6C7F5C64CF@realtek.com.tw><s5hy4zhl97y.wl%tiwai@suse.de><11F2A2679416461E8E3E3A151B84C12E@realtek.com.tw>
 <s5hob0cqmkk.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_009B_01CF5344.7C5FFA20"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 385AD2619DB
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 10:06:27 +0200 (CEST)
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

------=_NextPart_000_009B_01CF5344.7C5FFA20
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit


Oh! sorry..
Attach again.


> At Tue, 8 Apr 2014 15:34:18 +0800,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> Chrome OS was use alc283-dac-wcaps module name as default in their 
>> kernel.
>> I was create the change patch for future support.
>
> You mean "model" name, right?  If so, please correct and resubmit the
> patch.
>
>
> thanks,
>
> Takashi
>
> ------Please consider the environment before printing this e-mail. 

------=_NextPart_000_009B_01CF5344.7C5FFA20
Content-Type: application/octet-stream;
	name="0000-change-model-name-for-chrome.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-change-model-name-for-chrome.patch"

>From 5ed939f4dde9b88af829c1bd25486edbea8f2da6 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Tue, 8 Apr 2014 15:19:49 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Change model name alias for ChromeOS=0A=
=0A=
Chrome OS was use model name of alc283-dac-wcaps for loading model as =
default.=0A=
Change the model name to same as model name of Chrome OS for future =
support.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index b36be20..237867d 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4783,7 +4783,7 @@ static const struct hda_model_fixup =
alc269_fixup_models[] =3D {=0A=
 	{.id =3D ALC269_FIXUP_HP_GPIO_LED, .name =3D "hp-gpio-led"},=0A=
 	{.id =3D ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name =3D =
"dell-headset-multi"},=0A=
 	{.id =3D ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name =3D =
"dell-headset-dock"},=0A=
-	{.id =3D ALC283_FIXUP_CHROME_BOOK, .name =3D "alc283-chrome"},=0A=
+	{.id =3D ALC283_FIXUP_CHROME_BOOK, .name =3D "alc283-dac-wcaps"},=0A=
 	{.id =3D ALC283_FIXUP_SENSE_COMBO_JACK, .name =3D =
"alc283-sense-combo"},=0A=
 	{}=0A=
 };=0A=

------=_NextPart_000_009B_01CF5344.7C5FFA20
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_009B_01CF5344.7C5FFA20--
