Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBA4C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 17:24:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE0651A44;
	Thu, 10 Mar 2022 18:23:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE0651A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646933081;
	bh=7q9SFFHjgpd0WCJxCU800TajoFnfeRyyNZZQtay4rec=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSoZBIq7b5kM2S1CKutOMpyejSFC+aZtqy00ZB9Hzg66BpEzUrwg3uQ/zZLVAML1a
	 6PdcH4sQiuACTwCd3jaPsZJMFJu1SlF8BCH5Gj9rWqFOx4fjqVU/XB/GayNIFzgM+l
	 CwmBbYN2/eQuI1V41YQG1SlUPrXOafnAic9A4a6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE28DF8051C;
	Thu, 10 Mar 2022 18:22:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F8A9F80518; Thu, 10 Mar 2022 18:22:56 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87E28F8015B
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 18:22:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87E28F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Jb53b4wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646932971; x=1678468971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7q9SFFHjgpd0WCJxCU800TajoFnfeRyyNZZQtay4rec=;
 b=Jb53b4woeTA7OlA7iGVYcNwHL5LG5sC6Pr/BHhB+TDqHKrAicXtMHNlu
 TAt7lhL4T79ft2+6i9TEXET32G8ib4M8iyKmfqVhI2S3GeutEAn9ptSVB
 4R1fHaoq5RuIpeRQAyDrnQwNZX4BLZbjgPn5oVXmAQHtIHenTgNEfLjxc
 uS0K0RZE6SrB74uEUAy9Tm2AJ385tPhUIETp8t2UGDqVnWHTl9FyLVaGx
 3c+TETYAISw9DzFYKtLW0dPAHpCemF2V/FeHe5VUUxJ88+W9/JtFy9a5f
 orG0ua0A24BPb/RoKjISBJw3rVT0wEN8fIJYpNCCDDL8oNQOcmUGlK6V4 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235918920"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; d="scan'208";a="235918920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 09:22:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; d="scan'208";a="554738644"
Received: from maxdorn-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.77.185])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 09:22:41 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: SOF: Intel: add topology overwrite for Taniks
Date: Thu, 10 Mar 2022 11:16:50 -0600
Message-Id: <20220310171651.249385-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310171651.249385-1-pierre-louis.bossart@linux.intel.com>
References: <20220310171651.249385-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Brent Lu <brent.lu@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Brent Lu <brent.lu@intel.com>

Taniks has four max98357a on SSP2 with Demux and EQ in topology to
implement a 2-way speaker system.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 61f2afd54c3e..4c9596742844 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -75,6 +75,14 @@ static const struct dmi_system_id sof_tplg_table[] = {
 		},
 		.driver_data = "sof-adl-max98360a-rt5682-2way.tplg",
 	},
+	{
+		.callback = sof_tplg_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-AUDIO_MAX98357_ALC5682I_I2S_2WAY"),
+		},
+		.driver_data = "sof-adl-max98357a-rt5682-2way.tplg",
+	},
 
 	{}
 };
-- 
2.30.2

