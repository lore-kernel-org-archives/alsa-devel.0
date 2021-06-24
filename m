Return-Path: <SRS0=UF41=LS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50248C49EA5
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 17:17:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC93C61166
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC93C61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nihaljere.xyz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3B3C83D;
	Thu, 24 Jun 2021 19:16:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3B3C83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624555032;
	bh=Hu8JaT9Km6GBXYrpmirJG9u8etu1H3SLUaxK17oMB2U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FQ7QJfturhruHDyS0WsQ3ajiiFU2tTynA66zLAPkXABQ4BH6Y5xNBtFebQdDvM3X4
	 hBCLmzX/dzMKVxYrqK8ayr1hB9bBdrmmZEmcB0x/DTr10hMxiTtH5JIMmwTAiLm4zM
	 WhkaVNPGbZAUTIudXWnUZzzKVytoufMsauSES/LA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61F69F8025F;
	Thu, 24 Jun 2021 19:16:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4B5FF80268; Thu, 24 Jun 2021 19:16:21 +0200 (CEST)
Received: from mail.nihaljere.xyz (nihaljere.xyz [142.11.196.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36A06F800E1
 for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2021 19:16:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36A06F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nihaljere.xyz header.i=@nihaljere.xyz
 header.b="ldnKBOGc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20200619; bh=Hu8JaT9Km6G
 BXYrpmirJG9u8etu1H3SLUaxK17oMB2U=; h=date:subject:cc:to:from; 
 d=nihaljere.xyz;
 b=ldnKBOGcEBy679w7MSRWsTR3xMAzC/qZD36MYQihvfCnKd44Dq+
 fUPBLhS8W6LNMVt8BT622KgGImRxqVTLtOjJJ+22/FQ01U3nEEfeNU969JQKdEc+srnwCP
 EPtCbxHVWIXOLZSpQXzUm1c0Slb4d0kKjx0caXrrMsA7i3hF+o=
Received: from localhost (136-49-115-232.googlefiber.net [136.49.115.232])
 by vps.nihaljere.xyz (OpenSMTPD) with ESMTPSA id eb474e66
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Thu, 24 Jun 2021 12:16:06 -0500 (CDT)
From: Nihal Jere <nihal@nihaljere.xyz>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 1/2] control: fix typo
Date: Thu, 24 Jun 2021 12:15:59 -0500
Message-Id: <20210624171559.14003-1-nihal@nihaljere.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nihal Jere <nihal@nihaljere.xyz>
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

Signed-off-by: Nihal Jere <nihal@nihaljere.xyz>
---
 src/control/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/control.c b/src/control/control.c
index 91415b51..3930c7b1 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -390,7 +390,7 @@ int snd_ctl_card_info(snd_ctl_t *ctl, snd_ctl_card_info_t *info)
 /**
  * \brief Get a list of element identifiers
  *
- * Before calling this function, memoru must be allocated using
+ * Before calling this function, memory must be allocated using
  * snd_ctl_elem_list_malloc().
  *
  * This function obtains data from the sound card driver and puts it
-- 
2.32.0

