Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B134C54EED
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Jan 2023 12:08:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07ADEE7B;
	Mon, 30 Jan 2023 13:07:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07ADEE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675080504;
	bh=Nh6/usZ2THZBSY98qO/fgkA7zKcsohS6tiOaRuCPZGk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=qUZGveDOsPAQKQlrljM+vaodY8pFuueZS1qr3wKFga7WN3ijF+Q37mNKMuDAwff3t
	 HLK6+oNBv38stUaydRCbc88xqESzp+5rHoaKIYpZVQ4qxKtF0a9B1Ia6rnMoPbJfiJ
	 MwqEi4bSR+HPNFglp6mMNoCpWY3o7UA+cuUxTZyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B9E1F8032B;
	Mon, 30 Jan 2023 13:07:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84CAAF8032B; Mon, 30 Jan 2023 13:07:30 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52172F800A7
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 13:07:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52172F800A7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=1mTzQKgu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1675080446; x=1706616446;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Nh6/usZ2THZBSY98qO/fgkA7zKcsohS6tiOaRuCPZGk=;
 b=1mTzQKgub8TuXiwzxGgfDnrjhDCDjC3e7afdOYBCQJ744Skd1kzGHEC4
 8iqm1+bLvO3wsYeBAZnaDlheeCNZaF+TPbGp8RW1aiJqUKGh06XUi39i9
 58rpGatzMISYGSbCpuVkzBiLVgoF2wCtQX2daTcr1mKQMLEcdj7zsX6f2
 Rv0ZIRTAg4fXvcffRFkvZwKl3/Lir7fXWdLNmaX+Az5/3gpxfudIDaotS
 ClbmLOSK+SBVxsGmzBTJmCuTYCfrPzKxOG90tmmMXJ8BGPnj5Ze9GHjqp
 QiW2IKNedJZwXfI0JnzLgnh9WQGv+ofSMTNNF7BcaDXF/YPs9GE0y+nYa g==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; d="scan'208";a="198784198"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 30 Jan 2023 05:07:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:16 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/8] ASoC: mchp-spdifrx: add runtime PM support and fixes
Date: Mon, 30 Jan 2023 14:06:39 +0200
Message-ID: <20230130120647.638049-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

This series adds runtime PM support for Microchip SPDIFRX driver.
Along with it I added few fixes identified while going though the code
and playing with Microchip SPDIFRX controller.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ASoC: mchp-spdifrx: fix controls which rely on rsr register
  ASoC: mchp-spdifrx: fix return value in case completion times out
  ASoC: mchp-spdifrx: fix controls that works with completion mechanism
  ASoC: mchp-spdifrx: disable all interrupts in
    mchp_spdifrx_dai_remove()
  ASoC: mchp-spdifrx: use unsigned long to store clk_get_rate() value
  ASoC: mchp-spdifrx: remove struct mchp_spdifrx_dev::fmt member
  ASoC: mchp-spdifrx: add runtime pm support
  ASoC: mchp-spdifrx: document data structures

 sound/soc/atmel/mchp-spdifrx.c | 552 ++++++++++++++++++++++++---------
 1 file changed, 403 insertions(+), 149 deletions(-)

-- 
2.34.1

