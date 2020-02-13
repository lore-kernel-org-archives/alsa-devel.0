Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFFC2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:22:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6452073C
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aPw7wh1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6452073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23994167B;
	Thu, 13 Feb 2020 12:22:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23994167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581592971;
	bh=yWz3ePsxwN8w6GzX78pxKRU+ROMA8MNdB/uv0XWI0eg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPw7wh1nXhaTRmfoL4RI09NlwzIx+7cnmAHFgU846xoGyVcmwT/RQeOfCyIOIJ9HB
	 zMZ8f/pykqN5qU12pcIRu8xOEmAnvny8zr/qonbeVmokVB3Du9CG1vfhWmfRiO0ayq
	 FDOYjFt4yMwsow5lBP6PrpkJOC0bJMelqQt8M6DY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03BE9F801DA;
	Thu, 13 Feb 2020 12:21:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CA5FF8013E; Thu, 13 Feb 2020 12:21:05 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81AD2F8013E
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 12:21:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81AD2F8013E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8D908B198;
 Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 13 Feb 2020 12:20:59 +0100
Message-Id: <20200213112059.18745-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213112059.18745-1-tiwai@suse.de>
References: <20200213112059.18745-1-tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH 2/2] ALSA: usb-audio: Parse source ID of UAC2
	effect unit
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

During parsing the input source, we currently cut off at the Effect
Unit node without parsing further its source id.  It's no big problem,
so far, but it should be more consistent to parse it properly.

This patch adds the recursive parsing in parse_term_effect_unit().
It doesn't add anything in the audio unit parser itself, and the
effect unit itself is still skipped, though.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206147
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 81b2db0edd5f..56d0878e4999 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -901,6 +901,12 @@ static int parse_term_effect_unit(struct mixer_build *state,
 				  struct usb_audio_term *term,
 				  void *p1, int id)
 {
+	struct uac2_effect_unit_descriptor *d = p1;
+	int err;
+
+	err = __check_input_term(state, d->bSourceID, term);
+	if (err < 0)
+		return err;
 	term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
 	term->id = id;
 	return 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
