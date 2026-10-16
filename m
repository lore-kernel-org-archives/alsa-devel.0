Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3391CC6B38
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:23:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C428A601F8;
	Fri, 16 Oct 2026 10:23:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C428A601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792139019;
	bh=6IxmlAsU9Doj3DacrOXu3fgS3QWpa0ta0mfpHlduklY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sYXyDn9J7nzXnFYK18H1M9cqkMPcfy3KbHOmJ817Xq2hHhiv0J3XmOwYvQ+WQZ/Dr
	 Y9P87H1wlapSQhvdpAnxK0/O2EzgJHZ4MSqGZR8f7inEwOyo3Sbl1JPT3wzJHV5ZgC
	 C0N2N05FCglMe0X1zvPrCjX52gUrOdvwwTifEuPw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A6BBF805F4; Fri, 16 Oct 2026 10:23:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECDE8F805F5;
	Fri, 16 Oct 2026 10:23:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78B79F80423; Fri, 16 Oct 2026 10:22:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792138977;
	b=iAsCi77B/Ob+JnjJPvFNnUH4HLfU9PO8zYvFZB6QnFoK7vZGlhNEKHSecDQIm0kGxLFU
	 d903C7i+OnM2Tu0X9dlpGVfprd50bInBMpPvnCdUMhZ2sjToRFM7vXhAmAYYsCBb0/cAA
	 HYQ6Hh1ZuwNBMJW6RM6dJmAXon0ne5Hkxr6HWyqHsSFUtEmx+FM6RlIjCPnO6PNHJNkNQ
	 IYKt5YnWi5c3kiPSat5iiH2XJGhkJvNkQN99fOEnU/UE5BYKkDi79a7QjJmOZX8XKzfdM
	 lzHVxn143RSVPUzwOQKJxFR7CwrlWVN9i74jjECsfnoU1RrCt8kCDVpnczsDqCnP+DA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792138977;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6IxmlAsU9Doj3DacrOXu3fgS3QWpa0ta0mfpHlduklY=;
	b=D88tmq16EyekI1ZksbzxWeNA4Ow4WU8lLiqmevKKpClpFd/Y8pBdJkHcHXRVLcGFhnyu
	 Ai6131bLGzFNd3BzUB1qLz9zos3pdoyrhy87GaZbdZAVnZKK7FUEXEvRAAySrs/SEzlhP
	 m5lJQSqcDydMzAz2BCrfU8Xm1zUkMmlr6EOQnJel0UZFZuX/M5xM/8LK3UGfQSqUD4zQL
	 srBZJtL8OW+dOB2GXh9afK79yioV7BJghB0Yy2UiKFg+EgN6JPdU/TPf1NDgBLK0Mz57O
	 M4yraAfdcvFMFVGNRLharagxR1l2bX331uBjRAUwza1G79gT0vMgmROYz8w9WIN2Mtg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=tjW353OD;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBED3F80212
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2026 10:22:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBED3F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=tjW353OD
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69G8MkowE3357345,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792138966; bh=NzIbi+9+5dLOG0T3iqltFDzEl7uYijF3UVC45rs58pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=tjW353OD+uDx1bCwbIPhB+EDDw1xPYQy88TLBDuCz4Ka/gXDAz1hCnw5exoASvUuN
	 83//52MzdPXFClc9Eq39AzydU5U5wAznHs3mbSS8PzvPmCccntYZaH+GfILWkV1d5D
	 eqfgOZFOf1PJYa8VeNApJlL3PCNXh5ZH15T92EsCos910xlonmSYtTbEKwzqff8aP3
	 z5tXNEwDGTGF3qY8y4erlugZPQ+ja7xLX2xX4+BURhaLypA129oiDQsW0TlrtsUeGq
	 +8CgrXxSRtsEFOqBIwiNhFsBFvJnNJWPcISd1/bpnNxI9pEalBZ4QMn1RE/K6Fe3d7
	 65RQolO4khBJg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69G8MkowE3357345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 16:22:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 16:22:45 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 16:22:45 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: rt721-sdca: Fix inconsistent indenting in jack detect
 handler
Date: Fri, 16 Oct 2026 16:22:43 +0800
Message-ID: <20261016082243.1352940-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 5HDSXY6NU2I5QMF7ASIYB3PNKEJCSMLO
X-Message-ID-Hash: 5HDSXY6NU2I5QMF7ASIYB3PNKEJCSMLO
X-MailFrom: jack.yu@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5HDSXY6NU2I5QMF7ASIYB3PNKEJCSMLO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Smatch warns about inconsistent indenting in
rt721_sdca_jack_detect_handler(): the rt_sdca_index_read() call that
samples the JD pin state, and the following mask of real_JD, are
indented one level deeper than the surrounding statements, so they
look like part of the preceding block although they are not.

Re-indent them to match the rest of the block. No functional change.

Fixes: e2eb4873b901 ("ASoC: rt721-sdca: Adjust blindwrite flow to fix type detection issue")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610080041.JAcitVQd-lkp@intel.com/

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt721-sdca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 5fc0aa991914..9f567caecb70 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -121,9 +121,9 @@ static void rt721_sdca_jack_detect_handler(struct work_struct *work)
 			return;
 		}
 
-			rt_sdca_index_read(rt721->mbq_regmap, RT721_JD_CTRL,
-				RT721_JD_1PIN_GAT_STA1, &real_JD);
-			real_JD &= 0x1;
+		rt_sdca_index_read(rt721->mbq_regmap, RT721_JD_CTRL,
+			RT721_JD_1PIN_GAT_STA1, &real_JD);
+		real_JD &= 0x1;
 		if (real_JD == 0x0)
 			rt721_sdca_jack_reset_state(rt721);
 
-- 
2.55.0

