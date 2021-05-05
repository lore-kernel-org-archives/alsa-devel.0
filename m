Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538DC43460
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:34:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664561606
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664561606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3783E16C9;
	Wed,  5 May 2021 18:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3783E16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620232442;
	bh=3LQEmK+9k9N4NRabF1WjLdp98igBJaP0SbG2CHkZw1A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQyUeVqYDcgB+kZkvMO0n8vnOeW43Rgq8yzD6D/m3n7BEYlbNHsmPCjfi4YGryEkd
	 4hlHOFMYtvYkLO/5OOFac2Lg+2NuPEhQlaaW2XA6FLaw38N9fAKonnqAH5a+TGyN1K
	 C/FEiNMwGNrHAuI3iklzx9hXiYU84jojTpmyVTZY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2581EF80430;
	Wed,  5 May 2021 18:32:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79829F8049C; Wed,  5 May 2021 18:31:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19760F80279
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:31:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19760F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CmguIrB2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 470E7613CB;
 Wed,  5 May 2021 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232311;
 bh=3LQEmK+9k9N4NRabF1WjLdp98igBJaP0SbG2CHkZw1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CmguIrB2L8/7ONEfI+6eS+XlIuC0p3Qh3w/U+ftnZupn67NWfzTo1K+cAKRRUoL7W
 YtyZ+ecmTwyxa326CWobemtMEC7SYkzW2mzkVljB22JMNhsX7GdvWGWi5Z94Y+EZh2
 WcB9iq54dvy7EX5Hai8zmyixdYqtebNfxY7vD78HyrLpk4k6jJwyNNV1SYgUXxFaGC
 jqvn8N72AT0EZT8ckexh2fMqlXFhZPYAqN35565JwtA29m/jJKRpnI4FotWzL7wwgr
 9zFQC/p9sbU40XUkh+hRY3zbhfsn7gE93nfKe50ntrHfACzPfXymNtVm/wi1NtzLql
 FdbXjxSEIIaig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 019/116] ALSA: hdsp: don't disable if not enabled
Date: Wed,  5 May 2021 12:29:47 -0400
Message-Id: <20210505163125.3460440-19-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163125.3460440-1-sashal@kernel.org>
References: <20210505163125.3460440-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Tong Zhang <ztong0001@gmail.com>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Tong Zhang <ztong0001@gmail.com>

[ Upstream commit 507cdb9adba006a7798c358456426e1aea3d9c4f ]

hdsp wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.758292] snd_hdsp 0000:00:03.0: disabling already-disabled device
[    1.758327] WARNING: CPU: 0 PID: 180 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.766985] Call Trace:
[    1.767121]  snd_hdsp_card_free+0x94/0xf0 [snd_hdsp]
[    1.767388]  release_card_device+0x4b/0x80 [snd]
[    1.767639]  device_release+0x3b/0xa0
[    1.767838]  kobject_put+0x94/0x1b0
[    1.768027]  put_device+0x13/0x20
[    1.768207]  snd_card_free+0x61/0x90 [snd]
[    1.768430]  snd_hdsp_probe+0x524/0x5e0 [snd_hdsp]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Link: https://lore.kernel.org/r/20210321153840.378226-2-ztong0001@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/rme9652/hdsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4cf879c42dc4..720297cbdf87 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5390,7 +5390,8 @@ static int snd_hdsp_free(struct hdsp *hdsp)
 	if (hdsp->port)
 		pci_release_regions(hdsp->pci);
 
-	pci_disable_device(hdsp->pci);
+	if (pci_is_enabled(hdsp->pci))
+		pci_disable_device(hdsp->pci);
 	return 0;
 }
 
-- 
2.30.2

