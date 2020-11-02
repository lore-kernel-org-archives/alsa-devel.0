Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961AC00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:56:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A3F222BA
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FiOFLSvr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="pekivcZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A3F222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47B991700;
	Mon,  2 Nov 2020 13:55:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47B991700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604321788;
	bh=cfAR1pH3dVtSxS5RypZthRJK5XDo9UIFqfEchlaeJXc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FiOFLSvrXpPiO0eXSA9pP7ofE6bnO+GjNg1m/mct5uy0ve05Rw68OjnyAdNmu1sKU
	 uW+Vq9ycrM6YZqQzrUInEijYpf5D74txCucKKNP4QqjeTH8w4jyfI2stMjeclk74qs
	 oKCzORD5ykCxi2rQz+9VXO2Sk98DdJNgFuT9p0tE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF48DF80229;
	Mon,  2 Nov 2020 13:55:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E021F80232; Mon,  2 Nov 2020 13:55:36 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF0EFF80083;
 Mon,  2 Nov 2020 13:55:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF0EFF80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="pekivcZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=638; q=dns/txt; s=axis-central1;
 t=1604321731; x=1635857731;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FwAyDfF8hpGLaLeCnfcNMUsZXvQZIufsf9z0qm9Gy8o=;
 b=pekivcZxtSbava6t6vPdosuBhBcJS1VRtAmMZHkN4NuSpJa+c6VNu5fF
 wEyqQa0K9Wp0KTLpCCD/ADi79pl/bhpQmq7tgZslQVJmCDTjC2MGdKdRf
 YbArAIcMRHRhKzU6jmHKEwS0D1AcI86aVh7BUo20FT+h+bR7KgjSMVAoK
 c6vg4GuK1zC1clMI7MZA0Yqp6f7gcGMJ97SrkiZfbFVS8IOSNIRxFUjiu
 QfT4tezMpyY9jG8vYG/NVqq+TMbuyJ2bnZE3abQBPUVEStLAFcMX2AAgr
 Z8bi4CB9+XP1Xwo+4apzZ6jCFwXcJBeQr4eTBeLT2uDkq+IUDLXpbzDL9 Q==;
IronPort-SDR: 8KQ3HAlPnH6l/SfutxQ6CynuvNX0Wc3mVbukqr0xnkkWS7VShmRiclHz+d+kL6+YrrV4AAAeIM
 ON7JTFrbw5fwu0dTXDDh+h8FWP43bFHvFrQWjfaTWjzRm7aVrRPImko9c4ymq+9j+MKpFWKZ0g
 8VEK3M7pzzRYnvy+K4a2xKEqLup2t8qP5ofz11xdQR6VVqmIr33A8ofZP2zDw507TeHaSsIMV6
 3ZuIKz/NLxSZIdoaNwmIauqOF4QGOG0OSTH3Jtkx/ZaOJ4iqTU40ekxmznc/Wk+ONfLIXeLndv
 F2s=
X-IronPort-AV: E=Sophos;i="5.77,444,1596492000"; d="scan'208";a="14649641"
From: Jonas Holmberg <jonashg@axis.com>
To: <patch@alsa-project.org>
Subject: [PATCH] pcm: set the snd_pcm_ioplug_status() tstamp field
Date: Mon, 2 Nov 2020 13:55:25 +0100
Message-ID: <20201102125525.194607-1-jonashg@axis.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org
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

Signed-off-by: Jonas Holmberg <jonashg@axis.com>
---
 src/pcm/pcm_ioplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index a437ca32..9b1b8ac3 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -115,6 +115,7 @@ static int snd_pcm_ioplug_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	snd_pcm_ioplug_hw_ptr_update(pcm);
 	status->state = io->data->state;
 	status->trigger_tstamp = io->trigger_tstamp;
+	gettimestamp(&status->tstamp, pcm->tstamp_type);
 	status->avail = snd_pcm_mmap_avail(pcm);
 	status->avail_max = io->avail_max;
 	return 0;
-- 
2.26.2

