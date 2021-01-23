Return-Path: <SRS0=/iiV=G2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA2C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 12:16:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1145D23B08
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 12:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1145D23B08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5C0B1B0A;
	Sat, 23 Jan 2021 13:16:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5C0B1B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611404217;
	bh=oC7yXvoZi5qjytJ1GG5H3sx55at5q5MXvjm+kqT0DnI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BkOQtmaBg1/sbUqqWIeC6tEjoiIT2sC+/Ro6w/Fy5X5BPRVogaY9MhOmmUDXxNo6m
	 VakYF6KaIPckuZX5ZOA5Pv+wHHyW1C6e3diqDeCG67gDfi2kJnNanEws8T4gUoG/6N
	 DhiML8z3AezKCfHDXFTdjVUTILp11tkkxsTqm7tM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6D7EF804E6;
	Sat, 23 Jan 2021 13:13:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B173F804D6; Sat, 23 Jan 2021 13:13:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67A28F804BD
 for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2021 13:13:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67A28F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Rov/RYrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611404015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5X1cgAM/DzaQIFfxQG1LSHMJaNn26Co1JziKy7U1FM=;
 b=Rov/RYrlqw6PltoQgdM6ZWS8VbQtgzd/C9F0CP+jasotI6R+ECSkOvCBJBGK9V6nViRgcF
 IJOQVnJmmfB/neoKanfEa8e/+4NfMh+Lc31om2sCsCmVV9VZ68GrcqADSoCi8Ip5yCVOEa
 UhCDdvWdbqaWI6iLCuXszEeQS6lfjZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-pBemKfxgMFuH_FsivK_d7Q-1; Sat, 23 Jan 2021 07:13:31 -0500
X-MC-Unique: pBemKfxgMFuH_FsivK_d7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B4E10051A7;
 Sat, 23 Jan 2021 12:13:29 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-82.ams2.redhat.com [10.36.112.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 581E419C95;
 Sat, 23 Jan 2021 12:13:27 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 05/13] extcon: arizona: Always use pm_runtime_get_sync()
 when we need the device to be awake
Date: Sat, 23 Jan 2021 13:13:05 +0100
Message-Id: <20210123121313.79530-6-hdegoede@redhat.com>
In-Reply-To: <20210123121313.79530-1-hdegoede@redhat.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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

Before this commit the extcon-arizona code was mixing pm_runtime_get()
and pm_runtime_get_sync() in different places.

In all places where pm_runtime_get[_sync]() is called, the code
makes use of the device immediately after the call.
This means that we should always use pm_runtime_get_sync().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/extcon/extcon-arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 72d23b15108c..56d2ce05de50 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -290,7 +290,7 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
 	unsigned int mode;
 
 	/* Microphone detection can't use idle mode */
-	pm_runtime_get(info->dev);
+	pm_runtime_get_sync(info->dev);
 
 	if (info->detecting) {
 		ret = regulator_allow_bypass(info->micvdd, false);
@@ -695,7 +695,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	dev_dbg(arizona->dev, "Starting HPDET\n");
 
 	/* Make sure we keep the device enabled during the measurement */
-	pm_runtime_get(info->dev);
+	pm_runtime_get_sync(info->dev);
 
 	info->hpdet_active = true;
 
-- 
2.29.2

