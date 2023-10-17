Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39EDCDB474
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Oct 2023 16:13:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15A33A4A;
	Tue, 17 Oct 2023 18:12:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15A33A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697559195;
	bh=01fBf8qyJKNXqBVJNmGz++dnHQ6+XueViQQp7+FRMJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WmltE9/yUqM4CF3nJxclTfoHRV0jbxGUj4TTkFM8EE3vbCyH2rNhzY6njKbqTd1Mh
	 bfCaB+z4WYaYYybbIKrAHl4YOnXxk15yypngaS1IwJFUyZzUib+34OBmf6qfxWewLh
	 oNYjxW6zngUFfDgqMBY4yv0UXuPQ7V3twZq6eq+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1636EF8024E; Tue, 17 Oct 2023 18:11:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42243F80536;
	Tue, 17 Oct 2023 18:11:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BB50F8055C; Tue, 17 Oct 2023 18:11:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1853AF80236
	for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2023 18:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1853AF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AkpZbODz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559086; x=1729095086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01fBf8qyJKNXqBVJNmGz++dnHQ6+XueViQQp7+FRMJw=;
  b=AkpZbODz8RaaVcfmCOIGiWdmbcpn2uco97Sw29LClfG42AmY49jYcX0I
   l0PONROLkEoAuV+HU0JkP4sUcNce/sUQ1Cru+z4NTg2C/slmXqD8N1j/K
   nFyx5B9oxFoUjTNxNDyFQ9w85WvZvF/Hbd438XATlUrmgpo0EMP3rNsTz
   trBiVIHo/EHhqySnrZgDauRMXBTRHiyHTUnklJQX+0vziX/Ui6zwzHUfn
   PEDy/33OyuKEyeK9XAGPJuBPp9XDzvfcnu9OoUQg0UnjVg5LvNVUIKDuY
   bp0IGn5gjW4QzisXLIu+jw7T+NIty7YUxjbvmdCkfdgH+XPdCAtRja1rs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365167506"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200";
   d="scan'208";a="365167506"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 09:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759865020"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200";
   d="scan'208";a="759865020"
Received: from asprado-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.55.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 09:09:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	gregkh@linuxfoundation.org,
	Bard liao <yung-chuan.liao@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [RFC PATCH 1/2] soundwire: bus: introduce controller_id
Date: Tue, 17 Oct 2023 11:09:32 -0500
Message-Id: <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: W4HNFV6WIZJPHMOCKMTSBG47ELQJZOVP
X-Message-ID-Hash: W4HNFV6WIZJPHMOCKMTSBG47ELQJZOVP
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W4HNFV6WIZJPHMOCKMTSBG47ELQJZOVP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The existing SoundWire support misses a clear Controller/Manager
hiearchical definition to deal with all variants across SOC vendors.

a) Intel platforms have one controller with 4 or more Managers.
b) AMD platforms have two controllers with one Manager each, but due
to BIOS issues use two different link_id values within the scope of a
single controller.
c) QCOM platforms have one or more controller with one Manager each.

This patch adds a 'controller_id' which can be set by higher
levels. If assigned to -1, the controller_id will be set to the
system-unique IDA-assigned bus->id.

The main change is that the bus->id is no longer used for any device
name, which makes the definition completely predictable and not
dependent on any enumeration order. The bus->id is only used to insert
the Managers in the stream rt context.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/amd_manager.c     | 8 ++++++++
 drivers/soundwire/bus.c             | 4 ++++
 drivers/soundwire/debugfs.c         | 2 +-
 drivers/soundwire/intel_auxdevice.c | 3 +++
 drivers/soundwire/master.c          | 2 +-
 drivers/soundwire/qcom.c            | 3 +++
 include/linux/soundwire/sdw.h       | 4 +++-
 7 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 3a99f6dcdfaf..a3b1f4e6f0f9 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -927,6 +927,14 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	amd_manager->bus.clk_stop_timeout = 200;
 	amd_manager->bus.link_id = amd_manager->instance;
 
+	/*
+	 * Due to BIOS compatibility, the two links are exposed within
+	 * the scope of a single controller. If this changes, the
+	 * controller_id will have to be updated with drv_data
+	 * information.
+	 */
+	amd_manager->bus.controller_id = 0;
+
 	switch (amd_manager->instance) {
 	case ACP_SDW0:
 		amd_manager->num_dout_ports = AMD_SDW0_MAX_TX_PORTS;
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a3..025d3df32bd0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -22,6 +22,10 @@ static int sdw_get_id(struct sdw_bus *bus)
 		return rc;
 
 	bus->id = rc;
+
+	if (bus->controller_id == -1)
+		bus->controller_id = rc;
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index d1553cb77187..67abd7e52f09 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -20,7 +20,7 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
 		return;
 
 	/* create the debugfs master-N */
-	snprintf(name, sizeof(name), "master-%d-%d", bus->id, bus->link_id);
+	snprintf(name, sizeof(name), "master-%d-%d", bus->controller_id, bus->link_id);
 	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
 }
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 7f15e3549e53..93698532deac 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -234,6 +234,9 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->instance = sdw->instance;
 	cdns->msg_count = 0;
 
+	/* single controller for all SoundWire links */
+	bus->controller_id = 0;
+
 	bus->link_id = auxdev->id;
 	bus->clk_stop_timeout = 1;
 
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 9b05c9e25ebe..51abedbbaa66 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -145,7 +145,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	md->dev.fwnode = fwnode;
 	md->dev.dma_mask = parent->dma_mask;
 
-	dev_set_name(&md->dev, "sdw-master-%d", bus->id);
+	dev_set_name(&md->dev, "sdw-master-%d-%d", bus->controller_id, bus->link_id);
 
 	ret = device_register(&md->dev);
 	if (ret) {
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 55be9f4b8d59..e3ae4e4e07ac 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1612,6 +1612,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* FIXME: is there a DT-defined value to use ? */
+	ctrl->bus.controller_id = -1;
+
 	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4f3d14bb1538..c383579a008b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -886,7 +886,8 @@ struct sdw_master_ops {
  * struct sdw_bus - SoundWire bus
  * @dev: Shortcut to &bus->md->dev to avoid changing the entire code.
  * @md: Master device
- * @link_id: Link id number, can be 0 to N, unique for each Master
+ * @controller_id: system-unique controller ID. If set to -1, the bus @id will be used.
+ * @link_id: Link id number, can be 0 to N, unique for each Controller
  * @id: bus system-wide unique id
  * @slaves: list of Slaves on this bus
  * @assigned: Bitmap for Slave device numbers.
@@ -918,6 +919,7 @@ struct sdw_master_ops {
 struct sdw_bus {
 	struct device *dev;
 	struct sdw_master_device *md;
+	int controller_id;
 	unsigned int link_id;
 	int id;
 	struct list_head slaves;
-- 
2.39.2

