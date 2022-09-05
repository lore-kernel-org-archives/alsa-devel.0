Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F48ECAAD3
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 13:07:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B984F84B;
	Mon,  5 Sep 2022 15:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B984F84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662383251;
	bh=zixeRl6aOUGsfJ6+GMzQ/WE7gW7L59zpJJg13xyeN5Y=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=toSgLui0f4QfieaetQHcbn4bHncPC/kkzTAdwdgi6XtWBsc0ek8Z30IG6Ga8Ziffk
	 T92RD7dBH6QiZtXj/6kFFjjEAxXb5DMtmQcZzWfuH+qz2GTyT/lzbGI5K4vfTvZ5Ft
	 byoZ8nELykwWJr0oNt4ugn/q90Fg3Hig6kH+L1HM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39896F80165;
	Mon,  5 Sep 2022 15:06:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31C94F80238; Mon,  5 Sep 2022 15:06:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F6D6F800CC
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2022 15:06:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F6D6F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="q0whn3js"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="oGi2tQFZ"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A3E21FA17;
 Mon,  5 Sep 2022 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662383192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y6sNAuy5o5cZBqkgiImWbB0qlcgVPNhiWxpmjmWXeUM=;
 b=q0whn3jsJ+YR/edi2dATtI+HdJR5F/Dd0VBFygBQd9BC7IOBw/8Jx8H/n9x3b5/igxi560
 KO0eSRJuUibRAsR5j1gJ023lqh3fvytv1BoalZpjXbvZHaHtFfxtpRF0TJyibrpZp+zmwk
 0xykRwoq47DmkrA4TwHxPbBxRpoy+J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662383192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y6sNAuy5o5cZBqkgiImWbB0qlcgVPNhiWxpmjmWXeUM=;
 b=oGi2tQFZQp2FOaGtEBPFxzRndZ3pd1bTMwhnInzQ5aa+xnZjweTpwN+6iDvCLJOKhhQGPZ
 eF0CtAcUXLkqVODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80B04139C7;
 Mon,  5 Sep 2022 13:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r7KRHlj0FWOAFQAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 05 Sep 2022 13:06:32 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/sigmatel: Fix unused variable warning for beep
 power change
Date: Mon,  5 Sep 2022 15:06:30 +0200
Message-Id: <20220905130630.2845-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

The newly added stac_check_power_status() caused a compile warning
when CONFIG_SND_HDA_INPUT_BEEP is disabled.  Fix it.

Fixes: 414d38ba8710 ("ALSA: hda/sigmatel: Keep power up while beep is enabled")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 066bfccd2587..7f340f18599c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4447,7 +4447,9 @@ static int stac_suspend(struct hda_codec *codec)
 
 static int stac_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
 	struct sigmatel_spec *spec = codec->spec;
+#endif
 	int ret = snd_hda_gen_check_power_status(codec, nid);
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-- 
2.35.3

