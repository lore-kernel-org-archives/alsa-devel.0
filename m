Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D860C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 09:36:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9827610CA
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 09:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9827610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61B101677;
	Mon, 12 Jul 2021 11:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61B101677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626082612;
	bh=S21WxVvQHpG/CezokHY86ZETHklVB0JcU/LqIMyAWOQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b/Hj2lkW6NEOOEhXt0CGTLufsi+Hamo7ebQGm1qupDqlBURgeYz0VkTDjSrxUQ2iV
	 f40rmIIUcJrhW2LJIsKQqJi8DpRarfyXhEkE7t0ds0XJ4/FfahhZ1PBhP8Ai9NG259
	 LsCjYI0RSuNZYAYa126WwhZcHd/uAJ17e5bQY1KU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E07D6F80253;
	Mon, 12 Jul 2021 11:36:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFF3AF80254; Mon, 12 Jul 2021 11:35:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3C20F8020C
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 11:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3C20F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="KTbFoBJP"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="R+zftUAb"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9DC0F2213D
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626082552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7F3/MtpPK7htspEnpjqBMk7qcI1w6mVDyNZMi76IR54=;
 b=KTbFoBJPKdJRUjSuiHeeB4Qycjq3Ul47PWwV+g8vCWXyxCLP6wA4OBORNOuwsEwXXMuRqL
 bIaIcatH6nJypMF9bNmSoMuVA2WE1hvvDx2oEB1DtIaTUTaGZsquPDZp/aP6s+uhJGEz7L
 oCN5ZU3rqmym79yZErKqrLyjhtdspI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626082552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7F3/MtpPK7htspEnpjqBMk7qcI1w6mVDyNZMi76IR54=;
 b=R+zftUAbCGtqjkGQmntTPuB2MAkFkrmCMjAFez9EHqJPQKbiSSbPpAJCj1jwq25n9oGSjF
 Og0gJfCUTj8w7CDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 97ABEA3B84;
 Mon, 12 Jul 2021 09:35:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/hdmi: Add option to enable all pins forcibly
Date: Mon, 12 Jul 2021 11:35:51 +0200
Message-Id: <20210712093551.29007-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

On Intel platforms, we always enable all pins no matter what BIOS
sets, but for others, we still take the conservative approach, and the
HD-audio HDMI codec driver enables the streams only for the pins that
are enabled by BIOS, and skips the disabled pins.  This seems not good
for some machines that have (as expected) broken BIOS, resulting in
the lack of needed outputs.

There is an allow-list in the driver code to enable all pins, but its
addition needs a recompilation.  This patch adds a module option for
user's convenience to enable all pins forcibly on the fly.  User can
pass snd_hda_codec_hdmi.enable_all_pins=1 option for testing, and once
confirmed, we may add a static entry in force_connect_list[].

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4b2cc8cb55c4..672fd28e2449 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -47,6 +47,10 @@ IS_ENABLED(CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM);
 module_param(enable_silent_stream, bool, 0644);
 MODULE_PARM_DESC(enable_silent_stream, "Enable Silent Stream for HDMI devices");
 
+static bool enable_all_pins;
+module_param(enable_all_pins, bool, 0444);
+MODULE_PARM_DESC(enable_all_pins, "Forcibly enable all pins");
+
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
 	int assigned;
@@ -1957,6 +1961,9 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 		return -EINVAL;
 	}
 
+	if (enable_all_pins)
+		spec->force_connect = true;
+
 	q = snd_pci_quirk_lookup(codec->bus->pci, force_connect_list);
 
 	if (q && q->value)
-- 
2.26.2

