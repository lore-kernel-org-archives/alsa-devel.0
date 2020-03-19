Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADEAC4332E
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63E220724
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jYiLZ1xJ";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYguyj0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63E220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25919167F;
	Thu, 19 Mar 2020 16:45:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25919167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584632772;
	bh=TZHq8tUcCYswe6ksti5Oay6EQUEZ8Prbzqz2afO0knM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jYiLZ1xJvtdp5KNmZCv/yiQ1JAf3kjim480rdtikeOyd1WX4l80o1767TwiGbkqAr
	 Ve7XhTDClC7b/pO8rBCa9TpN33s4xPXc34GikyvcvJQMsm3xCLfKlvWda4aGftzgM2
	 IH5UruUNc7YULETRL++cbdtucZCEDYdhYmC+BwSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E593F8028C;
	Thu, 19 Mar 2020 16:43:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC40FF8022B; Thu, 19 Mar 2020 07:16:56 +0100 (CET)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 409ACF800C0
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 07:16:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 409ACF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TYguyj0h"
Received: by mail-qt1-x841.google.com with SMTP id m33so886063qtb.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=c1jNfpwxrBlj6yDsjXhcG+OM7CZt1pDhDxHLqYhw1eY=;
 b=TYguyj0hFzP/T/LWnIDlyJz9PCFUw+LUguouhKyg7Z74QJeEp1XvDz9NY5TQIEIzcr
 YToeKPxB6RwUjyQxvDKdP9/VhF8Q7YiE8TtUdEGVWoiV8u74e9ipfiJjyIpbtHJfmyrX
 DncmEJNFpIkT4N7gRx7Fu6wfws2VtEUUvJSYLM+YPhV551u6iniW58j1/vjaxga7kZbF
 oe/UouM3/0xO3/DU/DfXV13UqM+iDn42pxezH8fD5W+59+PsCImoue4s53Y2Vnd2K8a3
 8Hnzp189C1u/cbBdHNwgMeyDxwfP8wONtH+DJ3ycebjfEOc2KybuOfHmtbBubPQw0rXR
 ylYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=c1jNfpwxrBlj6yDsjXhcG+OM7CZt1pDhDxHLqYhw1eY=;
 b=ZGT7mfUG/ZWZr/ErY56kpUZ+47dAn+0rq2SaMwAtwM29ifmIow6je8YG2CqINeSnWR
 Bpf7Ad1+HrtKqnqHWDIphCMuZCPK4bApXEGz7KnsgSrrJRHazBt+yx+EErRZ/1nnNh+S
 932/9BNdqyU8VZpi08RN4qyDxf2g4P6VMa7SLJpUGAkO/Q+ZFSmDWjcVEdmSiT+/ZL32
 qtXoa8IQfuPIJqMDIFLvSqCiIcO081Ulj3qkfEEk63XLiHnzpNNTzE6gCDErpmZxvYU5
 djv7I66gMRj2ADpx8mdzHGb1/RGOTC+LJvOOEACf8riWzWOxwbFi8raotQtFBzbYbymX
 Ovsg==
X-Gm-Message-State: ANhLgQ1aAC2eqqXMWzw10lItPfST4trF1K/dWG6+Ltjiw2Uk1eBFlSHa
 tCaZ+eQZnMtRWLXguM7o9Y/lNJ1GShGlp/lgK8g=
X-Google-Smtp-Source: ADFU+vvZBof9Nsz5tnsv+BD3UgTssGS9kZMgPcScaEyuzmFOiiyK5uW3cGKizwQJ7Zxjm57A/gW6FOoTVrbnsWNmUrw=
X-Received: by 2002:ac8:1111:: with SMTP id c17mr1317750qtj.253.1584598608864; 
 Wed, 18 Mar 2020 23:16:48 -0700 (PDT)
MIME-Version: 1.0
From: jonghwan Choi <jhbird.choi@gmail.com>
Date: Thu, 19 Mar 2020 15:16:38 +0900
Message-ID: <CAGZ6kuN_-45pmQKmBKyrT22bX+Mku5Uf2_Bcd249vTte04JMJQ@mail.gmail.com>
Subject: [PATCH]  ASoC: tas2562: Fixed incorrect amp_level setting.
To: Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 19 Mar 2020 16:43:13 +0100
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

From 9f837d75f16ab18342ac517d5b1e5259ab9b797e Mon Sep 17 00:00:00 2001

From: Jonghwan Choi <charlie.jh@kakaocorp.com>

Date: Thu, 19 Mar 2020 14:44:14 +0900

Subject: [PATCH]  ASoC: tas2562: Fixed incorrect amp_level setting.


Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>

---

 sound/soc/codecs/tas2562.c | 2 +-

 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c

index be52886a5edb..fb2233ca9103 100644

--- a/sound/soc/codecs/tas2562.c

+++ b/sound/soc/codecs/tas2562.c

@@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =

                        1, 1);


 static const struct snd_kcontrol_new tas2562_snd_controls[] = {

-       SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,

+       SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,

                       tas2562_dac_tlv),

 };


-- 

2.17.1
