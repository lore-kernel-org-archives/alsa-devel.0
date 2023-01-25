Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D801C54E94
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 11:48:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65BC2836;
	Wed, 25 Jan 2023 12:47:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65BC2836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674647327;
	bh=kCKMGr3qHnIDngM6PTZQQBEoIE5cOFdpKYcmOV9LIeo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=c5e4Cpa8B2igCa9mPEfRkSEzGv3I6XWbqZjV7HFkxTMFcuy6guTF8e4b1ZkjGX/ve
	 Sw6OuVSYtH7uWa2jzBmP/w5X0mv47C9VoEFhpeiFC4T/sZTESjxFCfUqPJFUHCU+pm
	 eFCH1o0N9cnrGtUj5+hSOv+c0pjQq7Im3+EWGFXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1BB1F80568;
	Wed, 25 Jan 2023 12:46:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D911CF80549; Wed, 25 Jan 2023 12:46:21 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3B84F80163
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 12:46:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3B84F80163
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GQKcRqUy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674647180; x=1706183180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kCKMGr3qHnIDngM6PTZQQBEoIE5cOFdpKYcmOV9LIeo=;
 b=GQKcRqUyr0q8XOllmyzr3A99Dsdb5Yfm/hJLpxR2BZgnP/AeWkbS5dzr
 bFTuLw9suDhXzUmfd3uWhlsDsRnjDgWkR9/XhgTkWvyT6KRmNDdb55Btd
 FNXEQDkngKhh2HP6eQgKwUxxHTVIzms3VCgx9w7TYXa0CkuxMGPzRwoSV
 qML22XrqEoIl4EJw/hQUcXGPWMJUmWz+9IeOFeZeuF1OWkcaVQJgDqedW
 a/nl5BqIl9ckSnFoMypAhp+f+x6GaFMltNGEsiRSApCgk3+CAiDGXvWs5
 gDS6ECZry1OM0ASxjd/0rowz/n01j9TZKKP5YwOtYtx5zeMrp2JbptSVH Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324234238"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="324234238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 03:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612394044"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="612394044"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 03:46:15 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 09/11] ASoC: Topology: Remove unnecessary check for EOF
Date: Wed, 25 Jan 2023 20:46:47 +0100
Message-Id: <20230125194649.3485731-10-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
References: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Caller already checks if hdr_pos is behind EOF, before calling
soc_tplg_valid_header(), so there is no need to recheck it again. This
also allows to remove behaviour of return 0 - forcing the caller to
break out of while loop.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 08dd55f94584..6689cf44464c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2389,9 +2389,6 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 static int soc_tplg_valid_header(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
-	if (soc_tplg_get_hdr_offset(tplg) >= tplg->fw->size)
-		return 0;
-
 	if (le32_to_cpu(hdr->size) != sizeof(*hdr)) {
 		dev_err(tplg->dev,
 			"ASoC: invalid header size for type %d at offset 0x%lx size 0x%zx.\n",
@@ -2442,7 +2439,7 @@ static int soc_tplg_valid_header(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	return 1;
+	return 0;
 }
 
 /* check header type and call appropriate handler */
@@ -2528,8 +2525,6 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
 				dev_err(tplg->dev,
 					"ASoC: topology: invalid header: %d\n", ret);
 				return ret;
-			} else if (ret == 0) {
-				break;
 			}
 
 			/* load the header object */
-- 
2.25.1

