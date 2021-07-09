Return-Path: <SRS0=Xr4r=MB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F060CC07E96
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 02:35:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D63C61421
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 02:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D63C61421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25EA6950;
	Fri,  9 Jul 2021 04:34:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25EA6950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625798097;
	bh=p2Iit6OoPiLXEDcLgNH62DkmlhtH6LxdXBNfCvG1xbg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NUpcJuJRKFboSFauZST9CLJwI+B20rVLq3nYwOoj20UemRM/86gdm8B50L/HNvexQ
	 CkCrX+gziiTYl0aEYvF+R/Fpy0/Q95KPyfdwN572Fwszb6cGSFh3eya7HWdsYdOx85
	 WihSZzKWLuut/+OXm0BwvdlLKq41KD5nPS5rLthQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73598F80171;
	Fri,  9 Jul 2021 04:34:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69DE0F80224; Fri,  9 Jul 2021 04:34:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A44CAF80107
 for <alsa-devel@alsa-project.org>; Fri,  9 Jul 2021 04:33:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A44CAF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="sbl5Caa1"
Received: from localhost.localdomain (unknown [123.112.64.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3F4AF40234; 
 Fri,  9 Jul 2021 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1625798034;
 bh=gsxFMTeqZnRRc9iXmfiIjhRa/gczix9H+dZe3fMdQvM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=sbl5Caa1H/eFHUnRNA+DnTb1V+XXSeGh2t663QzlcfFwq6zi4Ee5ZycFeXLh0w31+
 QEO38bPxOB5HASbmIr11IeuuNZtsyQpHhQZ+0Zfz+Xf+S/Vgn2aMrSGeGkVkeOVLPR
 adNAY7fLja5opCXnIGWDdHm8PXMrirfcwR49aA4UQk85HstE50AnNkJk9aY25ZV4sX
 lmZ/iLOCoLZXnVE21gaGDHOjt9i+zC+wqVytXQFqMkNqz6R8g4+Y0cgjkHwuknU5kj
 fPv642e+5FFSaypLbbH//v92A0PN7DUCy+Eyuva6SoE6qyweOPom0ouxH7GwXO0AP6
 f98PdyHebnz1g==
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda/proc - dump the coeff with the capital letters
Date: Fri,  9 Jul 2021 10:33:45 +0800
Message-Id: <20210709023345.6359-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
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

Sometimes we need to dump the coeff to debug the audio issues, and
need to compare it with the log of RTHDDump.exe under Windows, this is
the coeff under Windows and Linux:
Vendor widget coefficient value under Windows
Index 0x00  0x0002
Index 0x01  0xAAAA
Index 0x02  0x8AAA

Processing caps: benign=0, ncoeff=91 under Linux
Coeff 0x00: 0x0002
Coeff 0x01: 0xaaaa
Coeff 0x02: 0x8aaa

Windows prints the hex number with capital letter while Linux prints
the hex number with lower case letter, it adds the trouble when
comparing them. Let us change it to use capital letter.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 00c2eeb2c472..9037c87665b6 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -590,7 +590,7 @@ static void print_proc_caps(struct snd_info_buffer *buffer,
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, i);
 		val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PROC_COEF,
 					 0);
-		snd_iprintf(buffer, "    Coeff 0x%02x: 0x%04x\n", i, val);
+		snd_iprintf(buffer, "    Coeff 0x%02X: 0x%04X\n", i, val);
 	}
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, oldindex);
 }
-- 
2.25.1

