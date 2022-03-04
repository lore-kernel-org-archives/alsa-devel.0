Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F60C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Mar 2022 20:58:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 227D91E80;
	Fri,  4 Mar 2022 21:57:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 227D91E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646427521;
	bh=yXC4SlltHuE3GaaTNBXRJBpQiqCUYSxxLThJASFNFOs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwkA+P40ZFumzqDeNSSTdM1NQ4MYlU5Wi5wzi/3hnDtQg+RZEiAfA/Olo2qv9ONi7
	 8v1N1etjo5r0/se7qhwgQsuztlloFjQaoM1tqS1xZZ3t62XXctKLjc0anj2p4+1GjN
	 xsXpt4e+bdSKUVdeVKJPmWu3tAQdKr1wtoGR6sWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88DCBF80507;
	Fri,  4 Mar 2022 21:57:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32B44F801F5; Fri,  4 Mar 2022 21:57:48 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 543BCF800F2
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2022 21:57:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 543BCF800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="FVbA8COH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646427466; x=1677963466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yXC4SlltHuE3GaaTNBXRJBpQiqCUYSxxLThJASFNFOs=;
 b=FVbA8COHPO5X1IRyfTzxqxy6tlJIu0HnLmyz5w1QrbcNrkLa1tJX7ihr
 jMqg7CwdZOuIoKuGRjF4VQnpQkH0af+DUv0diZ5Y/l6gyJPJhKc8ZMO+V
 dNsrleAZxYw96pdvhSP6zz1k4MDXNfYAIqiXJQhJNrUo1S4fzegQyb6s4
 +3e2rRbxwi3DyXlGbn7GkYipqGkeW+fd3li0WTTHrkxw/7q4PW1w3zoLZ
 1rBY4tkcE5cGXOsDfYxDbgiE3WagXlK1jNRxymlnmEAd2HT1jKrQxpS2Q
 6GVT8KkdK41OD5pDbOrHPJPJxrVX/4Pnn/5m+S1d+FnbrcO6YHfioI3UX w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340492546"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; d="scan'208";a="340492546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 12:57:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; d="scan'208";a="631271275"
Received: from grmundad-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.115.48])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 12:57:41 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/10] ASoC: SOF: Intel: pci-tgl: add RPL-S support
Date: Fri,  4 Mar 2022 14:57:24 -0600
Message-Id: <20220304205733.62233-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304205733.62233-1-pierre-louis.bossart@linux.intel.com>
References: <20220304205733.62233-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Gongjun Song <gongjun.song@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Gongjun Song <gongjun.song@intel.com>

Add PCI DID for Intel Raptor Lake S.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/pci-tgl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index fd46210f1730..feaec251adc8 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -110,6 +110,8 @@ static const struct pci_device_id sof_pci_ids[] = {
 		.driver_data = (unsigned long)&ehl_desc},
 	{ PCI_DEVICE(0x8086, 0x7ad0), /* ADL-S */
 		.driver_data = (unsigned long)&adls_desc},
+	{ PCI_DEVICE(0x8086, 0x7a50), /* RPL-S */
+		.driver_data = (unsigned long)&adls_desc},
 	{ PCI_DEVICE(0x8086, 0x51c8), /* ADL-P */
 		.driver_data = (unsigned long)&adl_desc},
 	{ PCI_DEVICE(0x8086, 0x51cd), /* ADL-P */
-- 
2.30.2

