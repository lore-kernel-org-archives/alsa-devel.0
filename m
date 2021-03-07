Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E0C433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 15:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF483650F7
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 15:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF483650F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6955D1EEE;
	Sun,  7 Mar 2021 16:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6955D1EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615130423;
	bh=2vwArPWj+eGTCbbUX4pPCIYek4sB31yxSWMWKOBmtFA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FSPyQ0PcumWWBvJeIslslwkV7/REs9AziY3whzxpS7LkbrOF/D9fDQswTH0tbC/LN
	 QG/lzkleTzaEsKdnmhQyl1EFJyBQxWiWRCHNBeXLwWFG9Z+ts2T+sMusx8irOKr6GS
	 tSMMDRA4vQwQ0eUg7RpRtzjXOB8r/d/oyqEo5ybE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C501F80424;
	Sun,  7 Mar 2021 16:18:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33840F80139; Sun,  7 Mar 2021 16:18:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DD2FF8019B
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 16:18:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DD2FF8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="e1v8evZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615130306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j8bo2aK6fNVhEqJSka12dREMEZJ3jgUOSDr9yB59K4=;
 b=e1v8evZu1ZWFPhSdwdNU75ypD9R0ratzf6Cb/JRs2KTdl/p0Ka9IOd/+iQRgH3n267jw29
 3Wjn0RvJDjfJY8gf/WO/5Q64B/BQQvC6bbHAtB4fFn+JCnSLTHDNUq9Vm/QN0G8Q9UKF3L
 Agn3/7BQBYq9S7bngk3hRCzxnlH2Elw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-RwHPl3_EOa2eFKPypQnagw-1; Sun, 07 Mar 2021 10:18:24 -0500
X-MC-Unique: RwHPl3_EOa2eFKPypQnagw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 782F626862;
 Sun,  7 Mar 2021 15:18:22 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4CE60BF1;
 Sun,  7 Mar 2021 15:18:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 resend 02/13] extcon: arizona: Fix some issues when HPDET
 IRQ fires after the jack has been unplugged
Date: Sun,  7 Mar 2021 16:17:56 +0100
Message-Id: <20210307151807.35201-3-hdegoede@redhat.com>
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
References: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

When the jack is partially inserted and then removed again it may be
removed while the hpdet code is running. In this case the following
may happen:

1. The "JACKDET rise" or ""JACKDET fall" IRQ triggers
2. arizona_jackdet runs and takes info->lock
3. The "HPDET" IRQ triggers
4. arizona_hpdet_irq runs, blocks on info->lock
5. arizona_jackdet calls arizona_stop_mic() and clears info->hpdet_done
6. arizona_jackdet releases info->lock
7. arizona_hpdet_irq now can continue running and:
7.1 Calls arizona_start_mic() (if a mic was detected)
7.2 sets info->hpdet_done

Step 7 is undesirable / a bug:
7.1 causes the device to stay in a high power-state (with MICVDD enabled)
7.2 causes hpdet to not run on the next jack insertion, which in turn
    causes the EXTCON_JACK_HEADPHONE state to never get set

This fixes both issues by skipping these 2 steps when arizona_hpdet_irq
runs after the jack has been unplugged.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index aae82db542a5..f7ef247de46a 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -601,7 +601,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	struct arizona *arizona = info->arizona;
 	int id_gpio = arizona->pdata.hpdet_id_gpio;
 	unsigned int report = EXTCON_JACK_HEADPHONE;
-	int ret, reading;
+	int ret, reading, state;
 	bool mic = false;
 
 	mutex_lock(&info->lock);
@@ -614,12 +614,11 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	}
 
 	/* If the cable was removed while measuring ignore the result */
-	ret = extcon_get_state(info->edev, EXTCON_MECHANICAL);
-	if (ret < 0) {
-		dev_err(arizona->dev, "Failed to check cable state: %d\n",
-			ret);
+	state = extcon_get_state(info->edev, EXTCON_MECHANICAL);
+	if (state < 0) {
+		dev_err(arizona->dev, "Failed to check cable state: %d\n", state);
 		goto out;
-	} else if (!ret) {
+	} else if (!state) {
 		dev_dbg(arizona->dev, "Ignoring HPDET for removed cable\n");
 		goto done;
 	}
@@ -667,7 +666,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 		gpio_set_value_cansleep(id_gpio, 0);
 
 	/* If we have a mic then reenable MICDET */
-	if (mic || info->mic)
+	if (state && (mic || info->mic))
 		arizona_start_mic(info);
 
 	if (info->hpdet_active) {
@@ -675,7 +674,9 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 		info->hpdet_active = false;
 	}
 
-	info->hpdet_done = true;
+	/* Do not set hp_det done when the cable has been unplugged */
+	if (state)
+		info->hpdet_done = true;
 
 out:
 	mutex_unlock(&info->lock);
-- 
2.30.1

