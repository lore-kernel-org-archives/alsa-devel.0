Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC56C4724C
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:53:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDEC21775
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mIji+rNL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1op5tT/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDEC21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 284DF168E;
	Thu, 30 Apr 2020 15:52:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 284DF168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588254812;
	bh=72QHCKyTOD6djEwTkkbPYc1VL+si3jHQnpEU95wSY6o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mIji+rNLB+FxIx5XsQLZQfzGQ9/qJ55mt8fzhHvTxmdcltw8zZ4n1DYAJALXoo/Ai
	 YdMO7xny8v7hJpD864xrgzOBxH4vTbIpbAFKffayU+Nrg3/01QH+1yw0MsVZHlpXhK
	 khaSN/jjyGDeV/xjSbR2aVgHviSZc3YX+gN8HNow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5652F8028C;
	Thu, 30 Apr 2020 15:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F038F8028C; Thu, 30 Apr 2020 15:51:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF2DFF801EB
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF2DFF801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1op5tT/6"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6471208D6;
 Thu, 30 Apr 2020 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254657;
 bh=72QHCKyTOD6djEwTkkbPYc1VL+si3jHQnpEU95wSY6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1op5tT/6NAaxqIY4COsrgC2Gi85+JEAcnh9uRr3662+lCU8kzVnZsZ6S//kNayz00
 2UmkIPfPF2c9ku1iBnKXVngjwLMB+IuqBqJCGYMIxXDXAz7BqBsQxvHswDAJSpwORG
 ksrjiwdC4CN5a2/U/uuewT6tlElo81BtH6orEWEg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 11/79] ASoC: topology: Check return value of
 pcm_new_ver
Date: Thu, 30 Apr 2020 09:49:35 -0400
Message-Id: <20200430135043.19851-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
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
index aa7714f2b78fd..ca0ac5372b293 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2135,7 +2135,9 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
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

