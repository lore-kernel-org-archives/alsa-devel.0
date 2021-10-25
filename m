Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D3C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEB6610EA
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEEB6610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B403016BA;
	Mon, 25 Oct 2021 19:00:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B403016BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635181291;
	bh=kbEddWIL1NYrAVEh/1ugolyuuvy2YQFqSBjvGQyrqPU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PcRiruv/yY/UqU84EqeNgJHsgIJINzVVmz8jwn3iyEWMyS96odbuODMu2j2yIR2iS
	 YORL0MlJyV6pBfshHujx5iqQ8T1+L6j/raitqTuPq76QvcYG5c7DckvifPR1zcxPF/
	 bZYM2bOyKuHPvfKSV78r1hhtVrtu+YuMlzn1OxXo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76F73F80166;
	Mon, 25 Oct 2021 18:59:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B553DF8032B; Mon, 25 Oct 2021 18:59:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4AA5F80166
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4AA5F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bf0wBVhe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88B1860F70;
 Mon, 25 Oct 2021 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635181183;
 bh=kbEddWIL1NYrAVEh/1ugolyuuvy2YQFqSBjvGQyrqPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bf0wBVheounyFy4nK+AZYdhQhF0UEXhXwPlxQMP7x+tSFB5+7YicujbuUNNncMTNZ
 VqJaMte8cOAcJWcGQVFmto0KECWvPyBChCFfwtI4hey6xIXVBRwbB34JeiKCrNb71o
 /VWg1/9L38T2OLMg2QagLBxHFIo6MbU3giFzjp0SdUhuDx86E1z/gFRW/BdHMVs034
 I/edG9xmgMD1o1EzC0hrG4aB23HKRgTVpEi5uDoS7I5dgj71y0lqpRfGb6Jj+9h+hI
 Y7pKr+Zwjb5y7iCAQRrjs/9CW/J2yjIIzAkK6Zk5UeZYpd4FP/3CzYA6cR684DEkDK
 ZIaXs9uDFQ41w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 02/18] ASoC: soc-core: fix null-ptr-deref in
 snd_soc_del_component_unlocked()
Date: Mon, 25 Oct 2021 12:59:15 -0400
Message-Id: <20211025165939.1393655-2-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025165939.1393655-1-sashal@kernel.org>
References: <20211025165939.1393655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Hulk Robot <hulkci@huawei.com>,
 Mark Brown <broonie@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit c448b7aa3e66042fc0f849d9a0fb90d1af82e948 ]

'component' is allocated in snd_soc_register_component(), but component->list
is not initalized, this may cause snd_soc_del_component_unlocked() deref null
ptr in the error handing case.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:__list_del_entry_valid+0x81/0xf0
Call Trace:
 snd_soc_del_component_unlocked+0x69/0x1b0 [snd_soc_core]
 snd_soc_add_component.cold+0x54/0x6c [snd_soc_core]
 snd_soc_register_component+0x70/0x90 [snd_soc_core]
 devm_snd_soc_register_component+0x5e/0xd0 [snd_soc_core]
 tas2552_probe+0x265/0x320 [snd_soc_tas2552]
 ? tas2552_component_probe+0x1e0/0x1e0 [snd_soc_tas2552]
 i2c_device_probe+0xa31/0xbe0

Fix by adding INIT_LIST_HEAD() to snd_soc_component_initialize().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20211009065840.3196239-1-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 583f2381cfc8..e926985bb2f8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2599,6 +2599,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dai_list);
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
+	INIT_LIST_HEAD(&component->list);
 	mutex_init(&component->io_mutex);
 
 	component->name = fmt_single_name(dev, &component->id);
-- 
2.33.0

