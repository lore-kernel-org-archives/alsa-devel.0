Return-Path: <SRS0=ctet=F7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7FC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 21:18:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07AB20659
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 21:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07AB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 951FE17AB;
	Sun, 27 Dec 2020 22:17:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 951FE17AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609103885;
	bh=+/UwWk/EKTdhob+cOSogvtlwDcaejohqyO8xb+ih63Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phKuo6sNo1Ueh20j6Caz9DyjJd7azb8Bbp0a80j2jT4htLe4Qy1hOUFAMrSAlMFZy
	 vpmsp2onPhCQw60gGb1/ERNQ26WUyM2E0l6PKucYf7mG63wFp5oy9znKHm9XuH5hfU
	 tKe+3ZtsRLNRx1snyw7vGDXnpjSx5Iwthow3Ssp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39F86F8051C;
	Sun, 27 Dec 2020 22:13:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABFCBF80517; Sun, 27 Dec 2020 22:13:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87EF1F804FF
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 22:13:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87EF1F804FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="bJ8QbkKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609103587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuEkoy8risjXWW3C4tHd58C62AQQjBX95B2fmp+oAVw=;
 b=bJ8QbkKKa1kU9nF+CGVm4HOGEqKgsnK46Ko+ok7AJaTI/0x2t5zluAY7DLIUpsu2dwj6zW
 PVWJVR6uSfwodjIpbU4sEO2DmWh4wCgN0n3Z289H85EgFZLKOpLI37V9LT9Zri1YwLJLIT
 utXb9Gfh0x9chiH3SKilnjavpVcrTa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-4kPUDcs5OTa3Hf9uLhBJXw-1; Sun, 27 Dec 2020 16:13:03 -0500
X-MC-Unique: 4kPUDcs5OTa3Hf9uLhBJXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA2D801A9E;
 Sun, 27 Dec 2020 21:13:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF901ACB9;
 Sun, 27 Dec 2020 21:12:59 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 10/14] extcon: arizona: Also report jack state through
 snd_soc_jack_report()
Date: Sun, 27 Dec 2020 22:12:28 +0100
Message-Id: <20201227211232.117801-11-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

The Linux Arizona driver uses the MFD framework to create several
sub-devices for the Arizona codec and then uses a driver per function.

The extcon-arizona driver handles jack-detect support and exports info
about the jack state to userspace through the standard extcon sysfs
class interface.

Standard Linux userspace does not monitor/use the extcon sysfs interface
for jack-detection, resulting in the jack-state not being taken into
account by userspace.

The ASoC machine-driver may have created a standard ASoC jack when
registering the card. In this case also report the jack-state through the
ASoC jack so that jack-detection works with standard Linux userspace.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index d5b3231744f9..931a7d239aea 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/extcon-provider.h>
 
+#include <sound/jack.h>
 #include <sound/soc.h>
 
 #include <linux/mfd/arizona/core.h>
@@ -598,11 +599,19 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
 static void arizona_set_extcon_state(struct arizona_extcon_info *info,
 				     unsigned int id, bool state)
 {
-	int ret;
+	int ret, mask = 0;
 
 	ret = extcon_set_state_sync(info->edev, id, state);
 	if (ret)
 		dev_err(info->arizona->dev, "Failed to set extcon state: %d\n", ret);
+
+	switch (id) {
+	case EXTCON_JACK_HEADPHONE:	mask = SND_JACK_HEADPHONE;	break;
+	case EXTCON_JACK_MICROPHONE:	mask = SND_JACK_MICROPHONE;	break;
+	}
+
+	if (info->arizona->jack && mask)
+		snd_soc_jack_report(info->arizona->jack, state ? mask : 0, mask);
 }
 
 static irqreturn_t arizona_hpdet_irq(int irq, void *data)
-- 
2.28.0

