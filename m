Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3A1C4708E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 20:33:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2728EA8D4;
	Mon,  2 Jan 2023 21:32:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2728EA8D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672691588;
	bh=JI+WQ+s6ndDirdEdZjDMNLxkK54gtzgsBmmyNW4/rLc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=QqD7GIcRZ/rgTMmogIGqBfEfK8GwHQefUE5BSpDZDMwM73xes+cXn9FgfeSx3KtOc
	 6lXLEnwt0++yE3QJbxqPcS8VVzlgPxYrakfBL5mutatAb0JeSOhvyxq2hwws1QJ9HJ
	 t5aqPp0lQG62rRbkn7FnQ14hcxxlB+m5bt1xyR9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A827DF80587;
	Mon,  2 Jan 2023 21:30:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3722F80588; Mon,  2 Jan 2023 21:30:20 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41B29F8057D
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 21:30:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41B29F8057D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i6ShNVoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672691419; x=1704227419;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JI+WQ+s6ndDirdEdZjDMNLxkK54gtzgsBmmyNW4/rLc=;
 b=i6ShNVoPfbLVhh3ycymuisBLAduZW8bnDWrqvBGc2YQjIzjn9iNBdjIq
 RLyffaYw9rV7yofNsumvQIFsgjbPDRmOcObQQE810Bcic7Prt51ZTEpND
 UvsO8KBJJwCNOmvtuW5UvalijRqNLbyJwAVC5RNkWbsRNZYlW5IuTXyXZ
 PbTmmpYbs8XQKdWR7s3cjYSG16nVeqPNdqKKQ5IBc+nZyZ+fwR3wGCo/p
 6e9xsJrBD7K85AM/OdRHvP8fVOihU8KfdgtmE8FV6gons8Pbg+0MUhKL2
 mrbcT4qPwOOLVgWhRvmJmdZcVWSrYV3ZbNAD4ZcN/wP5Mbeo5WrS9L72k g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301224172"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="301224172"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2023 12:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="796962530"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="796962530"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2023 12:30:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id B78B6F4; Mon,  2 Jan 2023 22:30:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Date: Mon,  2 Jan 2023 22:30:33 +0200
Message-Id: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
 sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 41cec67157b6..9942a2de6f7a 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -253,9 +253,9 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
 			 acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
 	}
+	acpi_dev_put(adev);
 
 	/* override platform name, if required */
 	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_cx2072x_card,
-- 
2.35.1

