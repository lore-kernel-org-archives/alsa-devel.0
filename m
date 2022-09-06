Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B467FC54EE9
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Sep 2022 09:30:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE94D829;
	Tue,  6 Sep 2022 11:29:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE94D829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662456606;
	bh=yV6nCsjeOdwaKJwa/v3ztHbWo4/fPObpHuPkgeFvzgA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEikjS77T615mYIWINW1z5bw1djH2x4X8pSJjhkKIT3SNYljXJW/neUQYpyX7WHcf
	 M/YK9W5/+yPB1G9dULGa6/MX+CT9W7OtaIDtN9SmcpgXMk4FhL+M0lwiR6qCOegp2M
	 PzqFRn7m25GDvK1zVXJScFWC4juhOzKQr4hR/+Q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F33A9F8056F;
	Tue,  6 Sep 2022 11:27:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 300C8F8055A; Tue,  6 Sep 2022 11:27:51 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C801F8024C;
 Tue,  6 Sep 2022 11:27:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C801F8024C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="kCCCdAdP"
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 821FE660038D;
 Tue,  6 Sep 2022 10:27:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662456460;
 bh=yV6nCsjeOdwaKJwa/v3ztHbWo4/fPObpHuPkgeFvzgA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kCCCdAdPwuWWeMFa2+5PwAQeF3I4MKfZVzXHZNN8nHmFiSVVBsmDlgUxsLjsyP9xR
 IG7ng+Ts5OLLA0ENa5tu0bVSpEDNDDO+9dYz6DJGGuQvT3ETw3fg5Ex9W+VROmO1wC
 Jvgq8XmCrR4QLTvQLvGbaGoG4f3hZiBpJB0fAJoM/sNqiN+0ygNgmwexBb0oy+SUWj
 7idoqXQjmJ1znaMpkR+dak5n9t2yN2r1o/7PTgUmR1UwvD4yzSSGWEgoEPjIqLPgiB
 gVKCwTylk+bgKHgvg0MabafFdICAlHcMgT9VXmoGU7SHBVrcyoymzJBiVG1ksEeaRv
 ij7DtFUjRljcA==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Subject: [PATCH 3/5] ASoC: SOF: mediatek: mt8195: Add mailbox generic
 callbacks for IPC
Date: Tue,  6 Sep 2022 11:27:25 +0200
Message-Id: <20220906092727.37324-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
References: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, chunxu.li@mediatek.com,
 Allen-KH.Cheng@mediatek.com, lgirdwood@gmail.com, kernel@collabora.com,
 yung-chuan.liao@linux.intel.com, sound-open-firmware@alsa-project.org,
 peter.ujfalusi@linux.intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, tzungbi@google.com, geert@linux-m68k.org,
 ranjani.sridharan@linux.intel.com, wenst@chromium.org, trevor.wu@mediatek.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 daniel.baluta@nxp.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, yc.hung@mediatek.com
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

Add the .mailbox_{read,write} generic callbacks for SOF IPC and, while
at it, also change the ipc_msg_data callback to use the SOF API
sof_ipc_msg_data() instead of the custom function mt8195_ipc_msg_data().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index ff575de7e46a..68747ee21c6f 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -496,14 +496,6 @@ static int mt8195_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return type;
 }
 
-static int mt8195_ipc_msg_data(struct snd_sof_dev *sdev,
-			       struct snd_pcm_substream *substream,
-			       void *p, size_t sz)
-{
-	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
-	return 0;
-}
-
 static void mt8195_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	u32 dbg_pc, dbg_data, dbg_bus0, dbg_bus1, dbg_inst;
@@ -574,6 +566,10 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
 
+	/* Mailbox IO */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
 	/* Register IO */
 	.write		= sof_io_write,
 	.read		= sof_io_read,
@@ -584,7 +580,7 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.send_msg		= mt8195_send_msg,
 	.get_mailbox_offset	= mt8195_get_mailbox_offset,
 	.get_window_offset	= mt8195_get_window_offset,
-	.ipc_msg_data		= mt8195_ipc_msg_data,
+	.ipc_msg_data		= sof_ipc_msg_data,
 	.set_stream_data_offset = sof_set_stream_data_offset,
 
 	/* misc */
-- 
2.37.2

