Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125AC433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:05:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D57C208C7
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i9aKr3G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D57C208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D74691668;
	Sun, 11 Oct 2020 12:04:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D74691668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602410716;
	bh=k/yxDEXjbce2OQCUPRQ8ZrKy9xMdIOTlOpLWsUuQi3g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9aKr3G7smlCGieIz9UvLj9LrUZqvMLoSyGZkr6Qpi3frpWoxz4hH+khj7x73BAUx
	 opQZ4twVHQZD7vKXhq+eS5wWqZoA0zQqptWDBcRV5YL3DqAoM0DApzwOLspEGgQzBL
	 O2DBcNnVhjHMQtngrCD4rfZ3ZGF4l+TB7t8SVhVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CCEEF8026D;
	Sun, 11 Oct 2020 12:02:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B27D6F80278; Sun, 11 Oct 2020 12:02:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF056F80148
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 12:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF056F80148
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; d="scan'208";a="471981619"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 11 Oct 2020 12:02:41 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/8] ALSA: hda: use semicolons rather than commas to separate
 statements
Date: Sun, 11 Oct 2020 11:19:33 +0200
Message-Id: <1602407979-29038-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
Cc: alsa-devel@alsa-project.org,
 =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 sound/pci/hda/patch_hdmi.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9779978e4bc7..2b38b2a716a1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3114,7 +3114,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 	}
 
 	data = fls->data;
-	chip_addx = fls->chip_addr,
+	chip_addx = fls->chip_addr;
 	words_to_write = fls->count;
 
 	if (!words_to_write)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 055440740184..0ffbfcb91256 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2451,7 +2451,7 @@ static int alloc_generic_hdmi(struct hda_codec *codec)
 	spec->chmap.ops.get_chmap = hdmi_get_chmap;
 	spec->chmap.ops.set_chmap = hdmi_set_chmap;
 	spec->chmap.ops.is_pcm_attached = is_hdmi_pcm_attached;
-	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc,
+	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc;
 
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);

