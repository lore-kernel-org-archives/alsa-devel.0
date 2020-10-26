Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB34C4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:22:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740512465B
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gbOwBXdb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzKsb4Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740512465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B98851711;
	Mon, 26 Oct 2020 12:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B98851711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603711361;
	bh=kYfadg6gLyLVi6mHxKCgaHXIqaW4EsqBEoU/06nnGP4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbOwBXdbZz+4Rsnh9bYU8KZCHFmh/E7H/0+tsQxhrIpZFMLy1gqXoEaT0IxBNpo90
	 f2+Udq+pArqpH+971thTQj4VxFWIb1niPpIgGSiEooOmlB5i5eSXyRj4RToIWe1ckj
	 XjusHzqsUP7o5plajeYRjgByKM5w0L+aFwwDl/Rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A053F804BC;
	Mon, 26 Oct 2020 12:19:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D718F804E7; Mon, 26 Oct 2020 12:19:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB68AF804BC
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 12:19:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB68AF804BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IzKsb4Wq"
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 906B3223AB;
 Mon, 26 Oct 2020 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603711161;
 bh=kYfadg6gLyLVi6mHxKCgaHXIqaW4EsqBEoU/06nnGP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IzKsb4WqC7vpB1Ho2x6iJyy5BwG0vMGG3QFDfjlpMd1mGsE5OsqCs4PXlYnX2LZxz
 gQIXYz9KojONk50TAzbeveRtOF5q22Q+lxZJIaMlJhgBq7nq87YiTowQHdRSsjg705
 +ViaPVxWe1qgVDoEhkasZlXtJkdTKf+4ZbRRP/G8=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 03/11] net/mlx5_core: Clean driver version and name
Date: Mon, 26 Oct 2020 13:18:41 +0200
Message-Id: <20201026111849.1035786-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026111849.1035786-1-leon@kernel.org>
References: <20201026111849.1035786-1-leon@kernel.org>
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

Remove exposed driver version as it was done in other drivers,
so module version will work correctly by displaying the kernel
version for which it is compiled.

And move mlx5_core module name to general include, so auxiliary drivers
will be able to use it as a basis for a name in their device ID tables.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c     |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c  |  4 +---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c      |  1 -
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c        | 11 +++++++----
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h   |  3 ---
 include/linux/mlx5/driver.h                           |  2 ++
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a28f95df2901..1a351e2f6ace 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -52,7 +52,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 running_fw, stored_fw;
 	int err;

-	err = devlink_info_driver_name_put(req, DRIVER_NAME);
+	err = devlink_info_driver_name_put(req, KBUILD_MODNAME);
 	if (err)
 		return err;

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d25a56ec6876..bcff18a87bcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -40,9 +40,7 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 {
 	struct mlx5_core_dev *mdev = priv->mdev;

-	strlcpy(drvinfo->driver, DRIVER_NAME, sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, DRIVER_VERSION,
-		sizeof(drvinfo->version));
+	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 		 "%d.%d.%04d (%.16s)",
 		 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 67247c33b9fd..ef2f8889ba0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -64,7 +64,6 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,

 	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
 		sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 		 "%d.%d.%04d (%.16s)",
 		 fw_rev_maj(mdev), fw_rev_min(mdev),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index cac8f085b16d..97d96fc38a65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -39,7 +39,7 @@ static void mlx5i_get_drvinfo(struct net_device *dev,
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);

 	mlx5e_ethtool_get_drvinfo(priv, drvinfo);
-	strlcpy(drvinfo->driver, DRIVER_NAME "[ib_ipoib]",
+	strlcpy(drvinfo->driver, KBUILD_MODNAME "[ib_ipoib]",
 		sizeof(drvinfo->driver));
 }

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 71e210f22f69..9827127cb674 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -77,7 +77,6 @@
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_VERSION(DRIVER_VERSION);

 unsigned int mlx5_core_debug_mask;
 module_param_named(debug_mask, mlx5_core_debug_mask, uint, 0644);
@@ -228,7 +227,7 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	strncat(string, ",", remaining_size);

 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, DRIVER_NAME, remaining_size);
+	strncat(string, KBUILD_MODNAME, remaining_size);

 	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
 	strncat(string, ",", remaining_size);
@@ -313,7 +312,7 @@ static int request_bar(struct pci_dev *pdev)
 		return -ENODEV;
 	}

-	err = pci_request_regions(pdev, DRIVER_NAME);
+	err = pci_request_regions(pdev, KBUILD_MODNAME);
 	if (err)
 		dev_err(&pdev->dev, "Couldn't get PCI resources, aborting\n");

@@ -1617,7 +1616,7 @@ void mlx5_recover_device(struct mlx5_core_dev *dev)
 }

 static struct pci_driver mlx5_core_driver = {
-	.name           = DRIVER_NAME,
+	.name           = KBUILD_MODNAME,
 	.id_table       = mlx5_core_pci_table,
 	.probe          = init_one,
 	.remove         = remove_one,
@@ -1643,6 +1642,10 @@ static int __init init(void)
 {
 	int err;

+	WARN_ONCE(strcmp(MLX5_ADEV_NAME, KBUILD_MODNAME) ||
+		  strlen(MLX5_ADEV_NAME) != strlen(KBUILD_MODNAME),
+		  "mlx5_core name not in sync with kernel module name");
+
 	get_random_bytes(&sw_owner_id, sizeof(sw_owner_id));

 	mlx5_core_verify_params();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 8cec85ab419d..b285f1515e4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -42,9 +42,6 @@
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/driver.h>

-#define DRIVER_NAME "mlx5_core"
-#define DRIVER_VERSION "5.0-0"
-
 extern uint mlx5_core_debug_mask;

 #define mlx5_core_dbg(__dev, format, ...)				\
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 317257f8e0ad..ed1d030658d2 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -56,6 +56,8 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/devlink.h>

+#define MLX5_ADEV_NAME "mlx5_core"
+
 enum {
 	MLX5_BOARD_ID_LEN = 64,
 };
--
2.26.2

