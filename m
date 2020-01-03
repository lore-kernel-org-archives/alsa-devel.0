Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66575C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:43:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE3421D7D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iglw1UPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE3421D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 285F7177B;
	Fri,  3 Jan 2020 09:42:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 285F7177B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578040998;
	bh=3pnA/l1Y7hfP34bpC8z9mXcxot5m7vxoPOIYcmjwIRg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iglw1UPHdFSFNz9cNyaKCRvz9pVy7ZknDEd/ZU4CqMl6CfQ5czkp+1lyAZB85hS9O
	 eoJPYyfrIxkh8zd8H6HmgQYu1sPxWMxYLdQojfHOkTuB3VhzmC8thrmAsmvPex1t8s
	 6CM5Gh+PKgk/q23mg22XKh26QcJWCRpsS9ncsuOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FFECF8046E;
	Fri,  3 Jan 2020 09:19:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 680FDF80383; Fri,  3 Jan 2020 09:18:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07473F802A8
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07473F802A8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9B0C6B200
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:21 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:56 +0100
Message-Id: <20200103081714.9560-41-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 40/58] ALSA: spi: Constify snd_kcontrol_new
	items
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

Most of snd_kcontrol_new definitions are read-only and passed as-is.
Let's declare them as const for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/spi/at73c213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index d6f2b19cfa39..e51bbf7836a2 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -657,7 +657,7 @@ static int snd_at73c213_aux_capture_volume_info(
 			| (mask << 24) | (invert << 22))		\
 }
 
-static struct snd_kcontrol_new snd_at73c213_controls[] = {
+static const struct snd_kcontrol_new snd_at73c213_controls[] = {
 AT73C213_STEREO("Master Playback Volume", 0, DAC_LMPG, DAC_RMPG, 0, 0, 0x1f, 1),
 AT73C213_STEREO("Master Playback Switch", 0, DAC_LMPG, DAC_RMPG, 5, 5, 1, 1),
 AT73C213_STEREO("PCM Playback Volume", 0, DAC_LLOG, DAC_RLOG, 0, 0, 0x1f, 1),
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
