Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60177C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:59:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AD12072F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p+SOkXXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD12072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34DEE1666;
	Mon,  8 Jun 2020 13:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34DEE1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591617564;
	bh=NfqxNRRhnoBjHQs6GGQGJF3/fVoYB1E3/M+UhE/RvWg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p+SOkXXfMar3NT7sJdXX6tqVRYSUHx/beG0/k+TWoWzoI+bf7LbNtNbMKWksJJ4mC
	 PXFm68JGm8O5V0G6JGS5WvRphifXOo0xa0veFgv+QEBlr4IDbpXqeqwiAjvFBotDPd
	 K8/ePfuyxjg/lIs22KG8hq6TAS/wPe8muKko3e0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E53DDF8021E;
	Mon,  8 Jun 2020 13:58:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F54AF80252; Mon,  8 Jun 2020 13:58:08 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C8A0F801F7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 13:58:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C8A0F801F7
Received: from [114.253.242.108] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jiGPf-0003eR-Om; Mon, 08 Jun 2020 11:58:00 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda/realtek - add a pintbl quirk for several Lenovo
 machines
Date: Mon,  8 Jun 2020 19:55:41 +0800
Message-Id: <20200608115541.9531-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
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

A couple of Lenovo ThinkCentre machines all have 2 front mics and they
use the same codec alc623 and have the same pin config, so add a
pintbl entry for those machines to apply the fixup
ALC283_FIXUP_HEADSET_MIC.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0aa778ff7f2b..6d73f8beadb6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8161,6 +8161,12 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
 		{0x17, 0x90170110}),
+	SND_HDA_PIN_QUIRK(0x10ec0623, 0x17aa, "Lenovo", ALC283_FIXUP_HEADSET_MIC,
+		{0x14, 0x01014010},
+		{0x17, 0x90170120},
+		{0x18, 0x02a11030},
+		{0x19, 0x02a1103f},
+		{0x21, 0x0221101f}),
 	{}
 };
 
-- 
2.17.1

