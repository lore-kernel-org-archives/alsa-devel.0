Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E4C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 07:39:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DE861356
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 07:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21DE861356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C347C84D;
	Mon, 23 Aug 2021 09:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C347C84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629704384;
	bh=UhenmEKBhretgJcgkfjTbG1z01ZM7Zra8DXrbekrpU8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hd+68xASJrbb49aaswtl7gWi+mgYqOPWgd6pAVOieuuhLSTClF1T+tqOKYaFfXA8k
	 UFXFA4gC7v5caUHN58YgLUsiTFJv27v4MZPsFy3agYJc5MRLCRyKkWFIkoMJX55lHW
	 yEkbF7O6TWlghy79EhCuAE8qWdBK8bV1KZ8aMCUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 755B8F804FA;
	Mon, 23 Aug 2021 09:37:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6539F804EC; Mon, 23 Aug 2021 09:37:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DCE0F8016E
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 09:37:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DCE0F8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Hd0ghX7L"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="qj7Bib/d"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C9E5D21F1B
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629704249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O38uCVxbcvcWMIbKGbQ4wvTXs9osXcfS4xdqL98wvhA=;
 b=Hd0ghX7L5RqKeKQ7kUf02JgjaF+E1I/rXMv+gFTgEs+U5/Z0p2++J91lRdBWppeiBfc/Dh
 95SK9L2uN2XL+I4BhvbcenxA5vnj7kpEoSOwhkpWdiQdiuIkowSql1nReDfob4yMo3xkKF
 +rBpB/mQGVGGaanUsxsfD3nEVwLsV2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629704249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O38uCVxbcvcWMIbKGbQ4wvTXs9osXcfS4xdqL98wvhA=;
 b=qj7Bib/dT18pH6pEZbzqHBln1V54qevnr2NpzljZnXlPZ7oJMQTC6UMvWDgB3iQsSjqYoc
 CK4b7BcwyWwRdaAQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id B920EA3BAE;
 Mon, 23 Aug 2021 07:37:29 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ALSA: hda: Allow model option to specify PCI SSID alias
Date: Mon, 23 Aug 2021 09:37:21 +0200
Message-Id: <20210823073722.14873-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823073722.14873-1-tiwai@suse.de>
References: <20210823073722.14873-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are tons of quirks for HD-audio and many of them are without
model string, hence it's not trivial to apply the same quirk for a new
device.  This patch makes it easier: namely, the model string accepts
a form as "XXXX:YYYY" (a pair of hex numbers of the subsystem-vendor
and subsystem-device IDs), to specify the alias of PCI (or codec)
SSID.  e.g. passing model=1234:abcd would apply the quirk that matches
with the given SSID 1234:abcd instead of the actual SSID.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index dd050be7aefa..4a854475a0e6 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -971,6 +971,8 @@ EXPORT_SYMBOL_GPL(snd_hda_pick_pin_fixup);
  * When a special model string "nofixup" is given, also no fixup is applied.
  *
  * The function tries to find the matching model name at first, if given.
+ * If the model string contains the SSID alias, try to look up with the given
+ * alias ID.
  * If nothing matched, try to look up the PCI SSID.
  * If still nothing matched, try to look up the codec SSID.
  */
@@ -983,6 +985,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 	int id = HDA_FIXUP_ID_NOT_SET;
 	const char *name = NULL;
 	const char *type = NULL;
+	int vendor, device;
 
 	if (codec->fixup_id != HDA_FIXUP_ID_NOT_SET)
 		return;
@@ -1013,6 +1016,16 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 	if (!quirk)
 		return;
 
+	/* match with the SSID alias given by the model string "XXXX:YYYY" */
+	if (codec->modelname &&
+	    sscanf(codec->modelname, "%04x:%04x", &vendor, &device) == 2) {
+		q = snd_pci_quirk_lookup_id(vendor, device, quirk);
+		if (q) {
+			type = "alias SSID";
+			goto found_device;
+		}
+	}
+
 	/* match with the PCI SSID */
 	q = snd_pci_quirk_lookup(codec->bus->pci, quirk);
 	if (q) {
-- 
2.26.2

