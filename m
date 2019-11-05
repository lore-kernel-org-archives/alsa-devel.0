Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026AC17460
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1994A21928
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ks1wxmn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1994A21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF7B416E5;
	Tue,  5 Nov 2019 15:35:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF7B416E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572964552;
	bh=kFFn8ISQ0kW31uPYPk751hKhq7lg8Upm/GPI9ZRh71o=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ks1wxmn9fL76c7bljZwfbtRKl9xw6KzikzdBn9A0ZB1CQsQkaZbmpNfm3MZQpQyWQ
	 ApTIzL+UL2c9eWEHu3acBD1sftVUPXf5mEpu35fQBRJkuy4+XmDsPMs4tccNsF9Ilm
	 STf9XxukqhMYRxiYTmw0SeP5U8Nav2maPQ4z5/Ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFC87F8053B;
	Tue,  5 Nov 2019 15:34:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7DA2F805AE; Tue,  5 Nov 2019 15:34:06 +0100 (CET)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF765F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:34:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF765F8015B
IronPort-SDR: S4Hn+J5hRlF3r5Zh7D5HQ7wFEifFQZGlGN5gQOqIi6uENL1kvuieFH/6Hf65rHey+tbgkROr0h
 FqBgjJZezYeQaWimN1nAgXQHsmahKNwjOSz18vufJaYKbDW7W8QFIQzx09ap8om1Q3Mwz2iT3o
 zq20yES3QEctWAb69Qs7dAMRnuym8965TLc9mzBW+EJelbSz0KOQOqugx0ce8UTwUZKxnyj92v
 N/X5tRP8V1KXDzWcvxU3wL+0XVqg5Tmw2L23RTqSyT4FD/+sbmxACnNKZlXUDiaKbXOX5zDsbl
 bz4=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; d="scan'208";a="44730617"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:33:58 -0800
IronPort-SDR: qjebKaLnrsPkMpPO+bqlb4ZUFikKKsuV6qLx0X33fJ9CyK6rnqiKzlpyIn4NfiQsDDJ1ZRjJU1
 yoTEvNcyJq7KB2W16812TynYTQ5p4KVtd2zTeJqDtnET7JITaLxqqRMf6hlCYRJXAplcE+X1nx
 1A2F6vGsvo566KlHPTXupHTditAVIXn/uXbl4J4F0hlHrQTm26gR+NKMYZbseSXKrPeqoPxZdP
 6TV5zSKr1mjCxXEYZtmPKjbgdrly7aJLtW+r+zIB5pHtY/ZZp5jb7NymgvBbxvolbjsCIAZUW1
 PQc=
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timo Wischer
 <twischer@de.adit-jv.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Tue, 5 Nov 2019 08:32:11 -0600
Message-ID: <20191105143218.5948-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Subject: [alsa-devel] [PATCH v2 1/8] ALSA: aloop: Describe units of variables
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9ccdad89c288..1f5982e09025 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -102,8 +102,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
