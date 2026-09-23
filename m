Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641ABCA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:08:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60A97602CD;
	Tue, 29 Sep 2026 21:08:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60A97602CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708894;
	bh=SKXZvELSgzm1NgdhcAWNDInqrqia7MJiwhHAvfh/KPc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vcLMTIMkjJS8gz7JZcZfkGJmNZwifjjWgK5z5sFH+s6LD8mHn94OBNIV+xg+XP1Dd
	 y+WbamcxsxpWbuabcWc9md5CvTg1/5EDWiE/z+QTw472DLfzYcC09aDbRwBGB2q20l
	 71j8a983H208GDAnlZwrLc3HsRk0BpJnkZH95guM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9037EF80800; Tue, 29 Sep 2026 21:05:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28A18F80805;
	Tue, 29 Sep 2026 21:05:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9F76F8051F; Wed, 23 Sep 2026 11:27:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=46.101.248.176
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790155664;
	b=HWdn7yPCTzU7anFUeGGREjKYxIILJgQ7cd5k2P/81N7eAny5Pnqjhonk2qbzDFwn0z2z
	 9H0s/pfeiY4gr0QwnFZAlUlHcLiiNUuK6JYGw6N1UfhV1gW8Lq8uyczU+V+5K8SXJaZRd
	 JtzemPv4LkruCWXMqnMDWeJhh6/5T8BWAWwSpLhu3aMxizZNBkneZgzazUr0Ktu3oRh+W
	 VTFS7sjMiJr7jEBMCXsky5nGqMBwl2QRmZs7s5TU0L+459kNj+i4goupE7phn5Zhz+qpB
	 BZAGHoH/d6N1VZ5eUcTdtslBvyFFIGGzIQlJUJxhgN1ldWrUa6eYgWrevx/v03JRClQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790155664;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SKXZvELSgzm1NgdhcAWNDInqrqia7MJiwhHAvfh/KPc=;
	b=fBCgSD3tSHK/bVkXgmnkWvkZgho+dWn4UCbV5SxXcb5bqPZ1Q408KNPyvK+ShMXcIQBn
	 Q5vqyW3+GllZ/4ynCfp+dlISVVfZyfnNA5EPIB6daNglOIFiGgUgBOcw2YTz9OZHVDh7z
	 k5G7F6z+caUcLd0a+fMNq40ZJ1Ac7pQqVMagwAfIs44hSX0MiBONSisxVIMQvbeQQLOUJ
	 TkOGf9K3sr5g6lh30YcRqbI7TFxp4akagjhVui2iLp8tQc/vJXHMmYq9fQOWNVva6Ia4I
	 dgD+0FKke+6ce9YZr1mIfk+p1SAfxmH+yuDO4Mqz7YN1142lcJG6zX0DR6KT8AWIM/g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=46.101.248.176
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net
 (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AC4FF800FA
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2026 11:27:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AC4FF800FA
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3kyyHm7NqSUMxAQ--.7042S3;
	Wed, 23 Sep 2026 17:27:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgDHcHOHm7Nq7V5ZBQ--.10433S2;
	Wed, 23 Sep 2026 17:27:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vijendar.Mukunda@amd.com,
	Syed.SabaKareem@amd.com,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Wed, 23 Sep 2026 09:26:40 +0000
Message-Id: <20260923092640.502145-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zS_KCgDHcHOHm7Nq7V5ZBQ--.10433S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: 
 =?B?ee7CXQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WOJv/C88MNEzSiSpndfKYR2FTTyGypo2l/i3sVkfjsSLcEe
	bUepNW8khWwfHADVnD+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1xZrWDKFW7AryrJF13GFX_yoW8CF1Dpr
	Z8GFZxtrWkJw4jyw4UXayjvFn8CrZ3uF45C39akw1xJFn5GrWvkrWSkFy0vFZ5CrWvya12
	qrW5Ja4YkrZ8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeAp5UUUUU=
X-MailFrom: fanwu01@zju.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AM2G2FIYWFET7YAOUA6YQ55IEMYPTUN7
X-Message-ID-Hash: AM2G2FIYWFET7YAOUA6YQ55IEMYPTUN7
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:05:07 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AM2G2FIYWFET7YAOUA6YQ55IEMYPTUN7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ACP threaded interrupt handler dereferences the SoundWire and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still registered: devm_request_threaded_irq() ties its
release to devres cleanup, which runs only after the remove callback
returns. A completion in this window is a use-after-free.

Fix this by masking the ACP interrupt sources and calling devm_free_irq()
before the first child device is unregistered. The interrupt line is
shared, and acp_hw_deinit() clears the sources only after the children
are gone, which would leave the line raised with no handler left to
ack it. The window predates the tagged refactor, which only reshaped
the dereferences.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 sound/soc/amd/ps/pci-ps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aa..01ee697 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -738,6 +738,12 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	/* Mask the interrupt sources before freeing the shared IRQ. */
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
+	       adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
+	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(0, adata->acp63_base + ACP_EXTERNAL_INTR_ENB);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);

