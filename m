Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8602AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 10:47:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD8E6522F
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 10:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD8E6522F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A82F17C0;
	Tue,  9 Mar 2021 11:46:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A82F17C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615286839;
	bh=q7TCrxGPgaFDDwut9gANJTEe4kt30Dd5UubcYDy3MJQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QghG9icITupXjjwY4nQbq3QMFodM+QTEcgAfeUctp+T+azVr23QOV1ZDUhDJe4cli
	 g4gPYWTH5fuLk8AsncAzHySEF7fJyY7SZzvgBvGEuBDEKokIISKQzgttLxABqdxdSi
	 edKdKofj+DvJIYtgP643f6+EJpdmXGzPBoM8pQmI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FEF3F80166;
	Tue,  9 Mar 2021 11:46:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 597E0F80227; Tue,  9 Mar 2021 11:46:27 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6571F80166
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 11:46:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6571F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="yXGd7BRW"
Received: by mail-wr1-x42b.google.com with SMTP id v15so14665330wrx.4
 for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2021 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hgVWZEqabwtY8oTbHl56afq/3bLl+c8areS1KZJWAVI=;
 b=yXGd7BRWOQStzPiUrhWp/J4pka8r0eqo7SiwvqWMZaZWkCJcDqZMlYA3XcBk+pUOi4
 jHZF20WowwZNBnBW9ZwsM/cjpsKU6chmSP3LHtoizaMoQG52n5UoFRsaZbsBtz8wzmKy
 JkGmB9W94LpfWV3Fgd7t676/FptJrtL3X9MYEi69cyglpf50KVXXvZmqNPoEDD4rcT5d
 fciJa4JKuNq22HN0PLi3H3GQeJe61LpFdy43/LYFpfTnst9scIn+Avv/wzdOdZ+ck55L
 RXOsduQNtTzcHSoeEt1P9bZMg0o5gWQvuDPwzmrXRBFOng7KX/8YwHXxW23UECUHBPU4
 jGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hgVWZEqabwtY8oTbHl56afq/3bLl+c8areS1KZJWAVI=;
 b=B4P051r5h1cJALl7dHMzPdxuR6OY+Ne3rTZk3U2Qoz7a8BhLbOmRARNCNSynI4n/Xw
 UQ9IkANnBCNzruNYi6j/fqQXzPpGWULsFzS7p+fG5kES0oMRnTBmHYGO7D2EBsxv+wPY
 qk9KsyUET7AY1ZJrM0xX0rB0KSV+BWqBLhPwWMFWPgwHphDP0yHsvUsqSAJjWcOAsr22
 s+NQ6j56LiWLhfXBSL9vSTXiTeV2JMdndt5MoxGgjCcgyGN6UkU9X3mi14mVcd1ydlOj
 F/POSJ4VHEkwU4R9kvGBiSF5+8boJ5mNm3La8yxk5LkKqUAcsYSEGKn3WsWxJJ1dbljy
 VvSQ==
X-Gm-Message-State: AOAM531/q1Y4iEzJ+lKE9KZF4qD/XRC1IsVO+yWqk8GY3d1Ihu45oAY/
 TD3IS4W+HQIvar7BH7CP2I0V6w==
X-Google-Smtp-Source: ABdhPJyZ6smkiEJ5ukOwUoQuvdOIpzbEyMiThIZMwtxk/GP3xroQFuPBgcypzFLYrqqozmu1C1gT+w==
X-Received: by 2002:a05:6000:23c:: with SMTP id
 l28mr14121211wrz.251.1615286776262; 
 Tue, 09 Mar 2021 02:46:16 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id j12sm23228298wrx.59.2021.03.09.02.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 02:46:15 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v2] soundwire: bus: Fix device found flag correctly
Date: Tue,  9 Mar 2021 10:46:08 +0000
Message-Id: <20210309104608.19067-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

found flag is used to indicate SoundWire devices that are
both enumerated on the bus and available in the device list.
However this flag is not reset correctly after one iteration,
This could miss some of the devices that are enumerated on the
bus but not in device list. So reset this correctly to fix this issue!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9ab4a6264e0..188e391c5a83 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -712,7 +712,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	struct sdw_slave *slave, *_s;
 	struct sdw_slave_id id;
 	struct sdw_msg msg;
-	bool found = false;
+	bool found;
 	int count = 0, ret;
 	u64 addr;
 
@@ -744,6 +744,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 		sdw_extract_slave_id(bus, addr, &id);
 
+		found = false;
 		/* Now compare with entries */
 		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
 			if (sdw_compare_devid(slave, id) == 0) {
-- 
2.21.0

