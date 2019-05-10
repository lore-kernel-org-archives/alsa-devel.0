From: =?UTF-8?Q?Micha=c5=82_Wadowski?= <wadosm@gmail.com>
Subject: Re: Fix for Lenovo B50-70 inverted internal microphone
	bug
Date: Sat, 11 May 2019 00:15:07 +0200
Message-ID: <cc266f08-cbe8-28e1-c264-6c358274d671@gmail.com>
References: <abb4a724-b561-9579-e821-b56ff00051c5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6529BCBF533E9918A1266686"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2564F80730
 for <alsa-devel@alsa-project.org>; Sat, 11 May 2019 00:15:11 +0200 (CEST)
Received: by mail-lj1-x233.google.com with SMTP id r76so6306054lja.12
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 15:15:11 -0700 (PDT)
Received: from [192.168.0.94] (31-178-116-31.dynamic.chello.pl.
 [31.178.116.31])
 by smtp.googlemail.com with ESMTPSA id r26sm1744667lfa.62.2019.05.10.15.15.08
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 15:15:08 -0700 (PDT)
In-Reply-To: <abb4a724-b561-9579-e821-b56ff00051c5@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------6529BCBF533E9918A1266686
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 10.05.2019 o 23:52, Michał Wadowski pisze:
> I prepared patch for this bug:
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1524215
> 
> I tested this patch on Linux 5.1.0 and it fixes problem on my Lenovo 
> B50-70 laptop.

Sorry, I forgot attach the patch

--------------6529BCBF533E9918A1266686
Content-Type: text/x-patch;
 name="fix_for_lenovo_b50-70_inverted_internal_microphone_bug.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="fix_for_lenovo_b50-70_inverted_internal_microphone_bug.patch"

commit 450484025b7051c8c078e95e906d7133967b9c36
Author: Michał Wadowski <wadosm@gmail.com>
Date:   Thu May 9 16:02:23 2019 +0200

    Fix for Lenovo B50-70 inverted internal microphone bug.
    Ref: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1524215

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 42cd394..36c18a5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5676,6 +5676,7 @@ enum {
 	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 	ALC233_FIXUP_LENOVO_MULTI_CODECS,
 	ALC233_FIXUP_ACER_HEADSET_MIC,
+	ALC233_FIXUP_INV_DMIC,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
 	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
 	ALC700_FIXUP_INTEL_REFERENCE,
@@ -6384,6 +6385,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
 	},
+	[ALC233_FIXUP_INV_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_inv_dmic,
+	},
 	[ALC255_FIXUP_DELL_SPK_NOISE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_disable_aamix,
@@ -6975,6 +6980,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC233_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
@@ -7157,6 +7163,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC256_FIXUP_ASUS_AIO_GPIO2, .name = "alc256-asus-aio"},
 	{.id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE, .name = "alc233-asus"},
 	{.id = ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE, .name = "alc233-eapd"},
+	{.id = ALC233_FIXUP_INV_DMIC, .name = "acl233-inv-dmic"},
 	{.id = ALC294_FIXUP_LENOVO_MIC_LOCATION, .name = "alc294-lenovo-mic"},
 	{.id = ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE, .name = "alc225-wyse"},
 	{.id = ALC274_FIXUP_DELL_AIO_LINEOUT_VERB, .name = "alc274-dell-aio"},

--------------6529BCBF533E9918A1266686
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------6529BCBF533E9918A1266686--
