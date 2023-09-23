Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17547CE7A88
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Sep 2023 17:51:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 977B0DE5;
	Sat, 23 Sep 2023 19:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 977B0DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695491474;
	bh=SHSmInWK4iID7tezFOgJ8pDrY4N/2dMFJvcBxw+N7Qg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DpmrRSi3TY13cK2Vy15YxwKcGmFaYQyTDJxDP4icsm8r6D6QvVyFV+vfWKFyhbRnr
	 6rjcm6u1W6Lhojm1rrKqRiX9I4Y3sZepjpDyut8QTIwITq1fw2BeO+lWc6IzzmeMfK
	 ZZrU2DBjTOOSK1g9Y+iTXEqkevFq2qWWHbj568Uo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CC1DF801F5; Sat, 23 Sep 2023 19:49:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D414EF801F5;
	Sat, 23 Sep 2023 19:49:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63F5EF8025A; Sat, 23 Sep 2023 19:49:42 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
	by alsa1.perex.cz (Postfix) with ESMTP id 1589DF800F4
	for <alsa-devel@alsa-project.org>; Sat, 23 Sep 2023 19:49:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1589DF800F4
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600";
   d="scan'208";a="176997667"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2023 02:49:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E807D40061B8;
	Sun, 24 Sep 2023 02:49:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] Simplify obtaining I2C match data
Date: Sat, 23 Sep 2023 18:49:24 +0100
Message-Id: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6MCGKNA3YNKOG4543M6A5CBUJ6DK5HA2
X-Message-ID-Hash: 6MCGKNA3YNKOG4543M6A5CBUJ6DK5HA2
X-MailFrom: biju.das.jz@bp.renesas.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6MCGKNA3YNKOG4543M6A5CBUJ6DK5HA2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series aims to simplify obtaining I2C match data.

This patch series is only compile tested.

v4:
 * Added as a series
 * Updated commit header for all patches
 * Updated commit description for patch#1.


Biju Das (4):
  mfd: arizona-i2c: Simplify obtaining I2C match data
  mfd: madera-i2c: Simplify obtaining I2C match data
  mfd: max77541: Simplify obtaining I2C match data
  mfd: max8998: Simplify obtaining I2C match data and drop
    max8998_i2c_get_driver_data()

 drivers/mfd/arizona-i2c.c | 11 ++---------
 drivers/mfd/madera-i2c.c  |  9 +--------
 drivers/mfd/max77541.c    |  6 +-----
 drivers/mfd/max8998.c     | 12 +-----------
 4 files changed, 5 insertions(+), 33 deletions(-)

-- 
2.25.1

