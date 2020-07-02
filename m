Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0CC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:25:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF73120720
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X5EpXD6k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw0TvNWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF73120720
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 690281661;
	Thu,  9 Jul 2020 16:24:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 690281661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594304698;
	bh=xr9f/KPkeDlJaaznAQJH3wMwLcDfD0pus5EAoV8y7E8=;
	h=Resent-From:Resent-Date:Resent-To:From:To:Date:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X5EpXD6kJwuNaW+2OH5SYLTf5A/wDlZK5OQBWr5eDyKkGEg0x3kV631mDLkWk8nsX
	 1q9FzQo+XCyRcNXcBUZAyjdapVFA0WgrmNSu+PRLB9p/7APut186E6KxugQs2cU71b
	 DR+zkJai81L0pT9An9XDnm4kalaprwKv92ZaU6rg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 467D6F802A9;
	Thu,  9 Jul 2020 16:22:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60C3BF8015A; Wed,  8 Jul 2020 12:24:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BF4AF800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 12:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BF4AF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mw0TvNWe"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E0BE206F6
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 10:24:32 +0000 (UTC)
Resent-From: Mark Brown <broonie@sirena.org.uk>
Resent-Date: Wed, 8 Jul 2020 11:24:27 +0100
Resent-Message-ID: <20200708102427.GD4655@sirena.org.uk>
Resent-To: alsa-devel@alsa-project.org
Envelope-to: broonie@sirena.co.uk
Delivery-date: Thu, 02 Jul 2020 03:30:52 +0100
Received: from mail.kernel.org ([198.145.29.99])
 by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92)
 (envelope-from <SRS0=U1ae=AN=gmail.com=puyou.lu@kernel.org>)
 id 1jqozx-0001lj-U7
 for broonie@sirena.co.uk; Thu, 02 Jul 2020 03:30:52 +0100
Received: by mail.kernel.org (Postfix)
 id A9530207F5; Thu,  2 Jul 2020 02:30:48 +0000 (UTC)
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPS id 7D9B4207D4
 for <broonie@kernel.org>; Thu,  2 Jul 2020 02:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9B4207D4
Authentication-Results: mail.kernel.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org;
 spf=pass smtp.mailfrom=puyou.lu@gmail.com
Received: by mail-pj1-f66.google.com with SMTP id cm21so2444317pjb.3
 for <broonie@kernel.org>; Wed, 01 Jul 2020 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4XsXXEYBxxHrQytaDfCbGD9jRcEQocnFGF0UdWQqVok=;
 b=mw0TvNWeIKKT92Q9lGDYXqikWvdc17VpfHHs6O/e0CM41Xg4bhGxAGIQqJ2binvoM+
 VHDLuVrqzUdGctCB8h+bFjlxHy3j0XTaxi9inwl5R7bLXlKBkQRjJBRyPvtHXc3uEz3O
 QFgVUjzVj3+wme619MUT2EKQ/wnttXjvC71/kiIKGqpt1XvIwwTzw7cmefrdqxFyc1/u
 Ryf1AMlqdziv6dEdUN78WuMsA7phBfiePALOEFLPo3qnuYyt4WhQ0q/dxRmRpBTftf19
 L5e49qLCzhdHUGWU5TGRpM5CHZ31msbDnFf3QhZ+3+kQK1GLXztI8BUje53DlfkGeRCr
 LWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4XsXXEYBxxHrQytaDfCbGD9jRcEQocnFGF0UdWQqVok=;
 b=a+M6TEt7JD8aPkdvzPcpstdDCF8meSpNJnf0eI1mw/7+rcawQN87UlEnipUqk/j9Wf
 gyTvpRJQaBHferFKAau7CIX3JHmmqS7b8a9SfWBBZYtqM26RQuL2BwGg9qPyCj+O56IB
 JxLYpFjRyIaaPBmb0hhq1HHKM3VMdXXzaxsZB1xSJHdw7PdTyupqKu+NjEKVrthOCE3b
 DufSpd0slogzvTuXXtpkCwX24LMLeI9zBArlo4BnLJ1oGhf/Cpn1Yj9YQeDBryeHZ9/M
 +JdDsemTCN45Pm5tmOiL9wQtDd3Ji1pe8d3h99WMWvNK4KbgSL+rUNArMAbgovsWK5aC
 CQsw==
X-Gm-Message-State: AOAM5313wbQRwZW33Yx8etWaCRIQMgFtn+Ri3KRGik9nQt9c+6tpqkOm
 OR7kRDZT5uTJgT+CbRbYXAgfw4VqAgLtxA==
X-Google-Smtp-Source: ABdhPJxQVEkr5UH//Ri7y0DKd0SUtrXbUes0AD/XqEC2koxriXqi2vEjqpf3XsrQ2mFm6lxX1jE7zg==
X-Received: by 2002:a17:90a:e60b:: with SMTP id
 j11mr31646564pjy.189.1593657047838; 
 Wed, 01 Jul 2020 19:30:47 -0700 (PDT)
Received: from localhost.localdomain ([183.14.30.148])
 by smtp.gmail.com with ESMTPSA id t137sm7330632pgc.32.2020.07.01.19.30.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 19:30:47 -0700 (PDT)
From: puyou.lu@gmail.com
To: broonie@kernel.org,
	lgirdwood@gmail.com
Date: Thu,  2 Jul 2020 10:30:25 +0800
Message-Id: <1593657025-4903-1-git-send-email-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.7.4
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: SRS0=U1ae=AN=gmail.com=puyou.lu@kernel.org
Subject: [PATCH 1/2] ASoC: wm8974: fix Boost Mixer Aux Switch
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: ITp8EExr0cKZ
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

Clear BIT6 of INPPGA means not muted (Switch On).

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 sound/soc/codecs/wm8974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 06ba365..764bf93 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -186,7 +186,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8974_MONOMIX, 0, 1, 0),
 
 /* Boost mixer */
 static const struct snd_kcontrol_new wm8974_boost_mixer[] = {
-SOC_DAPM_SINGLE("Aux Switch", WM8974_INPPGA, 6, 1, 0),
+SOC_DAPM_SINGLE("Aux Switch", WM8974_INPPGA, 6, 1, 1),
 };
 
 /* Input PGA */
-- 
2.7.4

