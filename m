Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E404E98FD2
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:58:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F130D6020B;
	Thu,  9 Apr 2026 11:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F130D6020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775728725;
	bh=9DudH0xV9Mr2sLb6pMumqCPAGjYZueVoDg14YwdVBS8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Xfga7Fj0n+mq8reIJEX6mzuAnmEbH1kl0u4deVjBNrKFp3OtV+rV5H5hl4GIlaUTn
	 avJnY/y3lU59J589fIkkMIZQpQV5zZlvPaUNZGI9pxFYnFz7YZkoJBWOb+PoFDUgqG
	 VlIW/IvXu4tL1cSPudkOI4GNTlb7XldMxfr6klYc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 062D3F80649; Thu,  9 Apr 2026 11:57:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 500DEF8065A;
	Thu,  9 Apr 2026 11:57:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EB52F804CF; Wed,  8 Apr 2026 10:44:42 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4D7DAF8024C
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 10:44:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D7DAF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MoVzY6Nn
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-66ba9898ae8so1185888a12.1
        for <alsa-devel@alsa-project.org>;
 Wed, 08 Apr 2026 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637879; x=1776242679;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn7wQQPeIAPXSFjgjTqJdELriWK6r3kCAJfIBvkQ3a0=;
        b=MoVzY6NnxzS1B649mS4xx0JrMiVF+Apc8ly2RLM4+2YxAG/O6/DQ+dSTjdlsCiIBfP
         Tc+3ftmQKUuHR4iBliPTs5lwFUy06kH+gDsAcRfdXAkrf4ff84FnTXq3zk/Uy9FgglAG
         tLQiBs+aPKBmrRjV8HZw9o6F8slcmxYUF8UvWwbdBj+6L5guxrwY+AXuxUFFHKxk1vjL
         80z3CKSnMaj97CpfHtoYPmDt7BVPRnQUoh9r1VZ/RNnhPctg6q019OXKFImhflY4K3na
         Y0K6b2uSHXJ9Wvahxz2SHmm5F36mJsvtAtS6DqQxxBhWXK/S3KtBiBI6I2AoLSV2lssI
         SVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637879; x=1776242679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn7wQQPeIAPXSFjgjTqJdELriWK6r3kCAJfIBvkQ3a0=;
        b=kJ7bc1tsEI56AB2FjvnYWMD3IF4j9uDeHqL54vb/LDpmdlFGedOluALH0UI9WalWQh
         LtdDjTDm0tWo3Gg/hvy4QMsPnWF+Q+KX4QgI2kyjadL0i131VpDJd1XH70VKzld+1eIs
         NyQEkUxjcs2VNnFvAvi9HUstX4OegISB5pPZwmAFOPgueSfIFuilQioJgWJMWwfhy8mF
         jbLs3JEZxdiUmRSRGg+Wq9bFhoS4hyPMuYato+25axrwrARqsdgkdPPYgFhXkHLZMTzd
         tMJLHkFGabVk7aqauKQ9n2/xATRsDX2+RTxp1sn5t0QjB3+Ffp3K96D33jrGEGHz4odg
         5D/w==
X-Gm-Message-State: AOJu0YxidHrOWiP72ma7CB+Xws1kUKN9y8q5BmuicnhiNKLWjM/U03X1
	IUR3j4mTHdd32LhQnY8RTl0xLStcESp5xBvPvP3lOX4ONL/WWxHL0JK59usKPTOzkUk=
X-Gm-Gg: AeBDievaoYBeUxVsBjqWlavA1L0fanuaE0kRsr7kXHEGZKzi3fMTDtlCAublPfVkzrG
	08MBHomsGvYSeXn8RlLmCrAtHsnNGbhUI2KNG/+TbCS8qbALAtWIOP7Sy1JOqgQNOxsZtXO5izM
	nZBuldD1TzZrM7XkkIfpp+CHutl8badSPSfhC9yMWTrAjw8fpZTQQ7LElbVJOhjd5L3nlXSLaLp
	rtWVRLHxHpoVXgWifd0nAKqESKgtm5tCTjUqDrx5NnY6mXgzgKUK8nP3dpSyFBJZQFO7cwa5jIL
	6cag0jWnQ/owytHeQAgnwkMYfSwVTItGP3rxRlGtgxXWubdOydzBhcaG+55Ts6qArFNFSYeJukT
	rVrInxYtqUYtfJAXoHv/hdBqe0kLSIw/p0sFpvZxl7ZUutbIb0oWjflZIJcE2lLlVlTLSvxd9ye
	7D5WgH8LPWdcDQTftlrBtfR8z+gv2kEm+lhrxokeRDkA==
X-Received: by 2002:a17:907:971a:b0:b97:fec5:eced with SMTP id
 a640c23a62f3a-b9c46a55746mr1174761366b.0.1775637878710;
        Wed, 08 Apr 2026 01:44:38 -0700 (PDT)
Received: from tm-Precision-5570.. ([213.192.89.162])
        by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e034c9c47sm4815194a12.29.2026.04.08.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:44:37 -0700 (PDT)
From: Tomasz Merta <tommerta@gmail.com>
To: alsa-devel@alsa-project.org
Cc: olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tomasz Merta <tomasz.merta@arrow.com>,
	Tomasz Merta <tommerta@gmail.com>
Subject: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for
 DSP_A/B, LEFT_J
Date: Wed,  8 Apr 2026 10:40:56 +0200
Message-Id: <20260408084056.20588-1-tommerta@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: tommerta@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: G4QBUSY54AXMSV5DZCYIN7XPFTUW3HQ6
X-Message-ID-Hash: G4QBUSY54AXMSV5DZCYIN7XPFTUW3HQ6
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:57:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G4QBUSY54AXMSV5DZCYIN7XPFTUW3HQ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Tomasz Merta <tomasz.merta@arrow.com>

The STM32 SAI driver do not set the clock strobing bit (CKSTR) for DSP_A,
DSP_B and LEFT_J formats, causing data to be sampled on the wrong BCLK
edge when SND_SOC_DAIFMT_NB_NF is used.

Per ALSA convention, NB_NF requires sampling on the rising BCLK edge.
The STM32MP25 SAI reference manual states that CKSTR=1 is required for
signals received by the SAI to be sampled on the SCK rising edge.
Without setting CKSTR=1, the SAI samples on the falling edge, violating
the NB_NF convention. For comparison, the NXP FSL SAI driver correctly
sets FSL_SAI_CR2_BCP for DSP_A, DSP_B and LEFT_J, consistent with its
I2S handling.

This patch adds SAI_XCR1_CKSTR for DSP_A, DSP_B and LEFT_J in
stm32_sai_set_dai_fmt which was verified empirically with a cs47l35 codec.
RIGHT_J (LSB) is not investigated and addressed by this patch.

Note: the STM32 I2S driver (stm32_i2s_set_dai_fmt) may have the same issue
for DSP_A mode, as I2S_CGFR_CKPOL is not set. This has not been verified
and is left for a separate investigation.

Signed-off-by: Tomasz Merta <tommerta@gmail.com>
---
 sound/soc/stm/stm32_sai_sub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 450e1585edee..3e82fa90e719 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -802,6 +802,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	/* Left justified */
 	case SND_SOC_DAIFMT_MSB:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	/* Right justified */
@@ -809,9 +810,11 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL;
 		break;
 	default:
-- 
2.34.1

