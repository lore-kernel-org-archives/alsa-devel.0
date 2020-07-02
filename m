Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA4EC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:25:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE296206C3
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rpzsih9v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWokDWUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE296206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E9171612;
	Thu,  9 Jul 2020 16:24:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E9171612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594304726;
	bh=gazt5/3f2MKFUCTeOuDFO0DpnJgX5dxLA8KXm3qv6tU=;
	h=Resent-From:Resent-Date:Resent-To:From:To:Date:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpzsih9vGqBp5OCHq5y6Hf9TIVA9e1jccTOB4IAYGo2tB7jEFPL7KYw6yJnajYu9Y
	 224grko6DiRxX4jRPRvOLFvlRWJKzansftkfHhsh8WIXG31k7rT15loMn9z/oY5xJp
	 ahngIxAofUwDEzsvSrwqTHPg39gdsugJL9ra4qDg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45876F802BE;
	Thu,  9 Jul 2020 16:22:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7EB2F80150; Wed,  8 Jul 2020 12:24:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3387CF800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 12:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3387CF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZWokDWUT"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF822206F6
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 10:24:40 +0000 (UTC)
Resent-From: Mark Brown <broonie@sirena.org.uk>
Resent-Date: Wed, 8 Jul 2020 11:24:36 +0100
Resent-Message-ID: <20200708102436.GE4655@sirena.org.uk>
Resent-To: alsa-devel@alsa-project.org
Envelope-to: broonie@sirena.co.uk
Delivery-date: Thu, 02 Jul 2020 03:31:22 +0100
Received: from mail.kernel.org ([198.145.29.99])
 by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92)
 (envelope-from <SRS0=U1ae=AN=gmail.com=puyou.lu@kernel.org>)
 id 1jqp0S-0001mB-H8
 for broonie@sirena.co.uk; Thu, 02 Jul 2020 03:31:22 +0100
Received: by mail.kernel.org (Postfix)
 id 404C9207F5; Thu,  2 Jul 2020 02:31:19 +0000 (UTC)
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPS id 1F32D207D4
 for <broonie@kernel.org>; Thu,  2 Jul 2020 02:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F32D207D4
Authentication-Results: mail.kernel.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org;
 spf=pass smtp.mailfrom=puyou.lu@gmail.com
Received: by mail-pj1-f67.google.com with SMTP id cm21so2444793pjb.3
 for <broonie@kernel.org>; Wed, 01 Jul 2020 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=OYf78Hvt9v41Wvb/o0d2/KRMTtLM2MKT/AkKuwhCFn8=;
 b=ZWokDWUTQDF/WgUGc2Bh2iiL1c8Uf9uEbbvhyz8NNukPrgFSPHzecIXMckZHMCvDe9
 P9emOU8VY3+4dq22oYq4uBBJBOF1mJBLoJLGsJUlnDtDsX0sAwLGcw+zLWQxpnU164uP
 UHqzQJqiRMpCk7UwdKTI9MkxyR1LfqDCZHq7JhHLC3MEfZq+t7NSf4AhC6CoVcG5/XFM
 KYPTEyLWNZh/zdaVfhtATtqkrgKHEyA3QNeAhHG5YQiWDcYm8HUbBODkxNDDPBRsuSDY
 iGgAYKnDzVll7LljTOhTKFiV/iS/ctGkpfUWEEs838ZZRunNP2mO2Gnnj0EGRgo0tRCB
 dB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OYf78Hvt9v41Wvb/o0d2/KRMTtLM2MKT/AkKuwhCFn8=;
 b=iMCLNpKvpigtLPcsoJuiXG7htwtNg1F7Ydg/E9rDh+4ti9jSJAlySKs07NWlN715cA
 Hwr9394O7IjJPiVfG17XD08DBkCPvpVjuSC3x+lW9J5QA8LBFnY33fmhNKVOAtMr2hMy
 yHpzARzdexHDENuLhokyck+U7Jypch9BeVajApBu4JQLSTzmE6Vqez4N5utdHS14d3oV
 lmuJWAAgi3UHf/IrMQt3aA5rsOeD4unHAKJ0COMSv1eTJaPKYdbsjTsHjAmVMmDgWTQ+
 yE9Az988g21yyB8vC5yqZCgjecP+az8/PDwLRgRtWT64qVICBHAELm5eNFgtqZTrdNhp
 DJ9Q==
X-Gm-Message-State: AOAM532PecEh8WxeufnKWnIJjV2oJyi1hlA9L8vEqSi4fFh/h1VmBPXA
 m60OJBYoNV3wzBLdLVYf5T+0fme5+HDGnw2+
X-Google-Smtp-Source: ABdhPJyw/5gTN22QLIYUw4jHFqu2ugCV6w5kYoxJ5zS3TasxYcLqXW/5qKQeMH2L2FMSwfiZt0MUXA==
X-Received: by 2002:a17:902:c401:: with SMTP id
 k1mr3886206plk.202.1593657078159; 
 Wed, 01 Jul 2020 19:31:18 -0700 (PDT)
Received: from localhost.localdomain ([183.14.30.148])
 by smtp.gmail.com with ESMTPSA id j13sm6299771pjz.8.2020.07.01.19.31.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 19:31:17 -0700 (PDT)
From: puyou.lu@gmail.com
To: broonie@kernel.org,
	lgirdwood@gmail.com
Date: Thu,  2 Jul 2020 10:30:56 +0800
Message-Id: <1593657056-4989-1-git-send-email-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.7.4
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=U1ae=AN=gmail.com=puyou.lu@kernel.org
Subject: [PATCH 2/2] ASoC: wm8974: remove unsupported clock mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: sT/admsb1EbW
X-Mailman-Approved-At: Thu, 09 Jul 2020 16:22:25 +0200
Cc: Puyou Lu <puyou.lu@gmail.com>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org
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

From: Puyou Lu <puyou.lu@gmail.com>

In DSP_A mode, BIT7 of IFACE should bit 0 according to datasheet (ie.
inverted frame clock is not support in this mode).

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 sound/soc/codecs/wm8974.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 764bf93..7cfc896 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -474,6 +474,10 @@ static int wm8974_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		iface |= 0x0008;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
+		if ((fmt & SND_SOC_DAIFMT_INV_MASK) == SND_SOC_DAIFMT_IB_IF ||
+		    (fmt & SND_SOC_DAIFMT_INV_MASK) == SND_SOC_DAIFMT_NB_IF) {
+			return -EINVAL;
+		}
 		iface |= 0x00018;
 		break;
 	default:
-- 
2.7.4

