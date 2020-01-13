Return-Path: <SRS0=qOpI=3C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA02C33CA8
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:58:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E40C2075B
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eK6p22BJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="o4qduLEu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jArVN7Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E40C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC234850;
	Mon, 13 Jan 2020 09:57:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC234850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578905900;
	bh=iMeXOWKMDvz54F7W7Q1VlMvDXX/NiPs+pDdNtsd3HwQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eK6p22BJaHRD8qfZXWnnX3Ub5xFTX2LAYnknThbPfNjo4hKaECvTMuYNkKOW4qom5
	 ktgHDHqURa+hfY9vZEiuH7vOW2zfl8msVLubHbwi6qmWXCCGrhR9DYbj63wHo08dLH
	 IK3n21wN6Nzkq+a7p4C+JA/hsDq2sZF19SYVjrb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24A29F800B9;
	Mon, 13 Jan 2020 09:57:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1C43F801EB; Mon, 13 Jan 2020 09:57:28 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4937F800B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2020 09:57:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4937F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="o4qduLEu"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jArVN7Q0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id C8A3621D28;
 Mon, 13 Jan 2020 03:57:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 13 Jan 2020 03:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=TDCPsxrYqs//WyL2k7ckPOpBjU
 qhsO9I3Xy7BwtRXHU=; b=o4qduLEuWCxaqPOdqosajxkG2qqiJDQYn/VGVPpQ6I
 NwAskyR0BANAdScDv5H4pRjQ8lRNt0a0FjWnsuEeqyTBY/OBYiPIV+BTPUOlQDEw
 dKBR/G8Ov+LN6K8AKbx2iPGPa6hcfG//A07Z5ViaVRjgnWQeGZeVs+GGrKLqqBek
 iZ5bjHVMnjn0hmDBZ/AE+YsRtO1bI3aEscLNzkDHyszTmE+22n0SUQldjec2BIw9
 a1jXNu7FtRhs9Hjq24CvPNZ6PKRJJqBwvOvtK2pJhau1+zixrk63kl3j1Tw3uTdZ
 1qE9UrEPwYaJ2m3bAdAnqlzQ/Eg0+mkDOfq5SSCfx5Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TDCPsxrYqs//WyL2k
 7ckPOpBjUqhsO9I3Xy7BwtRXHU=; b=jArVN7Q0KfoLbRxKl05WuTyenawNBcHQ4
 Fe3HgHVAyvBquXocFYwlT7YoVH5OHVzJFK/j2I/M6BMpdO8ICEJqZv4KYLzQRh0N
 1AqWK4f7WkXDRiSWbWdAUKPjA9JcjlRwmntr9kATTBb7OteiJh68CVd0xP5IIv9I
 IVIzPaQqnsa+O2A+lAo5ysqplaBgtEl24DrT5KMQiYhsqR8ObRhDAAvUvwDljkLy
 u2pn6gdgMU4IHIVPRPeYA7x8LsmT/jf4O++GqMlvnRkIOAfL96BxBgiju3blIqMl
 Z8PE1AY2AY5eoVbo6/Zuk8/jfU6gQIfghO97k2hHqZGb0GNcbw1fQ==
X-ME-Sender: <xms:8jAcXkfhShS44yOfLYxlMoqG4MAe095fgSTQLETPBJkY4on2u1MueA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledguddvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhh
 ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
 eqnecukfhppedugedrfedrjeehrddukedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeho
 qdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpnecuvehluhhsthgvrhfuihiivg
 eptd
X-ME-Proxy: <xmx:8jAcXrNS4W_PffB0M-sXDg_cl0bU8fSpjw7HdQeJpTNQQSkq-hcPbQ>
 <xmx:8jAcXmbPraWpH6HcbRnGAb1CWDUE3tq77xLQyD1AK6OHXb1DOg-xjQ>
 <xmx:8jAcXvs1HS66U-CFkKCWEJB3OGXKqVsmpv8DNOGI6I9R40VLBEH-Iw>
 <xmx:8zAcXqH04VTojGRs39UIqMm2yRbNhqcfkaPFxXY5UHmOiJHpV_3TnA>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9967D8005C;
 Mon, 13 Jan 2020 03:57:21 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Date: Mon, 13 Jan 2020 17:57:19 +0900
Message-Id: <20200113085719.26788-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Scott Bahling <sbahling@suse.com>,
 stable@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: firewire-tascam: fix corruption due to
	spin lock without restoration in SoftIRQ context
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

ALSA firewire-tascam driver can bring corruption due to spin lock without
restoration of IRQ flag in SoftIRQ context. This commit fixes the bug.

Cc: Scott Bahling <sbahling@suse.com>
Cc: <stable@vger.kernel.org> # v4.21
Fixes: d7167422433c ("ALSA: firewire-tascam: queue events for change of control surface")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/amdtp-tascam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index e80bb84c43f6..f823a2ab3544 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -157,14 +157,15 @@ static void read_status_messages(struct amdtp_stream *s,
 			if ((before ^ after) & mask) {
 				struct snd_firewire_tascam_change *entry =
 						&tscm->queue[tscm->push_pos];
+				unsigned long flag;
 
-				spin_lock_irq(&tscm->lock);
+				spin_lock_irqsave(&tscm->lock, flag);
 				entry->index = index;
 				entry->before = before;
 				entry->after = after;
 				if (++tscm->push_pos >= SND_TSCM_QUEUE_COUNT)
 					tscm->push_pos = 0;
-				spin_unlock_irq(&tscm->lock);
+				spin_unlock_irqrestore(&tscm->lock, flag);
 
 				wake_up(&tscm->hwdep_wait);
 			}
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
