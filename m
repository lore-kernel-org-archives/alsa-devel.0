Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1930CA5FA7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:11:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4364602CC;
	Tue, 29 Sep 2026 21:10:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4364602CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790709061;
	bh=/P7PwiwuEP4yHQxftuoqXexct0tzJklqgwFJ2Et95kM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iIsLQur6S99vfjMTeyY75//9vPlbMN0AhUO8r2gSkoNOQLM9CHk+rbGcdrBKq25Z5
	 NrlD+u0LPa0n/7gA7w1dq1lEKEaCj286iD5eh5LAyRaQRQs2U4HxPaeUsFJ7lbmqk4
	 eUofUo2OExRvxL7gH/Vt+3PcPFaqyZygW1lQTnH4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5BDAF8961E; Tue, 29 Sep 2026 21:07:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76D5EF89630;
	Tue, 29 Sep 2026 21:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45A7CF8055C; Tue, 29 Sep 2026 08:15:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=13.75.44.102
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790662511;
	b=b3i900Cz79KMh6kDfU151Ihfz7ktQYN9agte6ZP8nLSKEvYxIIu7lrhVPjJKPMqCMChY
	 LBiiTuDlKUApi5SEvxXrsWuyU7RY5JU+uDqm0HJOW5ruqcBQa0ZelajNs4U4IH1fJI8Hb
	 BSMFVEY7Q7Go8BPCrsNBAemh9hDPZTDu27SS3qOW8h58ljnRxHDKivZWnzVlYZZx7jBFm
	 0lRzNL2H6lKvSz29+/wC5cGoGW2Ug4izx/ukdn4zuBxVJ8kzVA5UFVrcAcRzYmt+/wpUN
	 y6XTuIsCqbmSxW5DoJYw01HMmNO6YQz/ppzI0v9ynx7pwfKToF/WfVSt5fz7sjCeOEQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790662511;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/P7PwiwuEP4yHQxftuoqXexct0tzJklqgwFJ2Et95kM=;
	b=EDCRVts6Z4dlIbE1U/iMgSZt/jevjbf8xUuIgJrezHbaNRHv3JT8IbWGWFq1+IEo3V/J
	 rSNovOwAXpOmfP05LWICFDMglzsg1hKfXisrFag4isclZNyEDQSv3kvVAgV8RK5cb3SiH
	 Xhs5xAPRxUj6wTxoguqv4ej7PCRULF0qFMQHrFFVWg9ARSTiYEg0w5WaRyuPtOmMgjqiX
	 I8i7Gentgehz2WvUfjUliGMppciyikDNQegIP1l64OgXWfJg4/tbLax22N8sC+81YErE1
	 KVMBVHBFopSlAJy+3vyFo2bTkMWxzaENK+huJL8JFC2ROrxQ5XG+1jPPiXwKrsLp4UQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=13.75.44.102
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [13.75.44.102])
	by alsa1.perex.cz (Postfix) with ESMTP id 53D6DF80020
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 08:15:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53D6DF80020
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnEz1oV7tqwndFAQ--.37345S3;
	Tue, 29 Sep 2026 14:15:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgBXqoloV7tqaY4WAA--.27369S2;
	Tue, 29 Sep 2026 14:15:04 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vijendar.Mukunda@amd.com,
	Syed.SabaKareem@amd.com,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	fanwu01@zju.edu.cn
Subject: [PATCH v2] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Tue, 29 Sep 2026 06:13:49 +0000
Message-Id: <20260929061349.3879-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yy_KCgBXqoloV7tqaY4WAA--.27369S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: 
 =?B?EQBSZwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnRrXgS1QiyEChzQk8Vd3wxXCJom/K3jHdUmscrYtYM7B6UxpCitQShXrdejT8bDJEo99
	ud8K5EjMC5kJEwD3ns/N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW3AFW8ArW5KFW3ZFWkAFc_yoW7Jry5pa
	9xGFWDtrWkJr129a17Wayj9r15A3s3CFy3CrWvkw1xCw1DurZavFZ2yr15ZF95CrWkC3W2
	yFZ0ga4rWF9xtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU818BUUUUUU==
X-MailFrom: fanwu01@zju.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JNIPVWHX2BXIXDNCJV3FX6OVC3KRYFPC
X-Message-ID-Hash: JNIPVWHX2BXIXDNCJV3FX6OVC3KRYFPC
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JNIPVWHX2BXIXDNCJV3FX6OVC3KRYFPC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ACP IRQ handlers dereference the SoundWire, SoundWire DMA, and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still held by devres, which frees it only after remove
returns. An interrupt in this window is a use-after-free.

Mask the ACP interrupt sources and call devm_free_irq() before the
first child device is unregistered. The masking goes through the new
acp_hw_ops->disable_interrupts callback, keeping the remove path
platform-agnostic. The interrupt line is shared, and acp_hw_deinit()
clears the sources only after the children are gone, which would
leave the line raised with no handler left to ack it. The window
predates the tagged refactor, which only reshaped the dereferences.

devm_free_irq() waits for in-flight handlers, but not for work the
hardirq has already queued: acp63_irq_handler() schedules
amd_sdw_irq_thread on the SoundWire manager. Draining that work in
the manager's remove path is a soundwire-side change and follows
separately.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

Link to v1: https://lore.kernel.org/linux-sound/20260923092640.502145-1-fanwu01@zju.edu.cn/

- mask ACP interrupt sources via the new acp_hw_ops->disable_interrupts
  callback instead of open-coding the register writes in
  snd_acp63_remove(), as suggested by Vijendar Mukunda.

 sound/soc/amd/ps/acp63.h     | 8 ++++++++
 sound/soc/amd/ps/pci-ps.c    | 2 ++
 sound/soc/amd/ps/ps-common.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 62cb6bef1..d0cfbd4da 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -294,6 +294,7 @@ struct acp63_dev_data;
  * struct acp_hw_ops - ACP PCI driver platform specific ops
  * @acp_init: ACP initialization
  * @acp_deinit: ACP de-initialization
+ * @disable_interrupts: disable ACP interrupt sources
  * @acp_get_config: function to read the acp pin configuration
  * @acp_sdw_dma_irq_thread: ACP SoundWire DMA interrupt thread
  * acp_suspend: ACP system level suspend callback
@@ -304,6 +305,7 @@ struct acp63_dev_data;
 struct acp_hw_ops {
 	int (*acp_init)(void __iomem *acp_base, struct device *dev);
 	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
+	void (*disable_interrupts)(void __iomem *acp_base);
 	void (*acp_get_config)(struct pci_dev *pci, struct acp63_dev_data *acp_data);
 	void (*acp_sdw_dma_irq_thread)(struct acp63_dev_data *acp_data);
 	int (*acp_suspend)(struct device *dev);
@@ -397,6 +399,12 @@ static inline int acp_hw_deinit(struct acp63_dev_data *adata, struct device *dev
 	return -EOPNOTSUPP;
 }
 
+static inline void acp_hw_disable_interrupts(struct acp63_dev_data *adata)
+{
+	if (adata && adata->hw_ops && adata->hw_ops->disable_interrupts)
+		ACP_HW_OPS(adata, disable_interrupts)(adata->acp63_base);
+}
+
 static inline void acp_hw_get_config(struct pci_dev *pci, struct acp63_dev_data *adata)
 {
 	if (adata && adata->hw_ops && adata->hw_ops->acp_get_config)
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aaba..b604db494 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -738,6 +738,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	acp_hw_disable_interrupts(adata);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);
diff --git a/sound/soc/amd/ps/ps-common.c b/sound/soc/amd/ps/ps-common.c
index 7b4966b75..ea71cdf19 100644
--- a/sound/soc/amd/ps/ps-common.c
+++ b/sound/soc/amd/ps/ps-common.c
@@ -248,6 +248,7 @@ void acp63_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp63_init;
 	hw_ops->acp_deinit = acp63_deinit;
+	hw_ops->disable_interrupts = acp63_disable_interrupts;
 	hw_ops->acp_get_config = acp63_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp63_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp63_suspend;
@@ -484,6 +485,7 @@ void acp70_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp70_init;
 	hw_ops->acp_deinit = acp70_deinit;
+	hw_ops->disable_interrupts = acp70_disable_interrupts;
 	hw_ops->acp_get_config = acp70_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp70_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp70_suspend;
-- 
2.34.1

