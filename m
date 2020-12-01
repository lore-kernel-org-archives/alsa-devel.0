Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B6DC433FE
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:05:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D021F22DBF
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021F22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABA1818E1;
	Sat,  5 Dec 2020 09:04:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABA1818E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607155545;
	bh=8Mwmyg9MYFVAIzPRG0Kg3z1bONGvIvMTCc7BXhkFPrs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dhZEY9HYz2VPsPz0xOyimCK/qiGlTX8pYrGAr/PdWZcJXp7nj5lYC4pZIx+OYb3IV
	 c19bpXuGBskjg2ANOQa+eKfdpqtq9EfxU0F5f0glhEYtxP6mnHsUY3pDD2SfCX2ERT
	 NPzRZe11id3cry7NP85bdwgDH6G0i3m16IFTtfV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A787F804C2;
	Sat,  5 Dec 2020 09:03:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD634F80277; Tue,  1 Dec 2020 10:07:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1561CF8016D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 10:06:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1561CF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="dqZAoVH2"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62FD2206CA;
 Tue,  1 Dec 2020 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606813617;
 bh=8Mwmyg9MYFVAIzPRG0Kg3z1bONGvIvMTCc7BXhkFPrs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dqZAoVH28m3QyhWttiu7/i4X001JIbx0j2UrnOpf/S56S1exMTnx1+W/Sn7oN1FVO
 e69uXXtGgMb0cNnRXA2yQYqvIeqGgQHYN1bB77jp0JBnCBM3moWJVYDh2s2n35UtbS
 RTg7FagP7SD6AwPco0TZRfuPkRQucA8dTb/XXbxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.4 93/98] ASoC: Intel: Skylake: Enable codec wakeup during
 chip init
Date: Tue,  1 Dec 2020 09:54:10 +0100
Message-Id: <20201201084659.624758613@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201084652.827177826@linuxfoundation.org>
References: <20201201084652.827177826@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Dec 2020 09:03:15 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org
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

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit e603f11d5df8997d104ab405ff27640b90baffaa upstream.

Follow the recommendation set by hda_intel.c and enable HDMI/DP codec
wakeup during bus initialization procedure. Disable wakeup once init
completes.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -129,6 +129,7 @@ static int skl_init_chip(struct hdac_bus
 	struct hdac_ext_link *hlink;
 	int ret;
 
+	snd_hdac_set_codec_wakeup(bus, true);
 	skl_enable_miscbdcge(bus->dev, false);
 	ret = snd_hdac_bus_init_chip(bus, full_reset);
 
@@ -137,6 +138,7 @@ static int skl_init_chip(struct hdac_bus
 		writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	skl_enable_miscbdcge(bus->dev, true);
+	snd_hdac_set_codec_wakeup(bus, false);
 
 	return ret;
 }


