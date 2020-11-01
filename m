Return-Path: <SRS0=+QmS=EH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B61C2D0A3
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:17:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EA720719
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TYi+rYr0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcmM8YLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EA720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA9D816BF;
	Sun,  1 Nov 2020 21:16:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA9D816BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604261865;
	bh=r8vLl6ZsscvRfoz94nO95aIzCwzo8xXWar83yZ8c/Nw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TYi+rYr0mDVTswVdhD9vIkazYMxaobhbO0t8NfPMxVjytpBxHZDbf4RpeCPnil2eK
	 +dDJXa6O+SHU10BBn767CWeHdiSpnkp+3zxlsP8HzowYEgK/t2hfAaxEvohsWe6dQW
	 +7BIKun8XYJLUigcSJtlF6PdeNi9idOTBMyUHMUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50E25F80272;
	Sun,  1 Nov 2020 21:16:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22442F80171; Sun,  1 Nov 2020 21:16:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17086F80158
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2020 21:15:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17086F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kcmM8YLc"
Received: from localhost (host-213-179-129-39.customer.m-online.net
 [213.179.129.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 955C221527;
 Sun,  1 Nov 2020 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604261754;
 bh=r8vLl6ZsscvRfoz94nO95aIzCwzo8xXWar83yZ8c/Nw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kcmM8YLclC92/kqrYCEF1U76q6zo14WTZ+qOg6pJsatEYviyPi0kkF9T9w6eWf2pd
 BfOQQ12GgchIBHWJvYGgKUqaVSfnhwjYNZYigN950lAu98yRJ5NdjG7ct17srtAh+U
 D4Epm3wo8qc3KccKKVtWBP4piv31SqSZX6lOk52E=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 gregkh <gregkh@linuxfoundation.org>
Subject: [PATCH mlx5-next v1 01/11] net/mlx5: Don't skip vport check
Date: Sun,  1 Nov 2020 22:15:32 +0200
Message-Id: <20201101201542.2027568-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101201542.2027568-1-leon@kernel.org>
References: <20201101201542.2027568-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 tiwai@suse.de, Jason Wang <jasowang@redhat.com>,
 ranjani.sridharan@linux.intel.com, Eli Cohen <elic@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 Jakub Kicinski <kuba@kernel.org>, kiran.patil@intel.com, broonie@kernel.org,
 Parav Pandit <parav@nvidia.com>, Roi Dayan <roid@nvidia.com>,
 dan.j.williams@intel.com, virtualization@lists.linux-foundation.org,
 shiraz.saleem@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>
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

Users of mlx5_eswitch_get_vport() are required to check return value
prior to passing mlx5_vport further. Fix all the places to do not skip
that check.

Fixes: c7eddc6092b4 ("net/mlx5: E-switch, Move devlink eswitch ports closer to eswitch")
Fixes: 5d9986a3947a ("net/mlx5: E-Switch, Fix the check of legal vport")
Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 7 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index ffff11baa3d0..88688b84513b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -120,5 +120,5 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	return vport->dl_port;
+	return IS_ERR(vport) ? ERR_CAST(vport) : vport->dl_port;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 6e6a9a563992..2e14bf238588 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1142,6 +1142,9 @@ int mlx5_esw_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num,
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
 	MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);

 	return mlx5_modify_scheduling_element_cmd(esw->dev,
@@ -1276,6 +1279,8 @@ static int esw_enable_vport(struct mlx5_eswitch *esw, u16 vport_num,
 	int ret;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);

 	mutex_lock(&esw->state_lock);
 	WARN_ON(vport->enabled);
@@ -1311,6 +1316,8 @@ static void esw_disable_vport(struct mlx5_eswitch *esw, u16 vport_num)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return;

 	mutex_lock(&esw->state_lock);
 	if (!vport->enabled)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c9c2962ad49f..429dc613530b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2159,6 +2159,9 @@ static int esw_create_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
 	return esw_vport_create_offloads_acl_tables(esw, vport);
 }

@@ -2167,6 +2170,9 @@ static void esw_destroy_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(vport))
+		return;
+
 	esw_vport_destroy_offloads_acl_tables(esw, vport);
 }

--
2.28.0

