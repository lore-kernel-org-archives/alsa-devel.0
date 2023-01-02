Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4FBC46467
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 20:33:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66B32A8D7;
	Mon,  2 Jan 2023 21:32:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66B32A8D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672691624;
	bh=aAfymOW/PhGFtC4itped/S1oIrcSAbEZCmbLAIqF9mc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=k0Q6wppRE4wiO6FXQNhMoPfIXSpAZ9uXI26W7jIwZ2lvOd7yx1a6hba3qJFkECCzl
	 YxXR5cRLdLHm40r9JwN7hU9YNqC1DT49h3YzEdZyOa/d6vnbtEjRT7nqKCpK6Pfj0M
	 WtULypBbhos9iEqgTyHKOQWe/TsgL3gFfLNjCHoo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57434F805AD;
	Mon,  2 Jan 2023 21:30:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DBA9F805AE; Mon,  2 Jan 2023 21:30:26 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27DC7F805AB
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 21:30:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27DC7F805AB
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ibq9Lt8T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672691425; x=1704227425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aAfymOW/PhGFtC4itped/S1oIrcSAbEZCmbLAIqF9mc=;
 b=ibq9Lt8ToDkKfxDK/cJLq88cPsOE9WZOnyTPLjgK7kdog+YqqT0GAMd7
 lpbbtYQgJh5MrvnHWhXvlo+kH+HLgKDus6HR0uQZ7Ky7vgcc5FzfHktAX
 GnZ76WEGVlFV/zne7+3kgIEWmrDpeokZ+/rRcZGIWnrDbkBch04bgC/Fg
 SMYtnF13RLE3HbIjALYKIiQwMoYb6V7LrMHPDDtZYDm5SjdTlxuKgOfg0
 GCpUpDjbptvHRtZvN+eEHNDtaWQBEVCf6bZpmfQ3y9oPLZuoiRr/7BNms
 w+EUVGSNVNlwv/y0VTgwdg3XspPYSD+3GyXAE91nlxBBxu1hVh4nz9qWB A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322772212"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="322772212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2023 12:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="686987612"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="686987612"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga001.jf.intel.com with ESMTP; 02 Jan 2023 12:30:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id C64E984; Mon,  2 Jan 2023 22:30:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ASoC: Intel: bytcht_da7213: Replace open coded
 acpi_dev_put()
Date: Mon,  2 Jan 2023 22:30:34 +0200
Message-Id: <20230102203037.16120-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Instead of calling put_device(&adev->dev) where adev is a pointer
to an ACPI device, use specific call, i.e. acpi_dev_put().

Also move it out of the conditional to make it more visible in case
some other code will be added which may use that pointer. We need
to keep a reference as long as we use the pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index a0c8f1d3f8ce..a3b0cfab17b0 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -256,9 +256,9 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		dailink[dai_index].codecs->name = codec_name;
 	}
+	acpi_dev_put(adev);
 
 	/* override platform name, if required */
 	platform_name = mach->mach_params.platform;
-- 
2.35.1

