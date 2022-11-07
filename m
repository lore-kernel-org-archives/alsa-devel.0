Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE964C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 04:27:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB497822;
	Mon,  7 Nov 2022 05:26:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB497822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667795242;
	bh=EQigBQMD8jvxcc49a5ARtMpdgsT6ZOxToLvVMLTZwGs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X+cUooySsb35Kw8OM8TlPXMXF/cjocYUoFV+8q9C7Gx8zGCRC0+jke09OEh8PhWDK
	 zBrGb+NUTf193x+mzgPCd5JLStWwZK8FAndYFZ9hWwwT/SEWup0Fih5NbFKj1Y8PeT
	 ebeHo6rBkQEcedDyIKpYb1ibis95wPL99Y506Lss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04BAF8024C;
	Mon,  7 Nov 2022 05:26:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DBB4F8025A; Mon,  7 Nov 2022 05:26:30 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5631F800EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 05:26:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5631F800EC
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6A781A0AD2;
 Mon,  7 Nov 2022 05:26:22 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DA551A0ADB;
 Mon,  7 Nov 2022 05:26:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B9AD180222D;
 Mon,  7 Nov 2022 12:26:19 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] pcm: rate - check rate type for using
 snd_pcm_rate_slave_frames
Date: Mon,  7 Nov 2022 12:05:12 +0800
Message-Id: <1667793912-18957-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: shengjiu.wang@gmail.com
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

With plughw device and mmap case, the plug pcm fast_ops pointer is same
as slave pcm fast_ops, but ops pointer is different, which cause
the "bus error" in snd_pcm_rate_slave_frames.

The test command is
arecord -Dplughw:x -r12000 -c2 -fS16_LE -M temp.wav

This patch is to add pcm type check as commit:
d21e0e01 pcm: plugin - fix avail_min calculation on rate plugin

Fixes: d9dbb57b ("pcm: rate - rewrite the may_wait_for_avail_min callback for the rate plugin")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 src/pcm/pcm_rate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index e8815e8b..dc502202 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1304,8 +1304,11 @@ static snd_pcm_uframes_t snd_pcm_rate_slave_frames(snd_pcm_t *pcm, snd_pcm_ufram
 static int snd_pcm_rate_may_wait_for_avail_min(snd_pcm_t *pcm,
 					       snd_pcm_uframes_t avail)
 {
-	return snd_pcm_plugin_may_wait_for_avail_min_conv(pcm, avail,
-							  snd_pcm_rate_slave_frames);
+	if (snd_pcm_type(pcm) == SND_PCM_TYPE_RATE)
+		return snd_pcm_plugin_may_wait_for_avail_min_conv(pcm, avail,
+								  snd_pcm_rate_slave_frames);
+	else
+		return snd_pcm_plugin_may_wait_for_avail_min_conv(pcm, avail, NULL);
 }
 
 static const snd_pcm_fast_ops_t snd_pcm_rate_fast_ops = {
-- 
2.34.1

