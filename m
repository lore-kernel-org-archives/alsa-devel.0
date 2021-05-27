Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D50C47089
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 12:27:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F2F613AA
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 12:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F2F613AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCBF51701;
	Thu, 27 May 2021 14:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCBF51701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622118438;
	bh=4lNhhozJ8tdxwaYxMJFfEQ+SvnfW/BFOwf3IH77ZIhE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pTW/quO3+vsEM3Oev/18WthDN+8T9JP2o/+FvcRbc9lcKmv3I0zhAaUFrM8HbKt3H
	 mBiWp3Pxc/oj9BKm+otqBgp9p8xvRyn7sZjjkzJqR8tM8D47WXbtl5ntxEmXegTvpM
	 PdtxSA4/k5nzpzzoSDkDjUNJlb+sq/C+2ZBxQ8tA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55850F8014B;
	Thu, 27 May 2021 14:26:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02BA4F8014B; Thu, 27 May 2021 14:26:25 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25F54F80116
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 14:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F54F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="kmiCXql6"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="jcfofCFk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 71A0DED0;
 Thu, 27 May 2021 08:26:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 27 May 2021 08:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=z0gAQ2cVDzhjVwoj3KY8JKBRRp
 Avgl3DMVA0vBHdwxc=; b=kmiCXql6ZcYSzrErXRRfDAh+UsU/MQeUNhiWbRF6j/
 shCPz067vyh0z0llgGIrTz5j2sdOzUJOWjCLI8Ra5lP+kbC3B6igwcBEDROdTcP8
 gY1GvjstBFKRbGD1JJYoOkBArywi2dgfhowQLcqp3N4uLRCVJ5bcvHeAUAGavxWV
 eIXTbkhvj6SSwqdCRdFC9nFwbAah7+04QgjC6f9rtvWBQArqhRqfwK4OHe1/occU
 Y17jjCEbuYOuCiFhXWlv0RKg6LSAXMK5uBCMAmDL/jsWtAxwfCptZEAh3LVmMUEc
 g2y0Tykrz8NuBNgdooLzlaqatYymW51gxp8tamXctlsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=z0gAQ2cVDzhjVwoj3
 KY8JKBRRpAvgl3DMVA0vBHdwxc=; b=jcfofCFkLNku304esravnRAZQAfgcrcj8
 /04GsPUZODN4rPS3xTL24A6Sud4b52u6q4vPQR8ylstS4ovt3fZUxocDhJCECl9I
 sDUad9mCSlToKWPpOcnOzAfeBpAU0PKHwDLkd9e8+nLZuBBcQgaq0cxMhTXiMg/w
 Wx/OVKd6WlRb/p70y4zdEs8vYozGHwps585yXMzi85yV0/Dq9TTFyBGVkpQUZ/Ik
 Y9DgdkL2g0xILJC36D96IPsEV//y2H9Fogj6xAaImHATi8G6dtkdUYEHZ+iCcoX0
 glTWdwJHF7+kFUD7lcjAnSN1jSqIFEm384humO6gXfERfX5AFWtMw==
X-ME-Sender: <xms:54-vYBG9LWeFRfdL5W4kzBYnJ1XSsEDFDX4x0sRMUBLoWf7AEQKKsw>
 <xme:54-vYGXi-FdOMg6dpRT1DO_YfW3xlzQ_PEl_DaBe9OjKV3JfuJ0WfHSbxLcqVgv-A
 00SPAhdP2UuWAwPLDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekhedgheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecukfhppedugedrfedr
 ieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:54-vYDJ721Lqo7uHSPyH6rbd_TR7eum1gVDQ-BBiBitO1v8wdCwuVA>
 <xmx:54-vYHHMHavFJAb7XD-n5BJKr3X5xyYrlWFamEI-t9XjC2FG31rkUw>
 <xmx:54-vYHVWzVOT_1U5vSrZ5dakWKlmySkXHHFOZ2gOJSm0r66b-gaTwg>
 <xmx:6Y-vYIcMVgRNqbs9Z4PnjeO0b_LF3-JII_YvnhH7bg-JDd5lfl1tpw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 27 May 2021 08:26:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 0/3] ALSA: firewire-lib: preparation for media clock recovery
Date: Thu, 27 May 2021 21:26:08 +0900
Message-Id: <20210527122611.173711-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

Hi,

ALSA IEC 61883-1/6 packet streaming engine have been using pre-computed
parameters ideal for nominal sampling transfer frequency (STF), to
transfer packets to device since it was added 2011. As a result of user
experience for a decade, it is clear that the sequence is not suitable
to some actual devices.

In design of audio and music unit in IEEE 1394 bus, feedback of
effective sampling transfer frequency is delivered by packets transferred
from device. Reuse of the sequence of parameter in the packets results
in pseudo media clock recovery to transfer packet.

In this patchset, an option is added to AMDTP domain so that each of
AMDTP stream for outgoing packet has association to AMDTP stream for
incoming packet, to replay the sequence of parameter. Some devices
require receiving packet on-the-fly to transfer packets, so another
option is added.

These options are just added, not used yet in this time. In future work,
they are going to be used by drivers in ALSA firewire stack.

Takashi Sakamoto (3):
  ALSA: firewire-lib: add replay target to cache sequence of packet
  ALSA: firewire-lib: replay sequence of incoming packets for outgoing
    packets
  ALSA: firewire-lib: transfer rx packets on-the-fly when replaying

 sound/firewire/amdtp-stream.c               | 252 ++++++++++++++++++--
 sound/firewire/amdtp-stream.h               |  17 +-
 sound/firewire/bebob/bebob_stream.c         |   2 +-
 sound/firewire/dice/dice-stream.c           |   2 +-
 sound/firewire/digi00x/digi00x-stream.c     |   2 +-
 sound/firewire/fireface/ff-stream.c         |   2 +-
 sound/firewire/fireworks/fireworks_stream.c |   2 +-
 sound/firewire/motu/motu-stream.c           |   2 +-
 sound/firewire/oxfw/oxfw-stream.c           |   2 +-
 sound/firewire/tascam/tascam-stream.c       |   2 +-
 10 files changed, 259 insertions(+), 26 deletions(-)

-- 
2.27.0

