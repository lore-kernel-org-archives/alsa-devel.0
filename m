Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1392EC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Feb 2022 11:22:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 285DB179A;
	Tue,  1 Feb 2022 12:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 285DB179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643714537;
	bh=7QFuC8ZWm2tRkRjzkdAtsBOyN37zA6nPzhj3PQ7Shds=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vhTcHEuZn4Yzw5VS7SxCx+smcy3xEXmAhgxUiP6/1JhyAYgIL9OdzP2MC60FVXpfG
	 jGGGTHjudoFroMm3/vXUoXF+wq9usmrX4DPWfQW6s2r3XHq4dIeRCs6iBiRYu3b/xR
	 i5Zx4Vj7p8krA1eZQv7u9kB8hIFt8+2HlEHI8tGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9B27F8012C;
	Tue,  1 Feb 2022 12:21:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72BF7F80130; Tue,  1 Feb 2022 12:21:24 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A80DF80089
 for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2022 12:21:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A80DF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="i7aPzUTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643714482; x=1675250482;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7QFuC8ZWm2tRkRjzkdAtsBOyN37zA6nPzhj3PQ7Shds=;
 b=i7aPzUThXXyirnmrA8WBMNHg50q2oHtBYD6vUk1smV+CxcHEYq7fafk8
 LKcEkCHvo+MpabGAq/yTSNxyis+SSZEwqMwJ7yc4LwNlLlnMf7vQCC9qM
 1dFIlU8qdBViKkiqnNMIS3hRVLXFJbAYAQqKUHLMwmvgKJchgkU9U+xFh
 /40xNxuJ5zoHBfVSSQF6Vo3c5S8zlogjHzI+lu7T6vTyLD7k7rGcccked
 +i0A/JfGOKZoQ9rYmrFzRr/HYdv4+x0tJIbB6dz40hCuuf36lqxPSEhNO
 TqquCbYhFCQnSk6GBUbZ8J+bSzVN94jfEmBzRyJDqsChq0UN4Wv7ZReZ1 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247622419"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; d="scan'208";a="247622419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 03:21:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; d="scan'208";a="537767949"
Received: from addost-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.56.84])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 03:21:11 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda: Skip codec shutdown in case the codec is not
 registered
Date: Tue,  1 Feb 2022 13:21:44 +0200
Message-Id: <20220201112144.29411-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
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

If the codec->registered is not set then it means that pm_runtime is
not yet enabled and the codec->pcm_list_head has not been initialized.

The access to the not initialized pcm_list_head will lead a kernel crash
during shutdown.

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Tested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7016b48227bf..f552785d301e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3000,6 +3000,10 @@ void snd_hda_codec_shutdown(struct hda_codec *codec)
 {
 	struct hda_pcm *cpcm;
 
+	/* Skip the shutdown if codec is not registered */
+	if (!codec->registered)
+		return;
+
 	list_for_each_entry(cpcm, &codec->pcm_list_head, list)
 		snd_pcm_suspend_all(cpcm->pcm);
 
-- 
2.35.0

