Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:08:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD9B64FB2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD9B64FB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBC2D176F;
	Tue,  2 Feb 2021 16:07:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBC2D176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612278499;
	bh=NOcRe0VCK/Dl7v9QBx5nOMkcdzVJUUGVG2DqpXFpPcI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfSaNMwKPv3lP8qVSWDJcm8gnkMxRqFYnyPmKvpstBnm6Ij+ZjhXUGqqTdkj9sPF/
	 fmP8/Uln9HU+41YqSWDhPh+3MUAbfB6g5U4qm/unmnkETlULN7hMxRTnIdyw2KHGJW
	 lTIUDj0ytu+ucs26dgQE9uEIbrcvv3gcFnHq5fl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23BA8F8021C;
	Tue,  2 Feb 2021 16:06:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E486F8025D; Tue,  2 Feb 2021 16:06:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 206FCF80152
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 16:06:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 206FCF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pWd7wAuX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7409664E8C;
 Tue,  2 Feb 2021 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612278389;
 bh=NOcRe0VCK/Dl7v9QBx5nOMkcdzVJUUGVG2DqpXFpPcI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pWd7wAuXzDRbV6r9586bg/orrGun/9o2Sh7sLT9533KjNApGp/zRGWveLyEr3X3r9
 964VFMLxzRNWpYdVBoVeYlCNMMI14MTdELcKXIicllU7HhFL6SFy9rXJYx1Tm4+ot/
 TVXlVJYJlx/M154nIv+KrogO/JlKwm4RtKNLEEP7vRknx8fuAXGP50iCuT1dX4MmH9
 VgLnEy4UQLtVP4U5dXm4Y21ED87lBxSEhjW+Z2sQVlOVQCQp+DjrnCFEqC0ohdPZpJ
 F85YEexEQRWKymQ4kXjVu3Rj0W+97Z2EvQ1Lh49CEmC+rG8tGW1Wty7ltwVIkPPr+K
 L1xggGAKWao3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/25] ALSA: hda: intel-dsp-config: add PCI id
 for TGL-H
Date: Tue,  2 Feb 2021 10:06:00 -0500
Message-Id: <20210202150615.1864175-10-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202150615.1864175-1-sashal@kernel.org>
References: <20210202150615.1864175-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Xiuli Pan <xiuli.pan@intel.com>,
 Bard Liao <bard.liao@intel.com>
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

From: Bard Liao <bard.liao@intel.com>

[ Upstream commit c5b5ff607d6fe5f4284acabd07066f96ecf96ac4 ]

Adding PCI id for TGL-H. Like for other TGL platforms, SOF is used if
Soundwire codecs or PCH-DMIC is detected.

Signed-off-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Xiuli Pan <xiuli.pan@intel.com>
Reviewed-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20210125083051.828205-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 1c5114dedda92..fe49e9a97f0ec 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -306,6 +306,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0xa0c8,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x43c8,
+	},
 #endif
 
 /* Elkhart Lake */
-- 
2.27.0

