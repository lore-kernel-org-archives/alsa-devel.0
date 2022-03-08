Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B9C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 19:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED44A1910;
	Tue,  8 Mar 2022 20:32:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED44A1910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646768014;
	bh=RdMhIS9OX2pWkr/tA78XLygIrcEeyT8yZaulTvEZ8EE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZt0HkBxLjhl154ZlW0MxFnnVx/4e/JIMyQq7agzKSJYOrHqunQqtEiZ91MOUjvqc
	 KQXdQHCXTDCYSB1eEGk/oydBWfp4if2Nt5k2xZfDJUHejhZ+terPd7hvvkiT1sFvFd
	 akV1rrI4pVtRVVtkLF419fM+vaCvYNxOHwLgqyv8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEF86F805C0;
	Tue,  8 Mar 2022 20:27:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E32C3F80578; Tue,  8 Mar 2022 20:27:09 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED659F80516
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 20:26:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED659F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hC3l1p3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646767617; x=1678303617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RdMhIS9OX2pWkr/tA78XLygIrcEeyT8yZaulTvEZ8EE=;
 b=hC3l1p3S57F6/R373XmEGeYdtNo/2fWPIj+3CTY8zzQKJPG8c3HdV65V
 /3W+dEiB4KVHefH0ByhgR2+vNGCKUAobX5DBFfWq8oV1Nr7cloboQcPGW
 gdkN0/DQUUIXBQ/bnqW36TvpjRUy5DlqGEO80GWQy5ndGgr4hkt+EbjmU
 TiMJ0u9WXg/kkUolM6d3z1JhqUSnQ3soyUYRc597l7pNQjh4H4E8TCP7O
 m2R79ZeQc8a7vXWqSsHTgzO4bAM/Efc579Xsr2s5TSBhn/M6L2SljvZcU
 kf3y6hH6tqu/FNuOhDddG8hqUYsZxPm7XVT6JCplQbpxB/ePT4sfJjbIr g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252363768"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252363768"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="495574019"
Received: from jhaskins-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.53.149])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:53 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 20/20] ASoC: Intel: bytcht_es8316: move comment to the right
 place
Date: Tue,  8 Mar 2022 13:26:10 -0600
Message-Id: <20220308192610.392950-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
References: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Huajun Li <huajun.li@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Nikolai Kostrigin <nickel@altlinux.org>, broonie@kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Additional code was added and the comment on the speaker GPIO needs to
be moved before we actually try to get the GPIO.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index f4bf26e802a2..e18371b5a771 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -535,7 +535,6 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->mclk))
 		return dev_err_probe(dev, PTR_ERR(priv->mclk), "clk_get pmc_plt_clk_3 failed\n");
 
-	/* get speaker enable GPIO */
 	codec_dev = acpi_get_first_physical_node(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
@@ -561,6 +560,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* get speaker enable GPIO */
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
 	priv->speaker_en_gpio =
 		gpiod_get_optional(codec_dev, "speaker-enable",
-- 
2.30.2

