Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB2CD6E4A
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:56:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FE1E6023D;
	Thu,  4 Jun 2026 08:55:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FE1E6023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780556165;
	bh=dLH2GCpqoDbl5eB5Bz6gRA357t/ts1yZOrb9xgXWsm0=;
	h=From:To:Subject:Date:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KdYsB79AWy6Er6FpnLJl7zgvDY+bCMznuLjX+CpCG/Q3hw/OFHzvtSrtOgFEw85A9
	 N2nUWzhiIR9dzHvjtynUJhvfv4VdBKxcWp24BIyHnZtXpktfaRZFICt+8xLLQjFcXM
	 Xp2cMiirfV7cY7PNJGbR23uFMb+ghwNVPpsuIpUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 352F4F805FF; Thu,  4 Jun 2026 08:55:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE850F805FF;
	Thu,  4 Jun 2026 08:55:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41D91F804CC; Thu,  4 Jun 2026 08:55:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780556120;
	b=qfo5aMzRYihrWZxU5RiiuK5Mip/WK601wPT2m2j4NRs0Cmiht9HZBdMSNKBVDbmZAKAX
	 oKt08QVWzwKgb/RfFTv9VfdCmuVki0OMk/e3X3CM4aU3JWKjLgmuXT71+XOUEbH91Yfjz
	 GyAmjJiZIBMtnSox3HaNyz3CODDldO8JmpHpFzHMKapiSivYU1N1jXZgqM4Wg9mV/Dukr
	 YlPQs6ib3EFD1NO59QXqSdCUQ1/JoJzLbmLefsXF5fU/wj2G5gW0jzBjujGGNCE4jjQoy
	 2icyUEYiNWx5Qk5uOA993Ce1tMqaxmUR4jM5/QymjGcJvX7NP4Q0TaY/z6GnPRGCTlQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780556120;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dLH2GCpqoDbl5eB5Bz6gRA357t/ts1yZOrb9xgXWsm0=;
	b=qdWc6CYUapDsnO+kBcekbTz8dn5PKm97QWlN1kOs2XyWmYPvLN3cz8n+Z6vY9fK0+fyc
	 efL1d4tddyDECiq5dtIUUWsEv3zo1GVKNS7k85AnIAC+b3SE1UnIAWOSD2FgwZGac+A/E
	 AUbOaktew/BHGw7IROqjb9gKoRUTc+/MqNE643ekMybTyKvbqMu0z46YsnoLTjxd4Z3o8
	 c0tHzCvJfP8cG+s/1RVPlxf6L0BBqTpdD8JM2iNCcWoe7Q98FG/g/azqJWl6UAVskrjQr
	 hZlQmklWIFyweXmn9mSDczMrFZG6nKdmUmNDQWCrpwqvzwaTeaf5s2h4O0ZC5uWw17g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b=FIk8CNPY;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7F390F800B0
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 08:55:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F390F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b=FIk8CNPY
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260604065512epoutp0104eec6e3fee6268270fc66f898e1ecbc~1zlnL9fpR2943929439epoutp01W
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 06:55:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260604065512epoutp0104eec6e3fee6268270fc66f898e1ecbc~1zlnL9fpR2943929439epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780556112;
	bh=4lYu4kSezMPeSMdtEsoaldMKTLJmBEXyCosNWhKJwZA=;
	h=From:To:Subject:Date:References:From;
	b=FIk8CNPYp5/e+6zY8Z3wZniRsUC7esp9gw8LVxryATELaRkbCVYvbAu19/wSh6Qd2
	 Na+VwMn1j6Tvlsc7oBZMudQM3KO8SI2MSHokT3IayUZYvCKBWHgtnC/1TLCdAgj2F6
	 Y3aqC3M0fiM8+CELooBj/caaKldNmAKfRrL2PNYU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20260604065511epcas2p4cd540c479fc1e379fbc6e6de5228dd42~1zll9amfi1044910449epcas2p40;
	Thu,  4 Jun 2026 06:55:11 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.206]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gWFgf6drkz2SSKh; Thu,  4 Jun
	2026 06:55:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20260604065510epcas2p4867ac51f94ba7385d72849b573b44976~1zlk9F2Dy1020910209epcas2p40;
	Thu,  4 Jun 2026 06:55:10 +0000 (GMT)
Received: from KORDO035882 (unknown [12.80.201.209]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260604065510epsmtip1b4cf28614b213e915db9a471d3df005a~1zlk7HL9w1871918719epsmtip1o;
	Thu,  4 Jun 2026 06:55:10 +0000 (GMT)
From: "Shinhyung Kang" <s47.kang@samsung.com>
To: "'Takashi Iwai'" <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
	<broonie@kernel.org>
Subject: [PATCH] ASoC: soc-compress: fix use-after-free in
 soc_compr_trigger_fe() during BE list traversal
Date: Thu, 4 Jun 2026 15:55:10 +0900
Message-ID: <000e01dcf3ef$15d69530$4183bf90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adzz7w3+41Q2KG3cTGy00o7x8ulhug==
Content-Language: ko
X-CMS-MailID: 20260604065510epcas2p4867ac51f94ba7385d72849b573b44976
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260604065510epcas2p4867ac51f94ba7385d72849b573b44976
References: 
 <CGME20260604065510epcas2p4867ac51f94ba7385d72849b573b44976@epcas2p4.samsung.com>
Message-ID-Hash: CFWY2XJNSRU5UIDZCTG42XYGWVFG6W3W
X-Message-ID-Hash: CFWY2XJNSRU5UIDZCTG42XYGWVFG6W3W
X-MailFrom: s47.kang@samsung.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CFWY2XJNSRU5UIDZCTG42XYGWVFG6W3W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The DPCM compress trigger path traverses the FE's BE client list in
dpcm_be_dai_trigger() without holding card->pcm_mutex, while
dpcm_be_disconnect() can concurrently remove and free entries from
that same list under pcm_mutex protection.

This causes a use-after-free when for_each_dpcm_be() advances to the
next list node after releasing a BE's stream lock between iterations,
and the snd_soc_dpcm entry has already been kfree()'d by a concurrent
dpcm_be_disconnect() call.

Crash signature observed:
 Unable to handle kernel paging request at virtual address dead0000000000e8
 Call trace:
  dpcm_be_dai_trigger+0x90/0x3f0
  soc_compr_trigger_fe+0xa8/0x144
  snd_compr_ioctl+0xc98/0x2010
  __arm64_sys_ioctl+0x164/0x784

Race condition timeline:
 Thread A (soc_compr_trigger_fe):
   snd_soc_card_mutex_lock()        <- holds card->mutex only
   dpcm_be_dai_trigger()
    for_each_dpcm_be(fe, stream, dpcm) {
	  snd_pcm_stream_lock_irqsave_nested(be_substream);
	  ...
	  snd_pcm_stream_unlock_irqrestore(be_substream);
	  /* WINDOW: next iteration reads dpcm->list_be.next */
	}

 Thread B (snd_soc_dpcm_runtime_update via DAPM):
   snd_soc_dpcm_mutex_lock()        <- holds card->pcm_mutex
   dpcm_be_disconnect()
	snd_pcm_stream_lock_irq(fe_substream);
	list_del(&dpcm->list_be);      <- removes from list
	snd_pcm_stream_unlock_irq();
	kfree(dpcm);                   <- frees the struct

The PCM trigger path (dpcm_fe_dai_trigger) is protected against this
race by checking runtime_update and deferring to trigger_pending when
a concurrent update is in progress. The compress trigger path
(soc_compr_trigger_fe) lacks this deferred-trigger mechanism, so the
only correct fix is to hold pcm_mutex for the duration of the BE list
traversal, as is done in all other compress FE operations such as
soc_compr_open_fe() and soc_compr_set_params().

Signed-off-by: Shinhyung Kang <s47.kang@samsung.com>
---
 sound/soc/soc-compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b8402802ae78..615ce7a0e8d9 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -285,6 +285,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream
*cstream, int cmd)
 		return snd_soc_component_compr_trigger(cstream, cmd);
 
 	snd_soc_card_mutex_lock(fe->card);
+	snd_soc_dpcm_mutex_lock(fe);
 
 	ret = snd_soc_dai_compr_trigger(cpu_dai, cstream, cmd);
 	if (ret < 0)
@@ -315,6 +316,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream
*cstream, int cmd)
 
 out:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	snd_soc_dpcm_mutex_unlock(fe);
 	snd_soc_card_mutex_unlock(fe->card);
 	return ret;
 }
-- 
2.21.0

