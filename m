Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355F1C4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Nov 2022 16:37:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6F4D1620;
	Sun, 13 Nov 2022 17:37:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6F4D1620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668357471;
	bh=x+EJ+P2iS5XPVVlGza3HbY2GzghhfUZiNaJ0BV+gdis=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WZ/Kf17qH4NEo4+EXKv3pmtDgrFWS3PFJ8v0jBHt6LQXC9hmlzmbMuXS/hFAxjVlN
	 HRiZNKgbEbpOXEVVlpgnjQ3b0ld+AaIwDut2GxPUtCpGK+IwYhXJlXYCZgUieR4Eu8
	 go3bDY7hWfXP6hJB9DedfZn1+NJmFx6ZxZIoV3AU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9D47F80537;
	Sun, 13 Nov 2022 17:36:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A865EF80557; Sun, 13 Nov 2022 17:36:12 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C735F800B8
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2022 17:36:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C735F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="lSs7voTq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=p8fZXFOilxr1b8Vw8YSIZYORkb8OJr3ydr3tjQdLjg4=; b=lSs7voTqaJMI0HO0w/yDtxu1V5
 bFe2oVzPY3oP8bREwzfNwOfWUgcPhllF1FYQEtFuUdqSntgGpVcEKGvjdMdeRZNgtepgsxwzJLiSn
 GvChig1xISPaA22YRe2fmw21MmtcqUGwGi1MQGchbpeaxiOepb97cZQSGxx7iCEz0vLWLoLK0kc3z
 YrVB1crY8jRv7Zr9cNcMJV+zZMfzYNgpLoWblTjEfj+DSomHWeqFcLXkIgabUpr2UAWzxcb1BU95i
 sOERMpomMz96rkOTLwN3fbdaqSgxsjj3g7QlZtlea2h4gsFZH2Nu8pE5vgZOBKQ0vsKohRmYD3rmk
 JdGh1NIA==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ouFxL-00CLQc-V1; Sun, 13 Nov 2022 16:35:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Russell King <linux@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>
Subject: stop drivers from passing GFP_COMP to dma_alloc_coherent
Date: Sun, 13 Nov 2022 17:35:28 +0100
Message-Id: <20221113163535.884299-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-s390@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

this series fixes up various drivers that either try to get a compound
page from dma_alloc_coherent or more often just did a bit of cargo
cult copy and paste, and then warns about this flag passed in the
DMA layer instead of silently clearing it like done by ARM and dma-iommu
before.

Diffstat:
 arch/arm/mm/dma-mapping.c                     |   17 -----------------
 drivers/infiniband/hw/hfi1/init.c             |   21 +++------------------
 drivers/infiniband/hw/qib/qib_iba6120.c       |    2 +-
 drivers/infiniband/hw/qib/qib_init.c          |   21 ++++-----------------
 drivers/iommu/dma-iommu.c                     |    3 ---
 drivers/media/v4l2-core/videobuf-dma-contig.c |   22 ++++++++--------------
 drivers/net/ethernet/broadcom/cnic.c          |    6 ++----
 drivers/s390/net/ism_drv.c                    |    3 ++-
 kernel/dma/mapping.c                          |    8 ++++++++
 sound/core/memalloc.c                         |    5 ++---
 10 files changed, 30 insertions(+), 78 deletions(-)
