Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F10C83000
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E4B206D9
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YU5/Ay+/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni2iPzzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E4B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C79ED1669;
	Thu, 30 Apr 2020 16:17:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C79ED1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588256305;
	bh=/n8bR6qEQEFiWRHggcyYjAzLLFE0mHLo93NI3PBUp94=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YU5/Ay+/79JkEWIasOzCsI/hRaYZBY13LpYSsZOYAspdwUoxu96gQj7jHoNezzMvd
	 FPMuIOaaAPe2D218uOKYMWaVFf5JyF8okIu0X7Agcg3e1GcR42vQrkeYOTNGVkiIk3
	 qnIZz6EBtl97UX8lHZAu1ma6NVrWKQjotQ/cy5ho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BBBDF80479;
	Thu, 30 Apr 2020 15:54:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73913F8047A; Thu, 30 Apr 2020 15:54:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2C8AF80476
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:54:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2C8AF80476
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ni2iPzzr"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94F8C20870;
 Thu, 30 Apr 2020 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254846;
 bh=/n8bR6qEQEFiWRHggcyYjAzLLFE0mHLo93NI3PBUp94=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ni2iPzzrpZ/UJf7ECKctGB0/oUgKpdFD5AnZpcbQ1uOMHKu/hcLK/kc5tXkE1cVK7
 NeHkj+9TJkoiKwu3GF0Y/OEFkkcgXsdS/XSLH8om6/EochF8PNNAOigSaBNbtpyTON
 zjnYTDjnw7cecenV9lFeOsOSGCLSAbTHG0jWvUQ0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/27] ASoC: topology: Check return value of
 pcm_new_ver
Date: Thu, 30 Apr 2020 09:53:38 -0400
Message-Id: <20200430135402.20994-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135402.20994-1-sashal@kernel.org>
References: <20200430135402.20994-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit b3677fc3d68dd942c92de52f0bd9dd8b472a40e6 ]

Function pcm_new_ver can fail, so we should check it's return value and
handle possible error.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-6-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a215b9ad148c4..50aa45525be5a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1954,7 +1954,9 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 			_pcm = pcm;
 		} else {
 			abi_match = false;
-			pcm_new_ver(tplg, pcm, &_pcm);
+			ret = pcm_new_ver(tplg, pcm, &_pcm);
+			if (ret < 0)
+				return ret;
 		}
 
 		/* create the FE DAIs and DAI links */
-- 
2.20.1

