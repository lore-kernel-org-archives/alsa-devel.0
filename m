Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1A4C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 27 May 2022 15:30:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0194E176C;
	Fri, 27 May 2022 17:30:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0194E176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653665456;
	bh=MeaMHZSNWiYX7NmLTVIADdApsvo48kFbfH7Q4zDfd4A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hSnu2O2INAaWe3clhSN8LnJYyxGmIkunNlb4f8dwsXwHVJwFmt8F7FSe57nv/KWp3
	 Yhn/edtEFY1OlHcUzQmsgUNpgQHlZb29XajywpFybfWcvZvDV0ocp8l1/YSJpdhIX/
	 0JQXskF4YJZsVfxuqkx3zCdoHfMAP4skMyUd/rrU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5E0DF80529;
	Fri, 27 May 2022 17:28:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63948F802DB; Fri, 27 May 2022 14:12:22 +0200 (CEST)
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85FA5F800D0
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2022 14:12:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85FA5F800D0
X-QQ-mid: bizesmtp74t1653653517tiv7vzps
Received: from localhost.localdomain ( [182.148.13.40])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 27 May 2022 20:11:40 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000000A0000000
X-QQ-FEAT: RKCwGdK8Yfi2eFJ32OTXHJX7Mf5yNB5Ebft1FvL5LJRKtQWC4ZGmyFAmQ0teK
 3lfRqetO0rebxgVX0jLKj8ICp3PiK4KesjiP6RTztZRjzc65a+muY5yOsdZI3TY404toRI3
 n5bFIYdbXgaHn+BLAFDFXdmpSDnMgiHYwer4O2ectEhEH/N3awrvJ9jR3of30tzDLcqOxYy
 SZBFgOBLPM6N9rbK1842vr8JrMaC3NcshCiwTMki5IPVqdFQ8ccZGsUn+k7NktrLlloyvrT
 MX836PLxb6HnusVvvNIZHT5q31BojLMlwfyWBnjXqQxXoJUy5ROUfVf093VONsFxiebQXGm
 18PK4KI5DzNJgloBAo=
X-QQ-GoodBg: 0
From: Xiang wangx <wangxiang@cdjrlc.com>
To: perex@perex.cz
Subject: [PATCH] ALSA: hda/via: Delete does not require return
Date: Fri, 27 May 2022 20:10:59 +0800
Message-Id: <20220527121059.25221-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Mailman-Approved-At: Fri, 27 May 2022 17:28:30 +0200
Cc: alsa-devel@alsa-project.org, Xiang wangx <wangxiang@cdjrlc.com>,
 tiwai@suse.com, linux-kernel@vger.kernel.org
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

Void function return statements are not generally useful.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 sound/pci/hda/patch_via.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 773a136161f1..a05304f340df 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -449,8 +449,6 @@ static void vt1708_set_pinconfig_connect(struct hda_codec *codec, hda_nid_t nid)
 		def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
 		snd_hda_codec_set_pincfg(codec, nid, def_conf);
 	}
-
-	return;
 }
 
 static int vt1708_jack_detect_get(struct snd_kcontrol *kcontrol,
-- 
2.36.1

