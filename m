Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25833C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:50:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D9221D7D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F6sBwTzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D9221D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0AD41781;
	Fri,  3 Jan 2020 09:49:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0AD41781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578041436;
	bh=Dy3CUkE4Af37R1p3LK/D2RN5Vkgl7psxVNczqk5l/CY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F6sBwTzTQXKMC+xB7hxNqQGqvReRJgtWoQLh7/rqhiULxmG1UAw6B6ovJ1Q0nEtSj
	 5YVO0Pgb/SMMxkmBum5qWwdgj4Li33T0iyPVDS6D6e0czi7IY74XyehLC3umrxteiH
	 Q3eoGjMYG7YUkfsQs7MYpyTTYbMLqLig4S/1pEOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45703F804E7;
	Fri,  3 Jan 2020 09:19:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02C01F803CD; Fri,  3 Jan 2020 09:18:50 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C61CF802DB
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C61CF802DB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 31F2FB287
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:22 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:17:08 +0100
Message-Id: <20200103081714.9560-53-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 52/58] ALSA: seq: oss: Constify
	snd_seq_oss_callback definitions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The snd_seq_oss_callback items are just copied to another struct
as-is, hence they can be declared as const.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_oss.c | 2 +-
 sound/synth/emux/emux_oss.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl3/opl3_oss.c b/sound/drivers/opl3/opl3_oss.c
index d0cf2fb02cce..7bf0d5f3fedd 100644
--- a/sound/drivers/opl3/opl3_oss.c
+++ b/sound/drivers/opl3/opl3_oss.c
@@ -16,7 +16,7 @@ static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg);
 
 /* operators */
 
-static struct snd_seq_oss_callback oss_callback = {
+static const struct snd_seq_oss_callback oss_callback = {
 	.owner = 	THIS_MODULE,
 	.open =		snd_opl3_open_seq_oss,
 	.close =	snd_opl3_close_seq_oss,
diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index a14fc6562664..d8d32671f703 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -34,7 +34,7 @@ static void fake_event(struct snd_emux *emu, struct snd_emux_port *port,
 		       int ch, int param, int val, int atomic, int hop);
 
 /* operators */
-static struct snd_seq_oss_callback oss_callback = {
+static const struct snd_seq_oss_callback oss_callback = {
 	.owner = THIS_MODULE,
 	.open = snd_emux_open_seq_oss,
 	.close = snd_emux_close_seq_oss,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
