Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360FC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 10:16:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDCF60C40
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 10:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BDCF60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10CC91674;
	Tue, 12 Oct 2021 12:15:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10CC91674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634033785;
	bh=QqLCxp4lKNPjCDCSuEqgvPyTOrxt2LTtu+rXTKFNMaA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MglKT1Nz9SMD1nU7NElCZg8s4B/0kq61YQ3+r/cF408q1IfVImTgb8S+vNcWcEIBZ
	 CcgvO0Mlq0y2dhw9plbbuxQjeyECjDoA52lPiZW4y7R04eVFPgaVno0V6ClsPerlnv
	 0SqbVUcP21LPqOTT6rRATzEdWcezxfh91d4zWZIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0F5DF801F7;
	Tue, 12 Oct 2021 12:15:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C8D8F80212; Tue, 12 Oct 2021 12:15:33 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 250F3F800C0
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 12:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 250F3F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="I6JH1SD4"
Received: by mail-wr1-x434.google.com with SMTP id t2so65342793wrb.8
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6QbSN9AwgyB7YvMXjQ9wGOfwm5L9SfWX6cJ4H4aiOcw=;
 b=I6JH1SD4d+mxJgU41Ukt5Yi7cIner7iuvPmkLYnQE8EuACtOW7bFgFigqbMeJX0THw
 xP/cb89RpE7uokfUFL93RNjkwHW5voE0Gk4eg4LKGaRRonx4Q36UXqSiYUP8NMxXY7MS
 2Ugw+A3pKYhZTrSIXOW5K1vIAjXHnjwBO96YK3wc6eG1rwb1OLs+9bzrJ48y7vHnwZQq
 poPwCunfY9338ddLwYQSwSNpemrUGQQglAkzc2v6DX4tDnshC1My8JvLnJkdi083o7J7
 u2TLx+8LpNa/XY29A28R+V+jZPlrO/crvHVaHqu0W6VqfldPunV/fst+eNjqtNk0lp5E
 NIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6QbSN9AwgyB7YvMXjQ9wGOfwm5L9SfWX6cJ4H4aiOcw=;
 b=HfLzyvVBcmInbdRWzXiNEy+sHkgGaoTBIQakpGaMveB10UDBwLPJ6duyCnGyyXIxy6
 FD4U5TUWdxgDds/JPEe5WfxfmRgjq54hVnBW3U2mGWufPxwavSEHEM4RIJMiAW9Zho7H
 lSZtVSmjSGQISS/qUTwUI6h2jRHFQU/calAb6/ow4TxTRpElJn6WnD2dp7I09vl2dNxt
 s3GiU+sa/2Fc9JnGb1OqFNvMZvr9kK7XFzQgeha1C8vhyIYG8uatjmoMYsSLS7YtWz1F
 GlEX4M/Ih3DV085bbwJvbJsJfm92iGtYW06RYkyAJ7OiY1Bm8oGMBNxTKuUfvoRiwFpa
 8dEA==
X-Gm-Message-State: AOAM532GacwnKrxMWDbiftrML8IvF0G4cv6I7eEKY+I9SbHCYfqJmQf/
 IcLsE7yQn04fRAE0Tzy3Gjtz7A==
X-Google-Smtp-Source: ABdhPJwdxCHHOZ/oslBbeIuL0n1JOu3yAprRsBzGm4vMqJrW4NjI0W2onXTmmR87QR8VLNUzEjpS+Q==
X-Received: by 2002:adf:b748:: with SMTP id n8mr30225878wre.133.1634033724575; 
 Tue, 12 Oct 2021 03:15:24 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id t21sm2026514wmi.19.2021.10.12.03.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 03:15:24 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH] soundwire: bus: stop dereferencing invalid slave pointer
Date: Tue, 12 Oct 2021 11:15:21 +0100
Message-Id: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 rander.wang@intel.com, sanyog.r.kale@intel.com,
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

Slave pointer is invalid after end of list iteration, using this
would result in below Memory abort.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
...
Call trace:
 __dev_printk+0x34/0x7c
 _dev_warn+0x6c/0x90
 sdw_bus_exit_clk_stop+0x194/0x1d0
 swrm_runtime_resume+0x13c/0x238
 pm_generic_runtime_resume+0x2c/0x48
 __rpm_callback+0x44/0x150
 rpm_callback+0x6c/0x78
 rpm_resume+0x314/0x558
 rpm_resume+0x378/0x558
 rpm_resume+0x378/0x558
 __pm_runtime_resume+0x3c/0x88

Use bus->dev instead to print this error message.

Fixes: b50bb8ba369cd ("soundwire: bus: handle -ENODATA errors in clock stop/start sequences")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1b115734a8f6..67369e941d0d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1110,7 +1110,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 	if (!simple_clk_stop) {
 		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
 		if (ret < 0)
-			dev_warn(&slave->dev, "clock stop deprepare wait failed:%d\n", ret);
+			dev_warn(bus->dev, "clock stop deprepare wait failed:%d\n", ret);
 	}
 
 	list_for_each_entry(slave, &bus->slaves, node) {
-- 
2.21.0

