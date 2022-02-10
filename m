Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0013C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 20:43:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FE8B1917;
	Thu, 10 Feb 2022 21:42:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FE8B1917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644525814;
	bh=5QsItOEmHeMHQUdwn90lRyQBcic/WaCecMuc+C+xwVc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EV0iDs2zIrrynSnwnEb+n6M3ggKPwTogXankQ59ZxInaWBXJe4XkLngZLQpYpRzQU
	 7aHTkMHTIW46Qflb1txo6bOmf4994ANmPKPwbTfDAb/2dE4y8n4ClHdOFJiJQZDmGF
	 pfB64ymJFevJcTaf1ReR/7Mak9pvh//Qt7MU5mI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DDD4F8016C;
	Thu, 10 Feb 2022 21:42:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64109F80054; Thu, 10 Feb 2022 21:42:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F059AF80054
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 21:42:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F059AF80054
X-IronPort-AV: E=Sophos;i="5.88,359,1635199200"; 
   d="scan'208";a="5603081"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:42:32 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: linux-scsi@vger.kernel.org
Subject: [PATCH 0/9] use GFP_KERNEL
Date: Thu, 10 Feb 2022 21:42:14 +0100
Message-Id: <20220210204223.104181-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org
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

Platform_driver and pci_driver probe functions aren't called with
locks held and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.

All changes have been compile-tested.

---

 drivers/ata/pata_mpc52xx.c               |    2 +-
 drivers/crypto/ux500/cryp/cryp_core.c    |    2 +-
 drivers/crypto/ux500/hash/hash_core.c    |    2 +-
 drivers/media/pci/cx18/cx18-driver.c     |    2 +-
 drivers/media/platform/fsl-viu.c         |    2 +-
 drivers/message/fusion/mptspi.c          |    2 +-
 drivers/mfd/sta2x11-mfd.c                |    2 +-
 drivers/mtd/devices/spear_smi.c          |    2 +-
 drivers/net/ethernet/moxa/moxart_ether.c |    4 ++--
 sound/soc/intel/boards/bytcr_wm5102.c    |    2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)
