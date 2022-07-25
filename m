Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B3C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 13:09:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B564684B;
	Mon, 25 Jul 2022 15:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B564684B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658754538;
	bh=4MVD07uVz8TokT7Qhzd/sDyjjIjUsb7epkzs9go0QoM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iNM48cZgYYyrEEVumsN+KMMTPa5/itPEh8zmNuKSsNGJuyJOtMDCymrRlXkp90QGS
	 NsVYJylNwXCmIn0ne7kK/p/x6iAEzfkuk72iRJkj16quyvfC8n646d2WAkLIx9cFfe
	 QfmxH+1juFcE4UowB0Y4HpwC+vBNvc5X89CJGp3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 529F0F8053C;
	Mon, 25 Jul 2022 15:07:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34471F804FD; Mon, 25 Jul 2022 15:07:20 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DC2CF80155
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 15:07:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DC2CF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="tT9qy+YD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1658754436; x=1690290436;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4MVD07uVz8TokT7Qhzd/sDyjjIjUsb7epkzs9go0QoM=;
 b=tT9qy+YDoJF/CfQC83Otzy0mW3xMHfGdrgo/vAgfFoJVdUzRaMuq47a5
 JFh6YHdC9ULTPhjTFq25DWY8r/vt8OVo+pz5zhBeHWobVTUxCLb//UacT
 eJdJ/ngNRO5jm5WnaU0E6s+xbtn9pjCi93NC5VJHFPVR4g4NZ2nbyLdDn
 qnQEwF3O4aIcmwB9NO867yaHIicXvlkCq3BXBDwFzfBW3kAkVm/HOh9Z0
 l/9/eahrYxgZH+7zkVYSUQ+ENrSEfpKaogm8DP53/inmNVZ73U7mBqrys
 2skm3LWDPPuAbuzCNvcxTqGdSu54wSsyyvucFbYIAlk4ulU+EaPR8gt+k w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; d="scan'208";a="106005848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 25 Jul 2022 06:07:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 06:07:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 06:07:00 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/5] ASoC: atmel: one fix and few cleanups
Date: Mon, 25 Jul 2022 16:09:20 +0300
Message-ID: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
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

Hi,

The series adds one fix for mchp-spdifrx and few cleanups for
mchp-spdifrx and mchp-spdifrx drivers.

Thank you,
Claudiu Beznea

Changes in v2:
- s/tag/tab in the title of patch 2/5

Claudiu Beznea (5):
  ASoC: mchp-spdifrx: disable end of block interrupt on failures
  ASoC: mchp-spdifrx: use single tag indent for structure
  ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
  ASoC: mchp-spdiftx: return directly ret
  ASoC: mchp-spdiftx: add and remove black line around
    MODULE_DEVICE_TABLE()

 sound/soc/atmel/mchp-spdifrx.c | 19 +++++++++++--------
 sound/soc/atmel/mchp-spdiftx.c | 21 +++++----------------
 2 files changed, 16 insertions(+), 24 deletions(-)

-- 
2.34.1

