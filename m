Return-Path: <SRS0=t3YC=4K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651DC35671
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:04:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F3420702
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YblobCap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F3420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FC9B16C9;
	Sat, 22 Feb 2020 18:03:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FC9B16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582391069;
	bh=PUIxs/fLP9+v9J6+wh+M9HpT7XbmACpDS/f/6pkwRd8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YblobCapX7LY4dJo5Hkj8EB5Vyrio9Ew3axZZfc1/TQwwuK5Q8rsYmrOGd1WVUXsX
	 CYUwgpJpD44+ZHRLgs5zjmukHg4lQ5WSzYNRo1afsF33WT3pni84MARMhpIKjYQpgW
	 EyU95UmG+hE+eYqlsNIBi+XTWhPUno9+ZVm+QCn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03F30F8014C;
	Sat, 22 Feb 2020 18:02:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 121AFF8015C; Sat, 22 Feb 2020 18:02:46 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E09CFF800F3
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2020 18:02:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E09CFF800F3
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 09:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; d="scan'208";a="229476526"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2020 09:02:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1j5YAk-0004NG-Ra; Sun, 23 Feb 2020 01:02:34 +0800
Date: Sun, 23 Feb 2020 01:01:54 +0800
From: kbuild test robot <lkp@intel.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ASoC: meson: aiu: fix semicolon.cocci warnings
Message-ID: <20200222170154.GA119396@e50d7db646c3>
References: <202002230135.WpIL6nAs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002230135.WpIL6nAs%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kbuild-all@lists.01.org,
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

From: kbuild test robot <lkp@intel.com>

sound/soc/meson/aiu-encoder-i2s.c:129:2-3: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

Fixes: 3e25c44598aa ("ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families")
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7
head:   b38c4a8a0291c31a660cd77761202ebb18332fb7
commit: 3e25c44598aa44134207ad7b3c5ad6b586135777 [134/139] ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families

 aiu-encoder-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/meson/aiu-encoder-i2s.c
+++ b/sound/soc/meson/aiu-encoder-i2s.c
@@ -126,7 +126,7 @@ static int aiu_encoder_i2s_set_legacy_di
 	default:
 		dev_err(component->dev, "Unsupported i2s divider: %u\n", bs);
 		return -EINVAL;
-	};
+	}
 
 	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
 				      AIU_CLK_CTRL_I2S_DIV,
