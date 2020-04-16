Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D184C2BB85
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 10:35:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDAA21973
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aEhgiCKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDAA21973
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11BC01660;
	Thu, 16 Apr 2020 12:34:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11BC01660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587033331;
	bh=yTV0HSCJPtgcrFe0J8eh/jl6vkME9u9KNZut4I1j4ac=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aEhgiCKmvAysb+tJEvSP/hgJc+iFpE9y0e9bkNkcTgYjukg7BYpLhycFCjlLgiP0U
	 YE2O2gnCZCh0vgc4YUM7l7a53nF0yJRFOGukzR65aEgrXZAE/HggfEo7Nf3L+p7rNK
	 uXbfNI3wM32q+KaOQIRkduMZJsXIVgoOgP79K3HY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1FEFF802A1;
	Thu, 16 Apr 2020 12:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23E59F8028D; Thu, 16 Apr 2020 12:31:25 +0200 (CEST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 011E8F80240
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 12:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 011E8F80240
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
 by xavier.telenet-ops.be with bizsmtp
 id TNWz2200i4dKHqf01NWzxE; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jP1nP-0001cj-Ll; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jP1nP-0003z7-JX; Thu, 16 Apr 2020 12:30:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial 0/6] Fix misspellings of "Analog Devices"
Date: Thu, 16 Apr 2020 12:30:52 +0200
Message-Id: <20200416103058.15269-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
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

	Hi all,

In several files the company also known as ADI is spelled as "Analog
Device".  However, according to https://www.analog.com/, the company
name is spelled "Analog Devices".

Hence this patch series, one per subsystem, fixes these misspellings.

Thanks for your comments!

Geert Uytterhoeven (6):
  dt-bindings: Fix misspellings of "Analog Devices"
  dma: Fix misspelling of "Analog Devices"
  drm: Fix misspellings of "Analog Devices"
  iio: Fix misspellings of "Analog Devices"
  ALSA: Fix misspellings of "Analog Devices"
  ASoC: Fix misspellings of "Analog Devices"

 .../devicetree/bindings/display/bridge/adi,adv7123.txt        | 4 ++--
 .../devicetree/bindings/display/bridge/adi,adv7511.txt        | 4 ++--
 Documentation/devicetree/bindings/dma/adi,axi-dmac.txt        | 2 +-
 Documentation/devicetree/bindings/iio/dac/ad5755.txt          | 2 +-
 drivers/dma/Kconfig                                           | 2 +-
 drivers/gpu/drm/bridge/adv7511/Kconfig                        | 2 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                           | 2 +-
 drivers/gpu/drm/tegra/fb.c                                    | 2 +-
 drivers/iio/adc/ad7791.c                                      | 2 +-
 drivers/iio/trigger/iio-trig-hrtimer.c                        | 2 +-
 drivers/staging/iio/Documentation/overview.txt                | 2 +-
 sound/isa/ad1816a/ad1816a.c                                   | 2 +-
 sound/pci/ac97/ac97_patch.c                                   | 2 +-
 sound/pci/hda/Kconfig                                         | 4 ++--
 sound/soc/codecs/ad1980.c                                     | 2 +-
 sound/soc/codecs/ad73311.c                                    | 2 +-
 sound/soc/codecs/wm8782.c                                     | 2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
