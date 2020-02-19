Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E9AC34047
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:39:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E882464E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n2KhcV+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XzeUQSD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E882464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AA151670;
	Wed, 19 Feb 2020 10:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AA151670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582105183;
	bh=VLmwpV5tpkvlHE6Sw+cauFthmC2AW802ltloeLddhGE=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n2KhcV+FxPaiODvg4I/3Zx7K1gPpKxtRRs07D/7CNJo+0BSNt6FAlZvyxu0VUTnFT
	 7IBxjEzw5z2xf1b1IoLzrwrsSlgdZXJKJO17I3EUcX0lzoFA1YxSYSXa3CaLcu6iad
	 D45PEUsX4fEw3EJ7fNUy2mTJGmIaz+E7HzrsO0AE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8D34F8015E;
	Wed, 19 Feb 2020 10:38:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8004FF80172; Wed, 19 Feb 2020 10:38:50 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 370CBF80114
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 10:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 370CBF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="XzeUQSD9"
Received: by mail-pl1-x64a.google.com with SMTP id d20so11806328pls.15
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=89YIg0h2ZkhbFzJoBn22XaYKclfRvptQY13fnAt8VIY=;
 b=XzeUQSD9NuDGXC9zl85pKCOYwHpWghWSXSeReSrHwcTJ0al5Uzt7RAifLM3G8DpVla
 CbJ7X6lwbegFw4wIyNvk2fCLHtyCXwOWAAEKS5yFTyth4oQ4K86BVSE49ZPzt+hWyxJQ
 RCuWGCPumMKh2Y5YT+2BEA7ZUudYjGJhwIwvHohskQOmhHmOxmPdPfjAy0ysA5ZnKZRM
 JXD83RdOBT/fKjy/gjIPLeZ9zxiJE+5aBsZ9NkSOO53wCjzv/JIzTI/w5PLkuXapf/zv
 jvWVrgxkaGQSI9DvnaivgAxW0u9/3GaGnKjEgMBKGoLS/S8kAP6/2PDvRKyPCLwr4ZGK
 MABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=89YIg0h2ZkhbFzJoBn22XaYKclfRvptQY13fnAt8VIY=;
 b=iQnjGgCEaOIcL38qnf/51RWBbrI/CSMZsxV2IU/f+2a3sepoEniArieHJZ/7o0Fd4F
 LMuHel0tXv05P46UB4xyE8A79FbInCAOubuUVytbvXXcgiKPsjooYzTPFmDLsKctiSdS
 8jSLjzpfUEAgiuFi3NyvwT0ldq6zKvWFk0oVhj0OVWT2S0X9MCueG3ybiR+Cn8kKBjgb
 DVzbF1sIl+GfF0Y6vB28yTR76MDLHn4d4pGRy8MqiAtDg8rr7OjZw6s1XxSXV2SRB4zt
 3cMO3Rs6yxO40Ier4r8Qkq2wjBLppcj4aMNwBOVW1lnYmvE2JhJWsy+5Cbdlb0EpqTFS
 80og==
X-Gm-Message-State: APjAAAXm9j1ZRD4ArICvnPldBVl540Qo+dFmhldrdNKLXQfk3QdEjVuu
 t3xwTwc2dxJfHXNvM6nPIdZYIQvDGn7F
X-Google-Smtp-Source: APXvYqz8NcglE9PVo77P6bbUAIyLmIzJ/IbeYxKCjrYdLSIug+yTVnKBpNnwnijnW8ug6Q4zygXjIuZ5Qp0c
X-Received: by 2002:a63:aa07:: with SMTP id e7mr27182669pgf.90.1582105124718; 
 Wed, 19 Feb 2020 01:38:44 -0800 (PST)
Date: Wed, 19 Feb 2020 17:38:37 +0800
Message-Id: <20200219093839.6212-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [RFC PATCH 0/2] ASoC: mediatek: mt8183-da7219: use
 SND_SOC_DAPM_PINCTRL
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com, jiaxin.yu@mediatek.com
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

In previous discussion[1], Mark thinks we should have something general
pinctrl integration with DAPM.  SND_SOC_DAPM_PINCTRL is exactly what we
want but I failed to find existing usage (maybe in topology files?).

To be equivalent to mt8183-da7219's original implementation, the 1st
patch selects sleep-state at the beginning.  The 2nd patch attaches the
DAPM widget to playback stream.  When the stream is about to start, the
power on sequence selects the active-state.  When the stream is about
to stop, the power off sequence selects the sleep-state.

Note: the DAI links will connect to hdmi-codec, that's why the playback
      stream name is "I2S Playback".
Note: this is a RFC series.  If it makes sense, will also apply to
      mt8183-mt6358.

[1]: https://patchwork.kernel.org/patch/11379735/

Tzung-Bi Shih (2):
  ASoC: dapm: select sleep_state when initializing PINCTRL widget
  ASoC: mediatek: mt8183-da7219: use SND_SOC_DAPM_PINCTRL in TDM out

 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 98 ++-----------------
 sound/soc/soc-dapm.c                          |  3 +
 2 files changed, 13 insertions(+), 88 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

