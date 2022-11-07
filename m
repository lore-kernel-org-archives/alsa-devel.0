Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2055FC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:43:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA912820;
	Mon,  7 Nov 2022 17:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA912820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667839400;
	bh=3rUu6DzpfqIDvPKR78tSizRJ2ZC8d9m35CXnVDqEnOY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p0BAIhuLp0jC/uDFy1AK/fPXqeuxi7JsezVklSh/8kkRD7v8UxItGmeXzxxGxLU/w
	 wUQ5fOvcwRivnFka9rYUJ45ZiAjUJ6i9qiiqegrRz3uUfz0xmWdMC27mUI+tfoz8IX
	 lUDW8NsejT0iFA6w+KiHGkHuF47L7Jx5vtVoawFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64171F804BD;
	Mon,  7 Nov 2022 17:42:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17ADAF804D0; Mon,  7 Nov 2022 17:42:28 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 772E8F80116
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:42:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 772E8F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="S9SYsU4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667839342; x=1699375342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3rUu6DzpfqIDvPKR78tSizRJ2ZC8d9m35CXnVDqEnOY=;
 b=S9SYsU4aFNZVHoIrC7AF4l+tGAGmPr1K5WYvslaOchN/TaCe9fh4wQwy
 33LbmhElmM0dV+Ec65VhscAszVGg6Cy19WcmhBzJBmSVHFJaXyT0Ed0Q5
 RnWOAGQZt57F6UZrAifwrUvsrXNqwVi22hICMyaPsrTLK7OSoEuYqJ95w
 XInwFVKMmGXKmd/0p81ss4Er7zMXk7RnmR4knhz2zux0x3VBCFrr9nkV5
 /hfP0blQoIXKm0ykOpfigeVCCmyJjjZTHuKst3s+aSfrpHJ/3AbP4J/Ia
 BQXj/CYmY/Bm/Jhy5apeMeH7UhpWj8N4V8EcQaPP3cF56VcCJEhf3T1Q+ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="308081272"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; d="scan'208";a="308081272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 08:42:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778554119"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; d="scan'208";a="778554119"
Received: from seanabue-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.82.80])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 08:42:17 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: SOF: Intel: add d0i3 definition for MTL
Date: Mon,  7 Nov 2022 10:41:52 -0600
Message-Id: <20221107164154.21925-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107164154.21925-1-pierre-louis.bossart@linux.intel.com>
References: <20221107164154.21925-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
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

From: Rander Wang <rander.wang@intel.com>

MTL has a different offset of d0i3 compared to cavs platforms.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/mtl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index 788bf0e3ea87..0fd4e6fe09b8 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -21,6 +21,8 @@
 #define MTL_IRQ_INTEN_L_SOUNDWIRE_MASK	BIT(6)
 #define MTL_HFINTIPPTR_PTR_MASK		GENMASK(20, 0)
 
+#define MTL_HDA_VS_D0I3C		0x1D4A
+
 #define MTL_DSP2CXCAP_PRIMARY_CORE	0x178D00
 #define MTL_DSP2CXCTL_PRIMARY_CORE	0x178D04
 #define MTL_DSP2CXCTL_PRIMARY_CORE_SPA_MASK BIT(0)
-- 
2.34.1

