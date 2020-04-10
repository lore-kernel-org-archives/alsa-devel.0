Return-Path: <SRS0=EEmF=52=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE21DC2BB86
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:34:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87032192A
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vav+Fm/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87032192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0FE21679;
	Fri, 10 Apr 2020 10:24:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0FE21679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586507147;
	bh=Fsja15kQ8qzZxQlu/FM8IivR0HU4HMI8Qxtg0UbtJwQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vav+Fm/kmHTB8QrZpQxNzf6eXqF41EBdjn7aa+lY8DvbVwZa/CYYP8gZ3DOeflIWZ
	 CwJu09Ws4X10cwCNiMMq8mH6LOzEQrk2czLa+kGWzKap347tRdEI3tnzh0WfWiGoQE
	 V24n5Z5k6Zf6XSxVWgYHaC+e8XJIjZdQHXpRlk4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84744F800B9;
	Fri, 10 Apr 2020 10:24:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84B4BF80143; Fri, 10 Apr 2020 10:24:55 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97BCAF800B9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2020 10:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97BCAF800B9
IronPort-SDR: /j6x8FQr4EIGtBDx9TSZ+TUDLJ38LYYb5OLfNYjT0vmBr6GJTwvVKCYhCzIG8zdly3imx2YkrZ
 kmhUiZRR7wuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 01:24:46 -0700
IronPort-SDR: 4J82DjhtLJQl5YAb9QpZYCc1HHXmkr2XSVxtsqIJGROazogFMGxZu4IhH9LDJUmBlPg6y3PMoO
 lx3/P6QbX8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; d="scan'208";a="362390975"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2020 01:24:43 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: sst: ipc command timeout
Date: Fri, 10 Apr 2020 16:18:25 +0800
Message-Id: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Richard Fontana <rfontana@redhat.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Brent Lu <brent.lu@intel.com>,
 Allison Randal <allison@lohutok.net>
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

After sending an ipc command to DSP, the host waits for the reply message
which will be read from SST_IPCD register in sst_byt_irq_thread() to
complete the transaction. Sometimes the value read from SST_IPCD register
is still the reply message for previous command instead of the waiting
command so ipc command timeout happens.

In an experiment we read the same SST_IPCD register again when the defect
happens and found the value of second read is different from previous one
and is the correct reply message. It suggests the DSP is okay but the way
we read the register may be the cause.

Currently the driver is using memcpy_fromio() to read the value of 64-bit
registers. This function is based on __builtin_memcpy() call and depends
on the implementation of compiler. Since this issue happens right after
the toolchain switched from clang 10 to clang 11, we replace the register
read with two readl() function calls to avoid all optimization from
compiler's library.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index ec66be2..12af7aa 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -42,7 +42,7 @@ u64 sst_shim32_read64(void __iomem *addr, u32 offset)
 {
 	u64 val;
 
-	memcpy_fromio(&val, addr + offset, sizeof(val));
+	sst_memcpy_fromio_32(NULL, &val, addr + offset, sizeof(val));
 	return val;
 }
 EXPORT_SYMBOL_GPL(sst_shim32_read64);
-- 
2.7.4

