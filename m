Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE0C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:02:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F89320716
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b7erIMoa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6LjyIQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F89320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96B9516C5;
	Thu, 12 Mar 2020 11:01:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96B9516C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584007329;
	bh=sdeU6LDbNkFCbp537Yb+OCZtmlVpOEBLv5AROfcO00k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b7erIMoaG1auYpRrdS82FnRRsiSqqaUqJQ1PQrF02B3VvtgS/hGW0MuwFG3u9Zf5o
	 crK+D10veQtDtGgembExHMqOz2INc+rM/dSTe307A9PuE+YvmRZwfoFqU+RhD+Qjck
	 v7IJWn4bXo4mEmd58Q0vJgfHljyPeAcJfCw+UJGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 178DDF801D9;
	Thu, 12 Mar 2020 11:01:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07382F8020C; Thu, 12 Mar 2020 11:01:17 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F797F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 11:01:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F797F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="P6LjyIQp"
Received: by mail-wm1-x343.google.com with SMTP id e26so5502699wme.5
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=37Lf+bsQVN2R82jF31L64+HZkWkQ8O4yUOQJhHVjoWQ=;
 b=P6LjyIQphSa///CYVi66m3AtkFhIVjNwaO+ppt664/mHCIk8BrVUFecR7dtX1OAbxM
 j9tCmCw/UkRia/Bh5gFwH68MCf07hCYA71ytUlGL+XVYdtUyS8Vr3EVeMaNJrY+1fqfC
 DqR1p0crSsax67xGqu0pn1++v4VBue8+FQujM2v4CV6JUbWsnQkALOZm52M9J/8EGOh4
 fGn9m/wSeNQMhf5ippEai1zIqG9LDf6FOS+y11BQ9Ajv78IsvXRgRGR5iEJfGvf26ugF
 cwjRdf90NRY3O/3JZfQ4gknFVTjXS4GS0BABIV9YylqWRZmymStXzE4wJHaUZ8uGgsNE
 kihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=37Lf+bsQVN2R82jF31L64+HZkWkQ8O4yUOQJhHVjoWQ=;
 b=iLR1jFYBVU63EP+eduabc1EPoJlcbV1zZXp2urpqxjBPfrkpLNKSKW/5MTvvBZGvPd
 meL/4uwNl7a70WKkQvOX18XT5RTJTywAIfqWIY3Bro0rB2k7qyNwHttDo4jbMJiTRTNQ
 6zghyMJFfuz3wqyoVJQ7gRxbkcPE/Lkhv42TZfaQQL2AGVrh5S7sPBeAJXljuRedl9iM
 mib90Fkoam4HjYmLzhAGJFsA5tiqlMvrAhieT78msiGx0q3ohWGE6KMWDlWDX3OZeb9d
 r7iUnVWERljc9AH/06k+YqZPmickKJ4gbsNNBxjvyjzg79X0qvONhr5AUtjKXfOYnQu7
 N0eg==
X-Gm-Message-State: ANhLgQ2E/1Iw+EujT3q1SM9h2cIr50ynKHkYAEk/talpHoxSo56tHtgN
 Z29T57ZYi+aXZy+64bcYmq0wcw==
X-Google-Smtp-Source: ADFU+vusgtSoMtov30GQT3tj+aY6RnUcVmcqV8+vs/QPI0Klxsxj1Dzh9dy/w/xeOJ9E0j8rBotkyQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3985968wmc.18.1584007273297; 
 Thu, 12 Mar 2020 03:01:13 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id m11sm27568999wrn.92.2020.03.12.03.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 03:01:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH] soundwire: stream: use sdw_write instead of update
Date: Thu, 12 Mar 2020 10:01:05 +0000
Message-Id: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org
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

There is no point in using update for registers with write mask
as 0xFF, this adds unecessary traffic on the bus.
Just use sdw_write directly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00348d1fc606..1b43d03c79ea 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -313,9 +313,9 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
 	 * it is safe to reset this register
 	 */
 	if (en)
-		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
+		ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
 	else
-		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+		ret = sdw_write(s_rt->slave, addr, 0x0);
 
 	if (ret < 0)
 		dev_err(&s_rt->slave->dev,
@@ -464,10 +464,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 		addr = SDW_DPN_PREPARECTRL(p_rt->num);
 
 		if (prep)
-			ret = sdw_update(s_rt->slave, addr,
-					 0xFF, p_rt->ch_mask);
+			ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
 		else
-			ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+			ret = sdw_write(s_rt->slave, addr, 0x0);
 
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
-- 
2.21.0

