Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B9C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 05:35:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ABE60230
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 05:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64ABE60230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEA621737;
	Mon, 16 Aug 2021 07:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEA621737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629092156;
	bh=TY6XfTrSr7L43m8v6gBpGd6nNZY6PU5t1W9naWC1+Io=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gK8oq5zP/4IV2/6YbAxcHH7O6yGa5ya5Y0kpOSJruckSIHKdyrvInBH8dqw0tbD8v
	 EQQGbKIjp6Ljqg+o56pZyLzGdpr6BCq2dTCq1FnKPOO2jpWHVfeTtoGNXfrC2weXA5
	 RJ3Kr7THueR5A1Oz2GJIM6BXokCfrA6cjRQFUhic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A562EF80246;
	Mon, 16 Aug 2021 07:25:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8056F80249; Mon, 16 Aug 2021 07:25:08 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83746F80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 07:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83746F80134
Received: from pop-os.home ([90.126.253.178]) by mwinf5d03 with ME
 id i5R22500B3riaq2035R2Vr; Mon, 16 Aug 2021 07:25:04 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Aug 2021 07:25:04 +0200
X-ME-IP: 90.126.253.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 vkoul@kernel.org
Subject: [PATCH 0/3] ASoC: wcd9335: Firx some resources leak in the probe and
 remove function
Date: Mon, 16 Aug 2021 07:25:01 +0200
Message-Id: <cover.1629091028.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

The first 2 patches are sraightforward and look logical to me.

However, the 3rd one in purely speculative. It is based on the fact that a
comment states that we enable some irqs on some slave ports. That said, it writes
0xFF in some registers.

So, I guess that we should disable these irqs when the driver is removed. That
said, writing 0x00 at the same place looks logical to me.

This cis untested and NOT based on any documentation. Just a blind fix.
Review with care.
You'll be warned :)


Christophe JAILLET (3):
  ASoC: wcd9335: Fix a double irq free in the remove function
  ASoC: wcd9335: Fix a memory leak in the error handling path of the
    probe function
  ASoC: wcd9335: Disable irq on slave ports in the remove function

 sound/soc/codecs/wcd9335.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.30.2

