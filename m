Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC9C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5302080C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YTO24irE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5302080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E42D0167C;
	Mon, 10 Feb 2020 14:27:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E42D0167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581341297;
	bh=kZUQ8HgLsR4sN7yAzTOeih46C4xm1ZfV0mquQRzgsQ4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTO24irEEc4vy4lyGnKXexgzdUem1Zoqgh7PiiEqSuFjMqpPwoq9QzK5nPj1lsQvs
	 HWZ3LuxgtLnrt3cF3dqqgzil1aduyXs37nI+qUPR5UKOlTQX2iUNty6QDETQr1Cx/2
	 Xb/1OZSal2TZ6uhw23SsrNhur6DiL+2RdBH+YsDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D12AF8020B;
	Mon, 10 Feb 2020 14:26:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 523D5F8020B; Mon, 10 Feb 2020 14:26:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC0CAF800FD
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 14:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC0CAF800FD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1A425B1DA
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 13:25:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 10 Feb 2020 14:25:15 +0100
Message-Id: <20200210132516.20221-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200210132516.20221-1-tiwai@suse.de>
References: <20200210132516.20221-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH alsa-lib 2/3] topology: Drop
	SNDRV_CTL_ELEM_ACCESS_TIMESTAMP access
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

SNDRV_CTL_ELEM_ACCESS_TIMESTAMP is removed from 5.6 kernel ABI as the
ctl timestamp field has been never used and deprecated.
Drop the corresponding access from the topology code, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/topology/ctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index b78f1c54be05..90241b6318c5 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -35,7 +35,6 @@ static const struct ctl_access_elem ctl_access[] = {
 	{"read", SNDRV_CTL_ELEM_ACCESS_READ},
 	{"write", SNDRV_CTL_ELEM_ACCESS_WRITE},
 	{"volatile", SNDRV_CTL_ELEM_ACCESS_VOLATILE},
-	{"timestamp", SNDRV_CTL_ELEM_ACCESS_TIMESTAMP},
 	{"tlv_read", SNDRV_CTL_ELEM_ACCESS_TLV_READ},
 	{"tlv_write", SNDRV_CTL_ELEM_ACCESS_TLV_WRITE},
 	{"tlv_command", SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND},
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
