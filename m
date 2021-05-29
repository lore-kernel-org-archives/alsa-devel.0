Return-Path: <SRS0=AoxM=KY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC2C4708E
	for <alsa-devel@archiver.kernel.org>; Sat, 29 May 2021 03:35:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443EA6139A
	for <alsa-devel@archiver.kernel.org>; Sat, 29 May 2021 03:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443EA6139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF4771696;
	Sat, 29 May 2021 05:34:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF4771696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622259300;
	bh=O84PdIbjL/MBjt1b2NB8ltqcQGYxzkbKePZD2Q9/z8U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LkIoN76plNa5YQdzt/gD5kfDH9oonQj6W5kht5Qi3M0vYC/eHWXOWXciDgLndA8Ew
	 0RvMjQveitGvN+VNCj/9H50BmQYFNDqheniAn9pIcYTdnKDmGowLWoqNt/Ogd2E4sF
	 bTQHZmiNZHEq6ArpF9kWtvs/vRaRnkhJdPIOk5hk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76126F8014B;
	Sat, 29 May 2021 05:34:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C07F5F80169; Sat, 29 May 2021 05:34:07 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AF3DF8010A
 for <alsa-devel@alsa-project.org>; Sat, 29 May 2021 05:33:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AF3DF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="jzX57v+P"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ZoPJgbNI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 8EC545C0114;
 Fri, 28 May 2021 23:33:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 28 May 2021 23:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=w7yHsoF/k0X4v8tvFTD/kWg05b
 2sechKtYB8QtRr8k8=; b=jzX57v+Pc5cTwUtUy+5JnmcSD4hn/U+2rpSK4rIAPU
 PM4GAohM4qT5lgiE7t0eRL8hwzGv/H3/RQV/6+pL/VqUENsrm4w1Uoxjy33XG7Xr
 eXQ5jNSVsI+b0VDtdPXbJ8wisgLIzX8ebJ44tzFjNugbn7uu4kkvXceHxREHN4W2
 GyIIAqcqia8fJQkqewE+Uk9oj6jifDtxb+wBpk38cs4WvAvdvyMTfAUnt5kj1BUk
 paLsFHwLMd2wOTJSB7Eb4o5YzmMm9vYpOXfGtYBqL1IXk4YSlI5mDuNH61GPHsDZ
 NhY+ZC81+omv6tXulQO+3XKiinRw5CjyappIM/k9Mh7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=w7yHsoF/k0X4v8tvF
 TD/kWg05b2sechKtYB8QtRr8k8=; b=ZoPJgbNIMqqMR2e1qtZ76/Hz0fB8U91fz
 yySL2zCPV3iRQZ6DZfBuw+L73/2xVUKqXbkrfBBCNxfsJRvI7/sYQaP/z/ZeUqT1
 WJxalHAiT3sE5820luarIUd/dX4KiAeQHUDEesiIoC7Upm8hMW7QP5m4iABZilGf
 b+lcqg17kXOI0XWm95XTlfjzjoyryPzWNAv3/ZFHBXGm3O78Bq/JACKNvjK1h6ga
 Crnz4fMBEuN4piwdVvTteykAVSVNqKeBCwmlgJxNG2rAEafUFrHUTkXU5egB9+o6
 32ung3dA150KoQxk/9fBUeTdqHZt7fYohE8sdZwItjHigIXiXSkFw==
X-ME-Sender: <xms:I7axYApEJBseD7MOa6fXW8CwIEIEls8xd9fbuHF4qGwSfhu8UM7Fcw>
 <xme:I7axYGoQwNC0fly3W88AP8NOFUIfxfJUPRqjJe1W3vc6O6p_30BcUb9D0b_qAUfNP
 Kr5qWq0KrxSJ0FCJ_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekkedgjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecukfhppedugedrfedr
 ieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:I7axYFORnnXpxML-f9RRCGMQyrx7Iqv1iqN0O0yrRwDM3uYLZVu9XQ>
 <xmx:I7axYH7ee8LTKrCD8Lu5qURBP3g-rZmD6BG72Jyi5rBhpfK1b4n2EA>
 <xmx:I7axYP6zDrXHaFlr0AaUzkIqOVSo5Hc6ZICyRGmeLUVFVnI8gsGxPw>
 <xmx:JLaxYIUmCth3Qis50Y9bX9gQsFvZKE2LS9VipgctZp6SbfVSg7150g>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 28 May 2021 23:33:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: pcm: comment about relation between msbits hw parameter
 and [S|U32] formats
Date: Sat, 29 May 2021 12:33:53 +0900
Message-Id: <20210529033353.21641-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

Regarding to handling [U|S][32|24] PCM formats, many userspace
application developers and driver developers have confusion, since they
require them to understand justification or padding. It easily
loses consistency and soundness to operate with many type of devices. In
this commit, I attempt to solve the situation by adding comment about
relation between [S|U]32 formats and 'msbits' hardware parameter.

The formats are used for 'left-justified' sample format, and the available
bit count in most significant bit is delivered to userspace in msbits
hardware parameter (struct snd_pcm_hw_params.msbits), which is decided by
msbits constraint added by pcm drivers (snd_pcm_hw_constraint_msbits()).

In driver side, the msbits constraint includes two elements; the physical
width of format and the available width of the format in most significant
bit. The former is used to match SAMPLE_BITS of format. (For my
convenience, I ignore wildcard in the usage of the constraint.)

As a result of interaction between ALSA pcm core and ALSA pcm application,
when the format in which SAMPLE_BITS equals to physical width of the
msbits constaint, the msbits parameter is set by referring to the
available width of the constraint. When the msbits parameter is not
changed in the above process, ALSA pcm core set it alternatively with
SAMPLE_BIT of chosen format.

In userspace application side, the msbits is only available after calling
ioctl(2) with SNDRV_PCM_IOCTL_HW_PARAMS request. Even if the hardware
parameter structure includes somewhat value of SAMPLE_BITS interval
parameter as width of format, all of the width is not always available
since msbits can be less than the width.

I note that [S|U24] formats are used for 'right-justified' 24 bit sample
formats within 32 bit frame. The first byte in most significant bit
should be invalidated. Although the msbits exposed to userspace should be
zero as invalid value, actually it is 32 from physical width of format.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h         | 3 +++
 include/uapi/sound/asound.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2e1200d17d0c..b84ff6e4ee53 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -147,6 +147,9 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_S24_BE		_SNDRV_PCM_FMTBIT(S24_BE)
 #define SNDRV_PCM_FMTBIT_U24_LE		_SNDRV_PCM_FMTBIT(U24_LE)
 #define SNDRV_PCM_FMTBIT_U24_BE		_SNDRV_PCM_FMTBIT(U24_BE)
+// For S32/U32 formats, 'msbits' hardware parameter is often used to deliver information about the
+// available bit count in most significant bit. It's for the case of so-called 'left-justified' or
+// `right-padding` sample which has less width than 32 bit.
 #define SNDRV_PCM_FMTBIT_S32_LE		_SNDRV_PCM_FMTBIT(S32_LE)
 #define SNDRV_PCM_FMTBIT_S32_BE		_SNDRV_PCM_FMTBIT(S32_BE)
 #define SNDRV_PCM_FMTBIT_U32_LE		_SNDRV_PCM_FMTBIT(U32_LE)
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index d17c061950df..b43ea0067e1f 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -202,6 +202,9 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_S24_BE	((__force snd_pcm_format_t) 7) /* low three bytes */
 #define	SNDRV_PCM_FORMAT_U24_LE	((__force snd_pcm_format_t) 8) /* low three bytes */
 #define	SNDRV_PCM_FORMAT_U24_BE	((__force snd_pcm_format_t) 9) /* low three bytes */
+// For S32/U32 formats, 'msbits' hardware parameter is often used to deliver information about the
+// available bit count in most significant bit. It's for the case of so-called 'left-justified' or
+// `right-padding` sample which has less width than 32 bit.
 #define	SNDRV_PCM_FORMAT_S32_LE	((__force snd_pcm_format_t) 10)
 #define	SNDRV_PCM_FORMAT_S32_BE	((__force snd_pcm_format_t) 11)
 #define	SNDRV_PCM_FORMAT_U32_LE	((__force snd_pcm_format_t) 12)
-- 
2.27.0

