Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE076C46467
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 20:32:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBECDA8C7;
	Mon,  2 Jan 2023 21:31:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBECDA8C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672691562;
	bh=CFo7ISntdmpoVi76v1LxoXR/BugA3bqZ0RVMplT5JSw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qhHUgyK2BCQ0LPbdIQBYq9buDpSrNF4ltgjZhSUVvqyc4Ld8BHgq9CaK7O+xaPceS
	 1csD9N+drNY307c6gwo1z1+S4G5B80YHThOfdoySgZ5ihZvbhQqaNSLHKD7S8ce9Fz
	 hKk3w0ddO8vpp57OlcYcVLyL5/6egeocV7QplpKk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 808D7F80570;
	Mon,  2 Jan 2023 21:30:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12C4DF80579; Mon,  2 Jan 2023 21:30:17 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 724FAF80571
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 21:30:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 724FAF80571
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GYIyfSYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672691415; x=1704227415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CFo7ISntdmpoVi76v1LxoXR/BugA3bqZ0RVMplT5JSw=;
 b=GYIyfSYX+g8hfm+K3sVuz9xJB8oM3Aq3DDbVq7LqLbqMrArTdWtNLfXM
 aYC9FI0SMpxed+zblMdZC9/TZ/Gr44QoanC54BbFWVr1CUhzamJQ9G4cv
 IVuRnqYz4QLeKjWYJcsEZOFg3BlY12oJNjGqadlUYYlQvc2r47PAvPawl
 tnu9UTdvQOJolH4N9d49AxKcaAQqiW5sJqYeR9XjwXXR9bAD72tRA7KVe
 rPp7iGVH0ljr+fl9cTHLHWAn1hQXGQpKfbsdTYXDTS493mUuI8K0Cxh8m
 M9Byxtr1lFv1foLyFQss7bpie4w8J1Y0ouivMQeHrZY4GZqrjMgyYqV3x w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301224156"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="301224156"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2023 12:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="796962523"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="796962523"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2023 12:30:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id E3A3219E; Mon,  2 Jan 2023 22:30:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ASoC: Intel: sof-wm8804: Replace open coded
 acpi_dev_put()
Date: Mon,  2 Jan 2023 22:30:37 +0200
Message-Id: <20230102203037.16120-5-andriy.shevchenko@linux.intel.com>
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
 sound/soc/intel/boards/sof_wm8804.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
index 54395e2ededc..fbad5a73de44 100644
--- a/sound/soc/intel/boards/sof_wm8804.c
+++ b/sound/soc/intel/boards/sof_wm8804.c
@@ -269,9 +269,9 @@ static int sof_wm8804_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name),
 			 "%s%s", "i2c-", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		dailink[dai_index].codecs->name = codec_name;
 	}
+	acpi_dev_put(adev);
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.35.1

