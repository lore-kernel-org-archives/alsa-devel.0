Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 01:36:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17FB20674
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 01:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gaY6LyoI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="m0axqFZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17FB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3532E1683;
	Mon, 20 Jul 2020 03:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3532E1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595208982;
	bh=6je3QWE8V9pxoPlkFkgAMFpNqQe0+G7m8vUNe1WS10Y=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gaY6LyoIkheAAQlUwdbbaT1Onps2afOofoTYOxqtcaZe1u1RQ/CdrNjTylCCx/7ln
	 iR/pKRu6p+jMBeYLFnHFnZ2iwnX/2G5KXK4jbGtGMekjOpQvklFG1bYsM4+wq+bbOM
	 9nffr86L1UWyLgmIpDX7vnEsvJQNcWlU0aswwtyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B47B9F80141;
	Mon, 20 Jul 2020 03:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C5CDF80141; Mon, 20 Jul 2020 03:26:10 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51A53F800CE
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 03:26:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51A53F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="m0axqFZG"
Received: by mail-yb1-xb49.google.com with SMTP id p22so19790629ybg.21
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=6xEFxhwqbE933+kZdll1nGcQWLb87bebM1cUcv1Qfmg=;
 b=m0axqFZGWdAOGkFiF53VZF1anhTk3fhx0t7todzZ3r67rYvoXNjwlDk7P3rqRP+feA
 s3dXCzWbLdDuF//7Gs6qALJC4OXAR41rQc9zQ7JlR73qOjy70M6zrXsny+hbTkFjH0/I
 3Go7lBeBPywZ0mbeeuiQdpbJTMEUXZIsAZjpBWOmIGsSiHXC5QC/mQW18hgZZaixvfNB
 N4GqEGwj+0wEWgIFIvp7G/5pV+latcpLBqeYF8+KSochRbnqqVrS05R2Bfgj05yGMB+T
 Y0hKyK2tGF6N1MPZtpAVgib8BYNBB1JXN6eEF8E/uibbC5843kzzi0XGAe/G7QkJKC+O
 wKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=6xEFxhwqbE933+kZdll1nGcQWLb87bebM1cUcv1Qfmg=;
 b=Uo+lRGn6lApoedPwKwanc7/ZwzaEzcGyMiJC7W6kpOKEgzEFAEB/VyRyC6gbbag41H
 EVG9ktGBXgHLuV0FNhOq00S6M7KNUU1jMFlms9BGixIC3ibmgnAcjIiiHnJw0l/kxl1T
 WrGwFRalGMs4VHUzujRBDX4x0YA4EOrf2dhkgMZTmdqPOaq8judA3SZcpG16nMiwIqLK
 LU+oJN4cwpKWr8m3W5SzuNdoCyGaaJHgdbP0kWo297hIQIDA6sVn9myXp4lWRUv/MI7M
 HuW5TuGsB5dO9vvkOvWCzyj5CO65bTksmfdDzOZn2xLRWyIPY/a07HWSC6BZoo4ftPF0
 HHvw==
X-Gm-Message-State: AOAM532EGYGvS6GEdKsZwDnbuWoSAKEslZ+Eie7/UKYZ0AdN6fnm+JVD
 aMCASDUnlWZu3bEOJQAZg/0FP+9zZMDU
X-Google-Smtp-Source: ABdhPJzbCipTqIGkmM8DOqRqTrTCRn8aP0QJ432lZL/fVi01aPhGe8ROKhwyqUiuY6c6CFjeSITIcqn01/mz
X-Received: by 2002:a5b:992:: with SMTP id c18mr61375ybq.252.1595208364790;
 Sun, 19 Jul 2020 18:26:04 -0700 (PDT)
Date: Mon, 20 Jul 2020 09:25:56 +0800
Message-Id: <20200720012559.906088-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/3] ASoC: mediatek: mt8183: support machine driver for
 max98357b
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

The series re-uses mt8183-mt6358-ts3a227-max98357.c to support machine driver
with max98357b.

The 1st patch enables left justified format from mt8183 audio platform.

The 2nd patch adds document for the new proposed compatible string for
max98357b.

The 3rd patch supports machine driver with max98357b and uses left justified
format for it.

Tzung-Bi Shih (3):
  ASoC: mediatek: mt8183: support left justified format for I2S
  ASoC: dt-bindings: mt8183: add compatible string for using max98357b
  ASoC: mediatek: mt8183: support machine driver with max98357b

 .../sound/mt8183-mt6358-ts3a227-max98357.txt  |  1 +
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c    | 59 ++++++++++++++++---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 22 ++++++-
 3 files changed, 73 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

