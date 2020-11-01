Return-Path: <SRS0=+QmS=EH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ADC2D0A3
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:18:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC2820723
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pzBHf1Q4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZLdKkma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC2820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E62716D2;
	Sun,  1 Nov 2020 21:17:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E62716D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604261915;
	bh=82mzLcsfZ3S5B5q/81xAXJUgqhFrk8AhGLZ3FiZPDFQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzBHf1Q4rkPdRHrco6MYbRjrvw/SQxOYSslMS9FUCQr19895TGtIDnfg3Iq8XWYd3
	 h7D8D36TAQb7v4jXVVyR6Gb+8psVU2bHsJ4Hqqn8EuwT37rrZNJ8O6IAUbzOZ2CsHE
	 xOTmA/2kAtDis6D71z5qsudckZe459QqAQXSY/kk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1DACF804CC;
	Sun,  1 Nov 2020 21:16:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1EF0F804C3; Sun,  1 Nov 2020 21:16:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0E7FF8015D
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2020 21:16:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0E7FF8015D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bZLdKkma"
Received: from localhost (host-213-179-129-39.customer.m-online.net
 [213.179.129.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9EFE21527;
 Sun,  1 Nov 2020 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604261760;
 bh=82mzLcsfZ3S5B5q/81xAXJUgqhFrk8AhGLZ3FiZPDFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bZLdKkmaw4RwWW3u7h0CAfcpdRvLyCYwBkGa8PDgnS8bBe3f/zHRSDMOIIcmB1l3R
 hNCXOJzCPwIxLoo0CuAz6jb9P1LIoqRVCRlQacz9Gq1rVxy127Q5rF6cmefPp32GOp
 zaoA3r2c5MixfYtgczplMzH1XbN2uIz9VsAv+WzI=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 gregkh <gregkh@linuxfoundation.org>
Subject: [PATCH mlx5-next v1 04/11] vdpa/mlx5: Make hardware definitions
 visible to all mlx5 devices
Date: Sun,  1 Nov 2020 22:15:35 +0200
Message-Id: <20201101201542.2027568-5-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101201542.2027568-1-leon@kernel.org>
References: <20201101201542.2027568-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kiran.patil@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, ranjani.sridharan@linux.intel.com,
 virtualization@lists.linux-foundation.org, fred.oh@linux.intel.com,
 tiwai@suse.de, broonie@kernel.org, Parav Pandit <parav@nvidia.com>,
 Roi Dayan <roid@nvidia.com>, shiraz.saleem@intel.com,
 Jakub Kicinski <kuba@kernel.org>, dan.j.williams@intel.com,
 Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
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

From: Leon Romanovsky <leonro@nvidia.com>

Move mlx5_vdpa IFC header file to the general include folder, so
mlx5_core will be able to reuse it to check if VDPA is supported
prior to creating an auxiliary device.

As part of this move, update the header file name to mlx5 general
naming scheme.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vdpa/mlx5/net/main.c                                | 2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                           | 2 +-
 .../mlx5_vdpa_ifc.h => include/linux/mlx5/mlx5_ifc_vdpa.h   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h => include/linux/mlx5/mlx5_ifc_vdpa.h (97%)

diff --git a/drivers/vdpa/mlx5/net/main.c b/drivers/vdpa/mlx5/net/main.c
index 838cd98386ff..4dd3f00f2306 100644
--- a/drivers/vdpa/mlx5/net/main.c
+++ b/drivers/vdpa/mlx5/net/main.c
@@ -4,7 +4,7 @@
 #include <linux/module.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/device.h>
-#include "mlx5_vdpa_ifc.h"
+#include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include "mlx5_vnet.h"

 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1fa6fcac8299..6c218b47b9f1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -9,8 +9,8 @@
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/device.h>
+#include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include "mlx5_vnet.h"
-#include "mlx5_vdpa_ifc.h"
 #include "mlx5_vdpa.h"

 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
similarity index 97%
rename from drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
rename to include/linux/mlx5/mlx5_ifc_vdpa.h
index f6f57a29b38e..97784098a992 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2020 Mellanox Technologies Ltd. */

-#ifndef __MLX5_VDPA_IFC_H_
-#define __MLX5_VDPA_IFC_H_
+#ifndef __MLX5_IFC_VDPA_H_
+#define __MLX5_IFC_VDPA_H_

 #include <linux/mlx5/mlx5_ifc.h>

@@ -165,4 +165,4 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
 	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
 };

-#endif /* __MLX5_VDPA_IFC_H_ */
+#endif /* __MLX5_IFC_VDPA_H_ */
--
2.28.0

