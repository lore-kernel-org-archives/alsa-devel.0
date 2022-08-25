Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51310C28D13
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 14:23:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D083E0E;
	Thu, 25 Aug 2022 16:22:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D083E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661437419;
	bh=0ZNdpS2JdKU3yzUJRNuglsQTmPQkBW22xM5304TdKpA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sMttjIx/GXK1ss+cSvoTLb/HGlMabDTlrYva1gMBGw00opGdnEzSUuZpk346n9Q6L
	 yj9Lqqf7SUob1GUlQfGJY1k0I8lgqbKViTJv/3pgpFIPy42IPTY2WZCfuhsLwCjFqf
	 ZJY22QnnITm3JKhgNmDr5+DsSIehYrhU2OhlJ8us=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D99BF80245;
	Thu, 25 Aug 2022 16:22:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA0BCF8027C; Thu, 25 Aug 2022 16:22:47 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89968F800BD
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 16:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89968F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="XVN2bs+S"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1661437361; bh=NxfL7BUBZRZjKHn+bafHeFTQ77WmuTUX7XmfRatnADw=;
 h=From:To:Cc:Subject:Date;
 b=XVN2bs+ShScc4q35n+QEmIl1CFddsNl4YBBB7w5G+nPRV7TqYwH01sWNG6lG/OEvv
 q0Fl63hfCvsWMrKjlUrW0La30vD+ndF1aKyuCpSEZeJmOeFMoUGUPHJP5ljH2FFOvl
 boWq2pdFvlJfGcubwzzy1LeddXEo5OHc3n1pdMGY=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] Untested TAS2562 power setting fixes
Date: Thu, 25 Aug 2022 16:22:24 +0200
Message-Id: <20220825142226.80929-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Stephen Kitt <steve@sk2.org>, navada@ti.com,
 linux-kernel@vger.kernel.org, asyrus@ti.com, shenghao-ding@ti.com,
 raphael-xu@ti.com, =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
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

The tas2562 driver does the same thing with the setting of PWR_CTRL
field as the tas2764/tas2770 drivers were doing.
Link: https://lore.kernel.org/alsa-devel/20220808141246.5749-1-povik+lin@cutebit.org/T/#t
Link: https://lore.kernel.org/alsa-devel/20220825140241.53963-1-povik+lin@cutebit.org/T/#t

These are blindly written patches without testing since I don't have
the hardware. (I even tried TI's formal sample request program but
was refused there. CCing @ti.com addresses I found on other series
recently submitted.)

Martin Povišer (2):
  ASoC: tas2562: Drop conflicting set_bias_level power setting
  ASoC: tas2562: Fix mute/unmute

 sound/soc/codecs/tas2562.c | 90 ++++++++++++--------------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

-- 
2.33.0

