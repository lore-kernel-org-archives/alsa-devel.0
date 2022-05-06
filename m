Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA4C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 13:29:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47F4F181F;
	Fri,  6 May 2022 15:28:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47F4F181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651843748;
	bh=3ag24rVSHm4dqrak0S5Uo3zm0A2HCqdVxMA+VQqb+lc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sT4AHLHgI3YY3GT5k/zsVB8xl4Oz7Y9fcCeMItGynYQhPz0x5mPjNa1Egk9nU+7xz
	 YpWtTNlMcVUbtDWTIrKtm+bljMATobNzpYLKctfZTHT1zea3Qpom2FqmTE74Mjfdd6
	 pQUkV/lGYTpdeuIv2fJ82+y4zlLDek+G99xsRUzw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD9EFF8052D;
	Fri,  6 May 2022 15:26:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3B36F80171; Fri,  6 May 2022 15:26:50 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 013E6F80171
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 15:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 013E6F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="POdb/Rle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651843608; x=1683379608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3ag24rVSHm4dqrak0S5Uo3zm0A2HCqdVxMA+VQqb+lc=;
 b=POdb/Rleoi5AEdE5QfChUA+l/VTG3+ETZXwW4aLM0J0At+H75PJp1Etr
 eSVlcK6SbfXc7Khm4BMiGXR6+jxpVF0pynv8Mgvbs6Uhfx75pXFJPSN0a
 GmtyYaQHbGHKx2IptHxOnryN7zPycxcBXme57xP5HXEyT+kJssRZw/xRC
 1M/A91rV4H4a7shMZqafo/upW6jt+JtjlrBlrDARZUzwq2Rf0wtSP14AZ
 ndqL8wMQwgTet93Uzf54L/yrtiiDrbBY11C88wg8wxaPcgp2na2y7J5td
 kqV+/jlauQ1riPGXsPBhUiYT4nw5UNIRL7Zz8smXBSwCcWthkkSoR40bP w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293672830"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293672830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="585971612"
Received: from oelagadx-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.61.230])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:42 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 rander.wang@intel.com
Subject: [PATCH 6/8] ASoC: SOF: ipc-msg-injector: Separate the message sending
Date: Fri,  6 May 2022 16:26:45 +0300
Message-Id: <20220506132647.18690-7-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220506132647.18690-1-peter.ujfalusi@linux.intel.com>
References: <20220506132647.18690-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

Move out the code for sending the IPC message into a separate helper
function in preparation for support for handling IPC4 communication.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/sof-client-ipc-msg-injector.c | 48 +++++++++++++--------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/sof-client-ipc-msg-injector.c b/sound/soc/sof/sof-client-ipc-msg-injector.c
index 19bb6212cb56..b05493b1cd37 100644
--- a/sound/soc/sof/sof-client-ipc-msg-injector.c
+++ b/sound/soc/sof/sof-client-ipc-msg-injector.c
@@ -67,22 +67,11 @@ static ssize_t sof_msg_inject_dfs_read(struct file *file, char __user *buffer,
 	return count;
 }
 
-static ssize_t sof_msg_inject_dfs_write(struct file *file, const char __user *buffer,
-					size_t count, loff_t *ppos)
+static int sof_msg_inject_send_message(struct sof_client_dev *cdev)
 {
-	struct sof_client_dev *cdev = file->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
 	int ret, err;
-	size_t size;
-
-	if (*ppos)
-		return 0;
-
-	size = simple_write_to_buffer(priv->tx_buffer, priv->max_msg_size,
-				      ppos, buffer, count);
-	if (size != count)
-		return size > 0 ? -EFAULT : size;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
@@ -91,19 +80,44 @@ static ssize_t sof_msg_inject_dfs_write(struct file *file, const char __user *bu
 	}
 
 	/* send the message */
-	memset(priv->rx_buffer, 0, priv->max_msg_size);
 	ret = sof_client_ipc_tx_message(cdev, priv->tx_buffer, priv->rx_buffer,
 					priv->max_msg_size);
+	if (ret)
+		dev_err(dev, "IPC message send failed: %d\n", ret);
+
 	pm_runtime_mark_last_busy(dev);
 	err = pm_runtime_put_autosuspend(dev);
 	if (err < 0)
 		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
 
-	/* return size if test is successful */
-	if (ret >= 0)
-		ret = size;
-
 	return ret;
+}
+
+static ssize_t sof_msg_inject_dfs_write(struct file *file, const char __user *buffer,
+					size_t count, loff_t *ppos)
+{
+	struct sof_client_dev *cdev = file->private_data;
+	struct sof_msg_inject_priv *priv = cdev->data;
+	size_t size;
+	int ret;
+
+	if (*ppos)
+		return 0;
+
+	size = simple_write_to_buffer(priv->tx_buffer, priv->max_msg_size,
+				      ppos, buffer, count);
+	if (size != count)
+		return size > 0 ? -EFAULT : size;
+
+	memset(priv->rx_buffer, 0, priv->max_msg_size);
+
+	ret = sof_msg_inject_send_message(cdev);
+
+	/* return the error code if test failed */
+	if (ret < 0)
+		size = ret;
+
+	return size;
 };
 
 static int sof_msg_inject_dfs_release(struct inode *inode, struct file *file)
-- 
2.36.0

