Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E5C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:39:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA0B207DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IPtP2QkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA0B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD76F1765;
	Tue, 18 Aug 2020 16:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD76F1765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597761570;
	bh=hagcKcLRa2aSAj26hDePR792qXZ56u6eyook9AvGge0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPtP2QkYQA6/uf+yLNCBgnoeOg/lrprq+E3Ywd+u2MyF20HXw4zXJuEhryAYF07yj
	 Z7BK91mDoeX8CrslGCa42b7UUM1ZREkOS56C7i7My5quA+rUsebtSOSalqZ0CH+dMv
	 oF5eNI1rn/Sd7KTu8nfU2nbQ9fKQVbMmqtfuOQU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D4A7F80273;
	Tue, 18 Aug 2020 16:35:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78537F802E3; Tue, 18 Aug 2020 16:35:42 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2D64F80273
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 16:35:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D64F80273
IronPort-SDR: A5j8BYJd4i8/u1ix21NWcLcCgUOiwyoWqnqwyn0qbbWwc3X9lgvF9IOaWTBNHE4fkgp9Gdcjew
 ZMwjtlqGKDCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219223509"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="219223509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:35 -0700
IronPort-SDR: bVvdkknJA7bew7unweNqBq/BQ40Wtel/+Vm/lilbQhrFnelOxHyOfDvOHewpfnWcvaerzbrdZj
 IOZP6Q6YFEpg==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="471830550"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 05/11] soundwire: bus: update multi-link definition with hw
 sync details
Date: Tue, 18 Aug 2020 10:41:14 +0800
Message-Id: <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Hardware-based synchronization is typically required when the
bus->multi_link flag is set.

On Intel platforms, when the Cadence IP is configured in 'Multi Master
Mode', the hardware synchronization is required even when a stream
only uses a single segment. The existing code only deal with hardware
synchronization when a stream uses more than one segment so to remain
backwards compatible we add a configuration threshold. For Intel cases
this threshold will be set to one, other platforms may be able to use
the SSP-based sync in those cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..9adbe4fd7980 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -827,6 +827,11 @@ struct sdw_master_ops {
  * @multi_link: Store bus property that indicates if multi links
  * are supported. This flag is populated by drivers after reading
  * appropriate firmware (ACPI/DT).
+ * @hw_sync_min_links: Number of links used by a stream above which
+ * hardware-based synchronization is required. This value is only
+ * meaningful if multi_link is set. If set to 1, hardware-based
+ * synchronization will be used even if a stream only uses a single
+ * SoundWire segment.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -850,6 +855,7 @@ struct sdw_bus {
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
 	bool multi_link;
+	int hw_sync_min_links;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.17.1

