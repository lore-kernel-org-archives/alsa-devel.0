Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF31C43460
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:46:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11C61402
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A11C61402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8244A1729;
	Wed,  5 May 2021 18:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8244A1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233198;
	bh=jGtQgUn2vNkge3mKKjDUjWarxCTlm5TBwooV62SAl/E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=crd3Iief2/VzDK8UAq+1uC/lDGTxO0RgZ07O+/Go/jA40UsF4G0orkJE8F2L0JOIH
	 n6EFURP9eFdT32HLT0Rrp3qybwnDN7eRUD/X6XD1ZaB7r2t6TsURqMIGPK2eGx3bR0
	 8vKZp/9KtMKkGtroJuefpoFfceLZGfUO6ZE7FhKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D1FF80588;
	Wed,  5 May 2021 18:37:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6DE7F80570; Wed,  5 May 2021 18:37:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65D39F80268
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65D39F80268
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WYXkOqcs"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 240D261955;
 Wed,  5 May 2021 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232631;
 bh=jGtQgUn2vNkge3mKKjDUjWarxCTlm5TBwooV62SAl/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WYXkOqcsr91tGq16UMQ6HQmWe+bXKA2k0T8zhP7qnanIwc6p6JT8XemuJJqvlyBIE
 nJgRaM10iwQGFiBx4GOd6YNqb60gzH+at4/PvQp07D0RG0qy8Y9mGr7a3VXDfETFHF
 RYFYmNKT20lJiifrqqaYsIpp/8ZvZhtN7lQqjb6JViJ/OQ0BRGln4GDXej079fLPUs
 3ym8RdfLIgpZlvBqZj8WoHhsoa2rvqfoOH0pV5lDbHalnwLa3t3ciFrc6YopuwOJ3Q
 +Y0hI+JwihCKzoYPYLgKd9QBQTD2ct7lqKTvrdesW8/pEnTP1cTM+qXPDyCpvVoL7v
 8Ib7F2PGtmUgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/85] ALSA: rme9652: don't disable if not enabled
Date: Wed,  5 May 2021 12:35:39 -0400
Message-Id: <20210505163648.3462507-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
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

[ Upstream commit f57a741874bb6995089020e97a1dcdf9b165dcbe ]

rme9652 wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.751595] snd_rme9652 0000:00:03.0: disabling already-disabled device
[    1.751605] WARNING: CPU: 0 PID: 174 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.759968] Call Trace:
[    1.760145]  snd_rme9652_card_free+0x76/0xa0 [snd_rme9652]
[    1.760434]  release_card_device+0x4b/0x80 [snd]
[    1.760679]  device_release+0x3b/0xa0
[    1.760874]  kobject_put+0x94/0x1b0
[    1.761059]  put_device+0x13/0x20
[    1.761235]  snd_card_free+0x61/0x90 [snd]
[    1.761454]  snd_rme9652_probe+0x3be/0x700 [snd_rme9652]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Link: https://lore.kernel.org/r/20210321153840.378226-4-ztong0001@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/rme9652/rme9652.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 7ab10028d9fa..8def24673f35 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1740,7 +1740,8 @@ static int snd_rme9652_free(struct snd_rme9652 *rme9652)
 	if (rme9652->port)
 		pci_release_regions(rme9652->pci);
 
-	pci_disable_device(rme9652->pci);
+	if (pci_is_enabled(rme9652->pci))
+		pci_disable_device(rme9652->pci);
 	return 0;
 }
 
-- 
2.30.2

