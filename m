Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11708C3A5A7
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:11:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6623121874
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UyUrnHNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6623121874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46BB5857;
	Fri, 30 Aug 2019 12:10:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46BB5857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567159868;
	bh=caO2pZR6QAVzVmFZXMyhmaVvv0G9bmvmk3Lp91XVl40=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UyUrnHNSYo3f0Er1YrTx/FeLtB7A9xjB/h5+oxSBXj+HKxABqUY6xgC9sLmx7Ke7Q
	 FZReMN7lwXel7I6BBGOzstZuoMYy5jWEop7BNOJIws6sJ3Y+TOv6mZE184eZA2eylE
	 HETDPDUz9W7bfhLOezDhAWEA8rVvntonExNTPHag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF406F80362;
	Fri, 30 Aug 2019 12:10:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67DD0F80369; Fri, 30 Aug 2019 12:10:15 +0200 (CEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D95A6F80096
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D95A6F80096
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 34E9AAF3B
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 10:10:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 30 Aug 2019 12:10:10 +0200
Message-Id: <20190830101010.27105-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda/realtek - Fix overridden
	device-specific initialization
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830101010.ZttEPICjTvEzH3akehxg-rFEGKW5kzK8TKOnkBJmltI@z>

The recent change to shuffle the codec initialization procedure for
Realtek via commit 607ca3bd220f ("ALSA: hda/realtek - EAPD turn on
later") caused the silent output on some machines.  This change was
supposed to be safe, but it isn't actually; some devices have quirk
setups to override the EAPD via COEF or BTL in the additional verb
table, which is applied at the beginning of snd_hda_gen_init().  And
this EAPD setup is again overridden in alc_auto_init_amp().

For recovering from the regression, tell snd_hda_gen_init() not to
apply the verbs there by a new flag, then apply the verbs in
alc_init().

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204727
Fixes: 607ca3bd220f ("ALSA: hda/realtek - EAPD turn on later")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c   | 3 ++-
 sound/pci/hda/hda_generic.h   | 1 +
 sound/pci/hda/patch_realtek.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 5bf24fb819d2..10d502328b76 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -6009,7 +6009,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
-	snd_hda_apply_verbs(codec);
+	if (!spec->skip_verbs)
+		snd_hda_apply_verbs(codec);
 
 	init_multi_out(codec);
 	init_extra_out(codec);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 5f199dcb0d18..fb9f1a90238b 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -243,6 +243,7 @@ struct hda_gen_spec {
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 	unsigned int have_aamix_ctl:1;
 	unsigned int hp_mic_jack_modes:1;
+	unsigned int skip_verbs:1; /* don't apply verbs at snd_hda_gen_init() */
 
 	/* additional mute flags (only effective with auto_mute_via_amp=1) */
 	u64 mute_bits;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..03f903f9247d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -837,9 +837,11 @@ static int alc_init(struct hda_codec *codec)
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
+	spec->gen.skip_verbs = 1; /* applied in below */
 	snd_hda_gen_init(codec);
 	alc_fix_pll(codec);
 	alc_auto_init_amp(codec, spec->init_amp);
+	snd_hda_apply_verbs(codec); /* apply verbs here after own init */
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
