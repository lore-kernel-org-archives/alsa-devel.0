Return-Path: <SRS0=UCdw=6R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD3C28CBC
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 15:26:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3F8206E9
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AtWY3Ulz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3F8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 835FF1672;
	Sun,  3 May 2020 17:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 835FF1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588519579;
	bh=sUm+WaPgRIJ+bHqnG7P6B2g96uTug0dHO4GKemlzivk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtWY3UlzZRTAwSSO7ZhznMKyU26nfqYjeaqf2ipmc0L7YV/zm1/z0gGY8L83Klfhq
	 T6v7rychVOzjzL4JNAAjObI7+oxMdDrSkonKuv/LjuBD39AgjW3qL0xLmRt1yNOO6J
	 RoAcasOWOUxtD+D+LKj/R/9L/TCLtyrx1I4iVC50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3D13F8015B;
	Sun,  3 May 2020 17:25:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C4A7F800DA; Sun,  3 May 2020 17:25:23 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB74CF800E5
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2020 17:25:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB74CF800E5
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1jVGUK-0004cA-W7; Sun, 03 May 2020 15:25:05 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH 2/2] ALSA: hda/realtek - Fix S3 pop noise on Dell Wyse
Date: Sun,  3 May 2020 23:24:47 +0800
Message-Id: <20200503152449.22761-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200503152449.22761-1-kai.heng.feng@canonical.com>
References: <20200503152449.22761-1-kai.heng.feng@canonical.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Tomas Espeleta <tomas.espeleta@gmail.com>,
 Thomas Hebb <tommyhebb@gmail.com>, David_chen7@dell.com,
 open list <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Jian-Hong Pan <jian-hong@endlessm.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
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

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

The previous fix enable power save node universally for ALC225, however
it makes some ALC225 systems unable to produce any sound.

So let's only enable power save node for the affected Dell Wyse
platform.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dedf0c17f198..c34b8843bb25 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5893,6 +5893,15 @@ static void alc233_alc662_fixup_lenovo_dual_codecs(struct hda_codec *codec,
 	}
 }
 
+static void alc225_fixup_s3_pop_noise(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	codec->power_save_node = 1;
+}
+
 /* Forcibly assign NID 0x03 to HP/LO while NID 0x02 to SPK for EQ */
 static void alc274_fixup_bind_dacs(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
@@ -6082,6 +6091,7 @@ enum {
 	ALC233_FIXUP_ACER_HEADSET_MIC,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
 	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
+	ALC225_FIXUP_S3_POP_NOISE,
 	ALC700_FIXUP_INTEL_REFERENCE,
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
@@ -6969,6 +6979,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 		.chained = true,
+		.chain_id = ALC225_FIXUP_S3_POP_NOISE
+	},
+	[ALC225_FIXUP_S3_POP_NOISE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc225_fixup_s3_pop_noise,
+		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
 	[ALC700_FIXUP_INTEL_REFERENCE] = {
-- 
2.17.1

