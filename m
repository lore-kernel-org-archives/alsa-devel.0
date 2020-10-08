Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E6C4363C
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:07:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5034C2083B
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fL9uKNDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5034C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineo.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B057C168B;
	Thu,  8 Oct 2020 15:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B057C168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602162429;
	bh=JlpaLOvzDt9+tdcahsRazMNyJRvQxeKZiHA5zkXI7Jg=;
	h=From:Subject:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fL9uKNDq7NBajH4Z2mDQQPUK0z7htTWi2PIvl+KuIwm9GTe2vx+GvrlZG/JHJqKPq
	 1rgfZ3tXBNTVaeSbZriNKgC9oMRdNtQJB2S3GFh6qfw8vlHQ3sjJZ0cWMjHrWXy33y
	 Uqxi8oLDgZehvXqisUaxUZ6Kr2chUnZqj5QjvtRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 450FCF80163;
	Thu,  8 Oct 2020 15:06:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EE43F80164; Thu,  8 Oct 2020 10:47:35 +0200 (CEST)
Received: from mail.lineo.co.jp (ns.lineo.co.jp [203.141.200.203])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62AC1F8015B
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2020 10:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62AC1F8015B
Received: from [172.31.78.0] (unknown [203.141.200.204])
 by mail.lineo.co.jp (Postfix) with ESMTPSA id 9872580214FF9;
 Thu,  8 Oct 2020 17:47:21 +0900 (JST)
From: Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH 0/6] spelling: Fix typo related to "arbitrary"
To: linux-kernel@vger.kernel.org
Message-ID: <4dea2b7e-31b9-a231-7fa2-9ee7ffd37686@lineo.co.jp>
Date: Thu, 8 Oct 2020 17:47:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 08 Oct 2020 15:06:18 +0200
Cc: alsa-devel@alsa-project.org, David Airlie <airlied@linux.ie>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Samuel Chessman <chessman@tux.org>, Naoki Hayama <naoki.hayama@lineo.co.jp>,
 Andy Gross <agross@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 etnaviv@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joe Perches <joe@perches.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
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

I found some typos related to "arbitrary".

s/abitrary/arbitrary/
s/arbitary/arbitrary/

This series fixes them.

These typos have been reported in the past in other codes, but
correction 'abitrary||arbitrary' wasn't added to scripts/spelling.txt.
Therefore, PATCH #6 adds it to spelling.txt.


Naoki Hayama (6):
  net: tlan: Fix typo abitrary
  dt-bindings: pinctrl: qcom: Fix typo abitrary
  dt-bindings: pinctrl: sirf: Fix typo abitrary
  ALSA: hdspm: Fix typo arbitary
  drm/etnaviv: Fix typo arbitary
  scripts/spelling.txt: Add arbitrary correction

 Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt    | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt        | 2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                           | 2 +-
 drivers/net/ethernet/ti/tlan.c                                  | 2 +-
 scripts/spelling.txt                                            | 1 +
 sound/pci/rme9652/hdspm.c                                       | 2 +-
 6 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1
