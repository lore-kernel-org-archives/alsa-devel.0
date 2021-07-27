Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266FAC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 10:53:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7763560F59
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 10:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7763560F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CC9A1AF0;
	Tue, 27 Jul 2021 12:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CC9A1AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627383213;
	bh=3MaHLI2Fm8VPn5el4nKAnSxzMCDaX6IHFS7EySNy4cU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jJURVBx1EWD0O+Nbe8B/H0FeJeV30W5RvNMF2WFlRznUFmjgu2X8mSJNVLdgUBDsX
	 GaIHHMVCFO/LV80UwfML5wKdWdKlxyFNdInlEtHTDMnGgDB20HSHR6I3popRqC1lU1
	 c9jTClUJlr9XANXWK7WmjTT7KFxRR2IYvpFBXXzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AA3BF8020D;
	Tue, 27 Jul 2021 12:52:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF9A6F8026C; Tue, 27 Jul 2021 12:52:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1B20F8020D
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 12:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1B20F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="LxCXVljv"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="13V7dc7V"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AB23F1FEFD
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627383152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KT3G0Vqp/VuJ867O2iTLAAxJAqUY1DwjOgGF5KJWuvU=;
 b=LxCXVljvI1JwXIutYteXC+AfpQWEQfa0/iqJrbjiJYclC0UoJizT4O/aQVDpS+I0B4HbUL
 BpzuK8e3tio7FMlhfNzuxSiH7n8lLV/rzWI9+ev3o9+hqC8QS8A4dEyhzXFNZjl1l5TEEP
 XJ9yzfsgYIOKEC9Hgppyo7xyo61BRs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627383152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KT3G0Vqp/VuJ867O2iTLAAxJAqUY1DwjOgGF5KJWuvU=;
 b=13V7dc7VFbZjdiVyyv1rmVIQc658M6j47UYmD14hj/yI9HuyxoHIa0+yHcT5dqkm92WrGL
 L9F7M8kQiAeO5QDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A6640A3B89;
 Tue, 27 Jul 2021 10:52:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: seq: Fix comments of wrong client number for MIDI
 Passthrough
Date: Tue, 27 Jul 2021 12:52:32 +0200
Message-Id: <20210727105232.7321-1-tiwai@suse.de>
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

MIDI Passthrough sequencer client is assigned always to the fixed
number 14, while it's wrongly documented in the comments as if 62,
which was an old number that was used during development.  Fix all
those numbers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_dummy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index ac760b1e3d12..8c18d8c4177e 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -20,15 +20,15 @@
   are redirected to output port immediately.
   The routing can be done via aconnect program in alsa-utils.
 
-  Each client has a static client number 62 (= SNDRV_SEQ_CLIENT_DUMMY).
+  Each client has a static client number 14 (= SNDRV_SEQ_CLIENT_DUMMY).
   If you want to auto-load this module, you may add the following alias
   in your /etc/conf.modules file.
 
-	alias snd-seq-client-62  snd-seq-dummy
+	alias snd-seq-client-14  snd-seq-dummy
 
-  The module is loaded on demand for client 62, or /proc/asound/seq/
+  The module is loaded on demand for client 14, or /proc/asound/seq/
   is accessed.  If you don't need this module to be loaded, alias
-  snd-seq-client-62 as "off".  This will help modprobe.
+  snd-seq-client-14 as "off".  This will help modprobe.
 
   The number of ports to be created can be specified via the module
   parameter "ports".  For example, to create four ports, add the
-- 
2.26.2

