Return-Path: <SRS0=1bGq=GU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D8DC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 22:17:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73871224DF
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 22:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73871224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBA921772;
	Sun, 17 Jan 2021 23:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBA921772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610921841;
	bh=u1dJn0PC6j0KXn9zYnYHl80+R/ZYqJFNm+ucNRlz2Fo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UIiuwOruihctOnI98RdBT8LJx0DSWTP/+oMaLBFgpxPUHTSbS6//S4pKcMp9teBgW
	 CqJsY9JzNKGK2X8m8+eDMuNfjhzWd/S9odoqIu2HZz/QH7HDx4WQXhU3eL7FFa3CTl
	 pbEmBZwNGS5Hli2Vp+bqXQeOWFRWk7M+xbu3MwhQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B127F80255;
	Sun, 17 Jan 2021 23:16:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6072AF80257; Sun, 17 Jan 2021 23:16:29 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E185EF80115
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2021 23:16:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E185EF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QhTPvho9"
Received: by mail-lf1-x133.google.com with SMTP id s26so21273652lfc.8
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2021 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kEQwHSt5wB+FY+WFucfVyvvqOmezqvFu6e0JdF0f7rc=;
 b=QhTPvho9EhN/5rHBWXQzenGdub9EnpcDaE6RWo4t0LK41xIzVZhRFpwJPcUt9X2fqq
 r5RpK07cl2eXDH6XdsmiuSvPI9b1B/vnCZew3lDSGEfgygbhBHBFwa3LJj9fzgnbQUU0
 Oga24U13FJOHncLCNfQB34RoscPVWOS8LEGcj8ibWQMTdxUMMVbVIj0Z14qgDXjolEcI
 Kv1LomVjVTtd9C9W1nlLL7Y0PZFIAx0nZ37yp+jlSiiOGsSHESBt9gFCkk7Emdf0lrdq
 JTEV90dO6ow3ocYT15rsxK+Y6SXiWldFEjRnMpPyhsiLKBblU+rONNz9zsPwP204cXl3
 2I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEQwHSt5wB+FY+WFucfVyvvqOmezqvFu6e0JdF0f7rc=;
 b=gprlQrTy6wuDEknW3Udnx6guO+sIIVuSUE88whI8sxmBQXLf77+jVb2CFV0TPdCJZX
 88RYbr8Gprh2CdcX8gg36YA1qBME2oXKHLKuRznExyJMhzOANR/xJ79sLOhEsN6q/egF
 gINFKemFr6abBvVHubG4Rcl4AmH3iLirGazQ/WJuq+WjFr0+bKWgqZ+yo/Dd5+G1ZINj
 NLTVL/KSXRYaJMgZWVLLSpSXDEJcmvgHfSRt7asKwLZBcU1GmyCf0IAGoOo4EUrFZYsI
 AgReq1Pynjz5Tl1603MgYlvQ2ySN/tnJaAgn5QpvLcMocg4VAm0mmLs6ZcG4fgZ8u45r
 IvGw==
X-Gm-Message-State: AOAM530hRCvuGCdY5sPwXy5JaBPCwwqDvjr+eag2L2DI9IMxIoBr8Mkn
 SkHiyElqt57v5yLod/e0i534joXJPNlX5Q==
X-Google-Smtp-Source: ABdhPJyvz9B2O1hXQosSgiboAyYNtVk1MFwHdbeuvC85sZ1pEGYSwwRJ5W3s0MbOlSySvMjuew+mpQ==
X-Received: by 2002:a19:890b:: with SMTP id l11mr10194400lfd.66.1610921785919; 
 Sun, 17 Jan 2021 14:16:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se.
 [158.174.22.164])
 by smtp.gmail.com with ESMTPSA id j20sm1510262ljc.47.2021.01.17.14.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Jan 2021 14:16:25 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH V2] soundwire: sysfs: Constify static struct attribute_group
Date: Sun, 17 Jan 2021 23:16:22 +0100
Message-Id: <20210117221622.34315-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
References: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, linux-kernel@vger.kernel.org,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

The only place sdw_slave_dev_attr_group is used is when its address is
passed to devm_device_add_group() which takes a pointer to const struct
attribute_group. Make it const to allow the compiler to put it in
read-only memory. This makes all attribute_group structs in the file
const. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes since v 1: Fix spelling in commit message title (sorry for the noise...)

 drivers/soundwire/sysfs_slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index b48b6617a396..3210359cd944 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -130,7 +130,7 @@ static struct attribute *slave_dev_attrs[] = {
  * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
  * for device-level properties
  */
-static struct attribute_group sdw_slave_dev_attr_group = {
+static const struct attribute_group sdw_slave_dev_attr_group = {
 	.attrs	= slave_dev_attrs,
 	.name = "dev-properties",
 };
-- 
2.30.0

