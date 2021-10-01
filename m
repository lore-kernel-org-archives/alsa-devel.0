Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 10:55:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3E861A82
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 10:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C3E861A82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A164D16CA;
	Fri,  1 Oct 2021 12:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A164D16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633085728;
	bh=Dqq0rskC9BOz8OP3SfKzfvP4Qshg2ezBrezTXNVud4o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fJmOvP94rXlaZ6dWB5S08YACebxcznZSN5wyjFVD+0B4oK/7RPh5yZWj09O5MPFWq
	 KkMhU7ThAOTjw2E8O/TMfHAlThvFo7s+Jp6BNrzZxOVP+KPldIN87MmnI3Oq/hLvgs
	 jNHE4O6gYMTyjdmyJEHBiMlmi6BTk51Lv0f+W8J4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE47F80227;
	Fri,  1 Oct 2021 12:54:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8275CF80245; Fri,  1 Oct 2021 12:54:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32C44F800F3
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 12:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32C44F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="wqjbN4WV"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ogFbZly+"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 08A85226A7;
 Fri,  1 Oct 2021 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633085667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66XDwMO5ev1fjAgNxaw0HcPY116LHDxZgh7wpBi1mYs=;
 b=wqjbN4WVnmJzGsvODOH8XTzISwcjgBKZCX69EnCdYg9ZMJb+EttaivnyhtL4m9bymwgeS7
 FGNArSzxYJDVXKDWL9rSxDMYz2cGyM4GeltxGsdcjMoWp2uERY90f6AJik5I9xoeqfvUzD
 aqHbP2oMHnVpC8CEZb65FRt4YubiKcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633085667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66XDwMO5ev1fjAgNxaw0HcPY116LHDxZgh7wpBi1mYs=;
 b=ogFbZly+KgXFi7WvOWLmjJuXqQaINXG+ZpoFJkWdehjEujSmOocM6r9bqwcCGt77ycEL4c
 vrnunBqgXH/GM6AA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id EA9A7A3B87;
 Fri,  1 Oct 2021 10:54:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix packet size calculation regression
Date: Fri,  1 Oct 2021 12:54:25 +0200
Message-Id: <20211001105425.16191-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Colin Ian King <colin.king@canonical.com>
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

The commit d215f63d49da ("ALSA: usb-audio: Check available frames for
the next packet size") introduced the available frame size check, but
the conversion forgot to initialize the temporary variable properly,
and it resulted in a bogus calculation.  This patch fixes it.

Fixes: d215f63d49da ("ALSA: usb-audio: Check available frames for the next packet size")
Reported-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20211001104417.14291-1-colin.king@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 42c0d2db8ba8..743b8287cfcd 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -182,7 +182,7 @@ static int next_packet_size(struct snd_usb_endpoint *ep, unsigned int avail)
 	if (ep->fill_max)
 		return ep->maxframesize;
 
-	sample_accum += ep->sample_rem;
+	sample_accum = ep->sample_accum + ep->sample_rem;
 	if (sample_accum >= ep->pps) {
 		sample_accum -= ep->pps;
 		ret = ep->packsize[1];
-- 
2.26.2

