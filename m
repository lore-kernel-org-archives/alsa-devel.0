Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700F0C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jun 2022 22:58:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0DC62891;
	Wed, 22 Jun 2022 00:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0DC62891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655852320;
	bh=govaHQk7YyG0eUsVlD5BABnVJzMY8uw730DimVkT0HA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nz0LdopDIincE/ron2LLe655FIymEMgwUX/bMZab4GHlvS69dkellQlDSol36M8K5
	 gyRznahrrLmC57N5yN1CRuyD1I2EkbQpx34Iv1idZLIUWq1fnS4Tl+Ze3ddUTLGPoS
	 BtQbMa/QxZ1IqBxOBWF4LzOuQVSHiDE88yjMD5cs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9DF8F804F3;
	Wed, 22 Jun 2022 00:57:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CB63F800CB; Wed, 22 Jun 2022 00:57:17 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2752EF800CB
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2022 00:57:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2752EF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="BrChb3Rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655852231; x=1687388231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=govaHQk7YyG0eUsVlD5BABnVJzMY8uw730DimVkT0HA=;
 b=BrChb3Rv94ydwL8R1gk8XmmiSOGD6+y3ItEUOiAa04LWedb6XD77dlH2
 MrLZZQ8nLZDGvugscMvNmUOEuxU/p7shF81qJaGARCw5bzzvpInfB2orc
 pScQgUJq+kJ1ifu7WraNXwXeH5m2DNDi81p8njTDzyjCMtXmQX7o6b3fF
 +lSw3nTwwXrnSrC9uLnsLvp/xWXyXahv06z+qIRTvv3aYIEUa7m30aBA8
 nrCblPhLymfvIIBTElZiv8Li6gXuyhYXaXU2iRvC9QQVOkKB0Z1Uo8IG5
 UT0GwmxTNi+yLvgJoRIZICN2tBU0NCHHhyi8+icAk8Qw/BoB9molrKCas g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263292327"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; d="scan'208";a="263292327"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 15:57:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; d="scan'208";a="914354241"
Received: from dpasupul-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.178.35])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 15:57:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] soundwire: peripheral: remove useless ops pointer
Date: Tue, 21 Jun 2022 17:56:39 -0500
Message-Id: <20220621225641.221170-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
References: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
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

Now that we are using the ops structure directly from the driver,
there are no users left of this ops pointer.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bf6f0decb3f6d..39058c841469f 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -637,7 +637,6 @@ struct sdw_slave_ops {
  * @dev: Linux device
  * @status: Status reported by the Slave
  * @bus: Bus handle
- * @ops: Slave callback ops
  * @prop: Slave properties
  * @debugfs: Slave debugfs
  * @node: node for bus list
@@ -667,7 +666,6 @@ struct sdw_slave {
 	struct device dev;
 	enum sdw_slave_status status;
 	struct sdw_bus *bus;
-	const struct sdw_slave_ops *ops;
 	struct sdw_slave_prop prop;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
-- 
2.34.1

