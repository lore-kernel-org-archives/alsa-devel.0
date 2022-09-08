Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FADECAAD5
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Sep 2022 09:21:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8768516DB;
	Thu,  8 Sep 2022 11:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8768516DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662628876;
	bh=v0p4c2NJuKIL3zG4BIQMyuvAOm1z6esYW61KMqchNKw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9hy52zwJlP/0mJP9ZGE6m4T+0wpPaYlsdnPpQB4F1LWBGpEzNaG3ZDUoOX+ACCOZ
	 cIFlaNaza5maGcjFE5sChNWKYe+oaJ58Xa8f3HfwLX6+zcH1/nItW5MELnJTbm81pT
	 xXkUeVtAX8yaappff2UsWCQjwK7WkfKKhzHqOxwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6746F80528;
	Thu,  8 Sep 2022 11:19:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13AB8F8011C; Thu,  8 Sep 2022 11:19:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C37B8F8016D
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2022 11:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C37B8F8016D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662628792133111000-webhooks-bot@alsa-project.org>
References: <1662628792133111000-webhooks-bot@alsa-project.org>
Subject: ucm2: Add support for MT8195 Cherry Tomato Chromebook with SOF
Message-Id: <20220908091959.13AB8F8011C@alsa1.perex.cz>
Date: Thu,  8 Sep 2022 11:19:59 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #213 was opened from kholk:

Add support for the Acer Chromebook Spin 513 CP513-2H, powered by MediaTek Kompanio 1380 (MT8195) with a HiFi 4 Audio DSP running SoundOpenFirmware.
This machine uses MT6359 PMIC, with RT1019 and RT5682 as headphones and speaker codecs/amps.

This configuration has been successfully tested on Debian 11 with PipeWire 0.3.56 + wireplumber.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/213
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/213.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
