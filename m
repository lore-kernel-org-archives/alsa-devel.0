Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD86CC2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 10:50:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493A26142B
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 10:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493A26142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35568172B;
	Tue, 25 May 2021 12:49:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35568172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621939826;
	bh=M8UMix3Rc5b46JC1px/Knai+Lvtz/fF6IgSXWw0k9ug=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UxjtEKCeg9gc2Ua5iYsVX6ZVE19CJRK6PoySG/IWqxbKjBxM6437UqRV+nZIcRZZS
	 fvgxp31brbhKfru3jQFbf7qmBymX96qIqSAgympUkqELijo8JUjSRvf4CjbreVKlIw
	 +ohemg503u+ezW4UGEoAwBL2lke9hjZz7UMzyC1M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C198FF80137;
	Tue, 25 May 2021 12:49:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7FF6F80113; Tue, 25 May 2021 12:49:34 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B73DCF80113
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 12:49:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B73DCF80113
IronPort-SDR: csBprOY7d+Ai36TyByV/7IKFffgevJINGpk+zCPy56x+Xv7TwNHeM0cqcfRBokO3AvBEfEp0Ze
 bUJge2unq7uA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181802056"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; d="scan'208";a="181802056"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 03:49:18 -0700
IronPort-SDR: HiNIjNI0n52FIbNwvyapwDar312MDWWFuLsfHuxHXRzqwCZAMCLXdcOS4KsYpTwKrHbGu+7MP2
 ecUPAwq6MpbQ==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; d="scan'208";a="476361378"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO
 peter-virtualbox.ger.corp.intel.com) ([10.252.39.140])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 03:49:16 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: tiwai@suse.com,
	hui.wang@canonical.com
Subject: [PATCH v2] ALSA: hda/realtek: Chain in pop reduction fixup for
 ThinkStation P340
Date: Mon, 24 May 2021 22:24:37 +0300
Message-Id: <20210524192437.27838-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Lenovo ThinkStation P340 uses ALC623 codec (SSID 17aa:1048) and it produces
bug plock/pop noise over line out (green jack on the back) which can be
fixed by applying ALC269_FIXUP_NO_SHUTUP tot he machine.

Convert the existing entry for the same SSID to chain to apply this fixup
as well.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi Takashi,

Changes since v1
- instead of deny_list use chained fixup to fix the plock/pop noise

Changes since RFC:
- Fixed up the PCI ID

ever since I have this workstation (three weeks) the plock/pop noise on playback
start bugged me. So far the only solution I have found is to disable the
power_save which I find acceptable on a desktop compared to the pops.

The alsa-info.sh output is can be found here:
http://alsa-project.org/db/?f=414b1b236fc73db386ad4f938bc3b304f6b30b05

Missing details from alsa-info output:
# lspci -nnk | grep -A2 Audio
00:1f.3 Audio device [0403]: Intel Corporation Comet Lake PCH cAVS [8086:06c8]
        DeviceName: Onboard - Sound
        Subsystem: Lenovo Device [17aa:1048]

CPU: i9-10900k

The machine have ALC623 codec and the jacks are correctly discovered and they
do what they supposed to be.
When I have the headset connected to the front and audio is routed there the
line out (green jack) from the back still prodices the plock/pop.

Is there a known quirk for similar issue or a better way to handle it?

[1] https://lore.kernel.org/alsa-devel/20210524152533.7479-1-peter.ujfalusi@linux.intel.com/

Thanks you,
Peter Ujfalusi

 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3e269de84079..e2e0ee7b137d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6543,6 +6543,7 @@ enum {
 	ALC295_FIXUP_ASUS_DACS,
 	ALC295_FIXUP_HP_OMEN,
 	ALC285_FIXUP_HP_SPECTRE_X360,
+	ALC623_FIXUP_LENOVO_THINKSTATION_P340,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8109,6 +8110,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1,
 	},
+	[ALC623_FIXUP_LENOVO_THINKSTATION_P340] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_no_shutup,
+		.chained = true,
+		.chain_id = ALC283_FIXUP_HEADSET_MIC,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8412,7 +8419,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL53RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC233_FIXUP_LENOVO_MULTI_CODECS),
-	SND_PCI_QUIRK(0x17aa, 0x1048, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x1048, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IGNORE),
@@ -8677,6 +8684,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC245_FIXUP_HP_X360_AMP, .name = "alc245-hp-x360-amp"},
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
+	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.31.1

