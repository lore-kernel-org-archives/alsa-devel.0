Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A3C43465
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:23:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BF4221EC
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XkPbCTLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BF4221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6687516E6;
	Mon, 21 Sep 2020 16:22:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6687516E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600698179;
	bh=cYznO1sr9V4Qr4CRQutcWpnzk1N9PC2hkwm13mrB9JI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XkPbCTLenASPC/BHzBaaWQ0KmMuJHa5fV8lkQhfpOK4dUJd8o148Al64hFsuX3UWM
	 8RkbyCO9C1LQYlKcoYRN8nwSY/cLclCeY/I5vjCoRO1uqZKphoyKKdi97QfZ0xXTWf
	 mcj1TRa+MxQXdMa0i9tya+UOPAEwcXHmz3CpCczU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80985F802E0;
	Mon, 21 Sep 2020 16:19:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F1E0F8015F; Mon, 21 Sep 2020 16:19:41 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D378F8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 16:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D378F8015F
IronPort-SDR: fl0+MlyKRwL5oib8s+woyO8SOUW0m31HL95so5UzWBLB+Ot4ePGr5ub7IWgx+lVxfv8240WnxB
 fjZO97DFRlIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="140394088"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="140394088"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 07:19:19 -0700
IronPort-SDR: SiRsxVeD3/hSHBhPqLYLkviPvtX9NPsR6y0/CpOHSGzWh2pwkPAwn2whaJsqpjxJxXFFJQ8i3U
 s+7/jAbtHjOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="485495422"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 21 Sep 2020 07:19:18 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 3/4] ALSA: hda - handle multiple i915 device instances
Date: Mon, 21 Sep 2020 17:17:40 +0300
Message-Id: <20200921141741.2983072-4-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200921141741.2983072-1-kai.vehmanen@linux.intel.com>
References: <20200921141741.2983072-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com
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

Currently i915_component_master_match() will return the first matching
i915 instance. This does not work in case system has multiple i915
and HDA audio controller instances.

Add a new connectivity check that handles following cases:
 - i915 and HDA controller on same PCI bus
 - discrete GPU with embedded HDA audio controller connected
   via PCI bridge

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/hdac_i915.c | 44 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 3c2db3816029..50b2c1db429b 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -73,11 +73,51 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_set_bclk);
 
+/**
+ * Returns true if the devices can be connected for audio.
+ */
+static bool connectivity_check(struct pci_dev *i915, struct pci_dev *hdac)
+{
+	struct pci_bus *bus_a = i915->bus, *bus_b = hdac->bus;
+
+	/* directly connected on the same bus */
+	if (bus_a == bus_b)
+		return true;
+
+	/*
+	 * on i915 discrete GPUs with embedded HDA audio, the two
+	 * devices are connected via 2nd level PCI bridge
+	 */
+	bus_a = bus_a->parent;
+	bus_b = bus_b->parent;
+	if (!bus_a || !bus_b)
+		return false;
+	bus_a = bus_a->parent;
+	bus_b = bus_b->parent;
+	if (bus_a && bus_a == bus_b)
+		return true;
+
+	return false;
+}
+
 static int i915_component_master_match(struct device *dev, int subcomponent,
 				       void *data)
 {
-	return !strcmp(dev->driver->name, "i915") &&
-	       subcomponent == I915_COMPONENT_AUDIO;
+	struct pci_dev *hdac_pci, *i915_pci;
+	struct hdac_bus *bus = data;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	hdac_pci = to_pci_dev(bus->dev);
+	i915_pci = to_pci_dev(dev);
+
+	if (!strcmp(dev->driver->name, "i915") &&
+	    subcomponent == I915_COMPONENT_AUDIO &&
+	    connectivity_check(i915_pci, hdac_pci))
+		return 1;
+
+	return 0;
 }
 
 /* check whether intel graphics is present */
-- 
2.27.0

