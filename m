Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97248C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157742168B
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AE7A+8KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157742168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B4531665;
	Fri, 14 Feb 2020 12:15:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B4531665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581678990;
	bh=3MfN+heAY6KEKxXPBR0K7SvCjB9pR5rzgRwNi8vRa8Y=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AE7A+8KFif17R+kjdo7whb6ZhwTbzFGYjMOE6O6uhIyCs5iG8keIgmOn0Gmkqq1ua
	 GktXuLt/0hE1W8Xzu9sE4ReOyTTcy8AsKmS6Q/i80Fk1oJJ3Bqwsx/XwvJ7sFcgJC4
	 iDGlFudTPuO+2rtCN072Y1yfckjHahoSRhpdVtus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B31EF80278;
	Fri, 14 Feb 2020 12:13:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F07B3F80276; Fri, 14 Feb 2020 12:13:26 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EBA8F8013E
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 12:13:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EBA8F8013E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 496F0B1D3
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 11:13:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 14 Feb 2020 12:13:16 +0100
Message-Id: <20200214111316.26939-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200214111316.26939-1-tiwai@suse.de>
References: <20200214111316.26939-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 3/3] ALSA: rawmidi: Avoid bit fields for state
	flags
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

The rawmidi state flags (opened, append, active_sensing) are stored in
bit fields that can be potentially racy when concurrently accessed
without any locks.  Although the current code should be fine, there is
also no any real benefit by keeping the bitfields for this kind of
short number of members.

This patch changes those bit fields flags to the simple bool fields.
There should be no size increase of the snd_rawmidi_substream by this
change.

Reported-by: syzbot+576cc007eb9f2c968200@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 40ab20439fee..a36b7227a15a 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -77,9 +77,9 @@ struct snd_rawmidi_substream {
 	struct list_head list;		/* list of all substream for given stream */
 	int stream;			/* direction */
 	int number;			/* substream number */
-	unsigned int opened: 1,		/* open flag */
-		     append: 1,		/* append flag (merge more streams) */
-		     active_sensing: 1; /* send active sensing when close */
+	bool opened;			/* open flag */
+	bool append;			/* append flag (merge more streams) */
+	bool active_sensing;		/* send active sensing when close */
 	int use_count;			/* use counter (for output) */
 	size_t bytes;
 	struct snd_rawmidi *rmidi;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
