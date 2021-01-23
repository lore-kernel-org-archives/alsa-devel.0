Return-Path: <SRS0=/iiV=G2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D442C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 12:15:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FD523B04
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 12:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FD523B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 748CD1AAB;
	Sat, 23 Jan 2021 13:14:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 748CD1AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611404116;
	bh=zslb9ZHe4dHv9y3qVr7IQt4ZIkL0fhJg/NzY43tjmJg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GgIM7PXGNKTUVpcfF81m7cbU+gaFIgeAOMb9XZoFP/KTGZK2LVc2kElqDt/PPSKM2
	 6n4L+xpnwOy4tMcU2KOv9asoN1uK/ey3WZMXGMmpwjFp+3uO0LgOhdZpu9u3oKQY1H
	 8MUiQI/2JcysEFtfXm3snaj3fIP/wDOHqvcoJHe4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF8C8F80273;
	Sat, 23 Jan 2021 13:13:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F177F80257; Sat, 23 Jan 2021 13:13:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DACA9F80083
 for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2021 13:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DACA9F80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Nk6kFxDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611404004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRZf4d8I7ebk3tNzhg7NOHEudUJ2Wj4S9A+g9IN4Pys=;
 b=Nk6kFxDINvYqBfpRhe+e40FU6OFjkZraCNvkyLqTW0GDqJWqmrqEbx+OyfgS9kht+GbYfs
 nvOBS6JXb7Tjzk1HE59nmPQuD8NdfJLxHCHfdGiuJcXuZORDvk2VaY9TcZ7W6wSAkDJWqX
 2YKmyjZ9eGu9BMUU3BrilykSGZvnCok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-fx7u7xUsMEO-JGo-diTODQ-1; Sat, 23 Jan 2021 07:13:21 -0500
X-MC-Unique: fx7u7xUsMEO-JGo-diTODQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8990D10054FF;
 Sat, 23 Jan 2021 12:13:19 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-82.ams2.redhat.com [10.36.112.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3D4189B8;
 Sat, 23 Jan 2021 12:13:17 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 01/13] mfd: arizona: Drop arizona-extcon cells
Date: Sat, 23 Jan 2021 13:13:01 +0100
Message-Id: <20210123121313.79530-2-hdegoede@redhat.com>
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

The arizona jack-dection handling is being reworked so that the
codec-child-device drivers directly handle jack-detect themselves,
so it is no longer necessary to instantiate "arizona-extcon"
child-devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-core.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 75f1bc671d59..ce6fe6de34f8 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -881,11 +881,6 @@ static const char * const wm5102_supplies[] = {
 static const struct mfd_cell wm5102_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -898,11 +893,6 @@ static const struct mfd_cell wm5102_devs[] = {
 static const struct mfd_cell wm5110_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -939,11 +929,6 @@ static const char * const wm8997_supplies[] = {
 static const struct mfd_cell wm8997_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm8997_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
@@ -956,11 +941,6 @@ static const struct mfd_cell wm8997_devs[] = {
 static const struct mfd_cell wm8998_devs[] = {
 	{ .name = "arizona-micsupp" },
 	{ .name = "arizona-gpio" },
-	{
-		.name = "arizona-extcon",
-		.parent_supplies = wm5102_supplies,
-		.num_parent_supplies = 1, /* We only need MICVDD */
-	},
 	{ .name = "arizona-haptics" },
 	{ .name = "arizona-pwm" },
 	{
-- 
2.29.2

