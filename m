Return-Path: <SRS0=JyZJ=PK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EDCC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Oct 2021 06:50:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA3A60F50
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Oct 2021 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAA3A60F50
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 144801675;
	Fri, 22 Oct 2021 08:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 144801675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634885448;
	bh=V/7h/HWgYu47JjyyoomvGtaep/9RRePXtoBUCgngOeM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnByVHngjErXEnOLtptYBUQZ2nsNKKATYTV3Hgfqv/pUMBU3Hx+QE+r0koR5M3qGL
	 /m2gmiw7XyOs3jqBffpkS8NqTVGH/41090X9HK6qN9pliFlP5sUKFJ7xExNE5Aa18R
	 JgbDWdQ6bVo5yzBPR3kUtl+/B3miMD7woco07FR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 669B6F802A9;
	Fri, 22 Oct 2021 08:49:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FBA1F802DF; Fri, 22 Oct 2021 08:49:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 725C0F8011C
 for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2021 08:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 725C0F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.b="SdSUM0Fo"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3BC221990;
 Fri, 22 Oct 2021 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1634885345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAsfBSRBhYlwXE3GyHCt8Ao1r3itvvqFCqQg0v1jsus=;
 b=SdSUM0FodxI8IXPl1XHMXJhVw3Me2pABjtUdj1hKPdqshPqCIsAAXZqsRZO1aUudUaxmtl
 JuhtTn1OVnzf6RV7Te3zCJgEJIA3GyWHiKamnv57aSsq/rEENoQ9shSlnVgKz/g5U4u9/L
 hCTdddL//8JOOmVeoYV+a8q+iqYfjdY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A440413AAD;
 Fri, 22 Oct 2021 06:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AC3KJuFecmEIEwAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 22 Oct 2021 06:49:05 +0000
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] xen: flag xen_snd_front to be not essential for system
 boot
Date: Fri, 22 Oct 2021 08:48:00 +0200
Message-Id: <20211022064800.14978-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211022064800.14978-1-jgross@suse.com>
References: <20211022064800.14978-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Juergen Gross <jgross@suse.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
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

The Xen pv sound driver is not essential for booting. Set the respective
flag.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 sound/xen/xen_snd_front.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
index 2cb0a19be2b8..7be9fbcf788f 100644
--- a/sound/xen/xen_snd_front.c
+++ b/sound/xen/xen_snd_front.c
@@ -358,6 +358,7 @@ static struct xenbus_driver xen_driver = {
 	.probe = xen_drv_probe,
 	.remove = xen_drv_remove,
 	.otherend_changed = sndback_changed,
+	.not_essential = true;
 };
 
 static int __init xen_drv_init(void)
-- 
2.26.2

