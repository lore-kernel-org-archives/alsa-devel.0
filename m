Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC48C00140
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Aug 2022 14:02:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCBEE15C3;
	Wed, 24 Aug 2022 16:01:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCBEE15C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661349751;
	bh=blMIr/c0QPTHL7baowlNwM0md9br9WlyF6LQUMfF2JY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3T/yhQt0vFk8hOy73GGupJldVG0wMnMMY0yoGO4LxKXmtk1XuR6KOLEC2XTvL5lP
	 gh0vcXKWyAhmyUAggezKK1V4aeZa7i2S6Sm9mMr5SFwoL5O3WlYUlM8SlYfECSkPTp
	 83rNuk8utw8KL+szYGoz8V78rrRmiZDgSVAfslEI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C825FF80552;
	Wed, 24 Aug 2022 16:00:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61843F80552; Wed, 24 Aug 2022 16:00:23 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61AA6F8053A
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 16:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61AA6F8053A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="xMjGpR80"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 98A37B823B5;
 Wed, 24 Aug 2022 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161BC433B5;
 Wed, 24 Aug 2022 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1661349613;
 bh=blMIr/c0QPTHL7baowlNwM0md9br9WlyF6LQUMfF2JY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xMjGpR80qOIpWvAyzrJtnrkiV8qxjXzH1G1a+fRD/B8WlFzmSc9tHkYJ77hYhJCDl
 r2ZBzfP/IEp3AtLse/I7RDXNmiDcf6lmIAdZT515csl32tikORu/gPnDvS4TYLwVLy
 imLStvu8I9sDoSzD3Pc0W4pwVTUuVAd6Y1aApMaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 6/6] soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS()
 comments
Date: Wed, 24 Aug 2022 15:59:51 +0200
Message-Id: <20220824135951.3604059-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=gregkh@linuxfoundation.org; h=from:subject;
 bh=blMIr/c0QPTHL7baowlNwM0md9br9WlyF6LQUMfF2JY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDMlsetfDlRolL5XPLW//5aOwtlHogvEzFZb/z0PTRM++s917
 xay6I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbSuplhfvKVScKRDasndjCtcN52qW
 8uc9TaEob5iQ1NbNf3tvO11B2xNyjqzliisnIOAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
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

Now that we manually created our own attribute group list, the outdated
ATTRIBUTE_GROUPS() comments can be removed as they are not needed at
all.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 6.0-rc1

 drivers/soundwire/sysfs_slave.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 070e0d84be94..5b7666d27722 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -129,10 +129,6 @@ static struct attribute *slave_dev_attrs[] = {
 	NULL,
 };
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for device-level properties
- */
 static const struct attribute_group sdw_slave_dev_attr_group = {
 	.attrs	= slave_dev_attrs,
 	.name = "dev-properties",
@@ -194,10 +190,6 @@ static struct attribute *dp0_attrs[] = {
 	NULL,
 };
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for dp0-level properties
- */
 static const struct attribute_group dp0_group = {
 	.attrs = dp0_attrs,
 	.is_visible = dp0_is_visible,
-- 
2.37.2

