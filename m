Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3AC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:52:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66E720768
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D/iTD+wd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zT1rj/st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66E720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4341E167D;
	Mon, 29 Jun 2020 09:52:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4341E167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593417174;
	bh=4LKpIFX//qRAllJ+p/LQyPjAO8hhlPUpwk6WJ6QqIYA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/iTD+wdPDukRaYoE/LMNdvg5uBdsGPRe90XuXK6wmA0ecBdu3UhLzowKKs4sJ4oY
	 u0/lXmR4LjKeoPLwC1rRCJq8DCxz4+00MFZqHf2+zeKx2sX2YuYxAuh5zmOJ/Z8q3e
	 R5J+i5MjMwn3ZnWNG8gQn6J47IUfltWEgeyXsuS4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CCBBF80268;
	Mon, 29 Jun 2020 09:50:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7D43F80229; Mon, 29 Jun 2020 09:50:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC823F8021D
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 09:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC823F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zT1rj/st"
Received: from localhost.localdomain (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3A57C23339;
 Mon, 29 Jun 2020 07:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593417022;
 bh=4LKpIFX//qRAllJ+p/LQyPjAO8hhlPUpwk6WJ6QqIYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zT1rj/stoL3B9i/xh9OSAa/ayCGezCrCst7C3RFPmZZWzxUJUUy5drPxK+PWmhlX1
 kAHco7DJ99K2vA8XOLYPzuWvUDutX2YXtd46+rQo3EawnmsknvGoKeMXVlNaU+CbiB
 SpJryPxQ+scWanDJZxtHT0qBNcg6FOQfkKGkG7Gk=
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v4 2/3] ALSA: compress: document the compress gapless audio
 state machine
Date: Mon, 29 Jun 2020 13:20:01 +0530
Message-Id: <20200629075002.11436-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629075002.11436-1-vkoul@kernel.org>
References: <20200629075002.11436-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Also documented the galpess transitions. Please note that these are not
really stream states, but show how the stream steps in gapless mode

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index b6e9025ae105..82950dbbc4a9 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -250,6 +250,38 @@ Sequence flow for gapless would be:
 
 (note: order for partial_drain and write for next track can be reversed as well)
 
+Gapless Playback SM
+===================
+
+For Gapless, we move from running state to partial drain and back, along
+with setting of meta_data and signalling for next track ::
+
+
+                                        +----------+
+                compr_drain_notify()    |          |
+              +------------------------>|  RUNNING |
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_next_track()
+              |                              |
+              |                              V
+              |                         +----------+
+              |                         |          |
+              |                         |NEXT_TRACK|
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_partial_drain()
+              |                              |
+              |                              V
+              |                         +----------+
+              |                         |          |
+              +------------------------ | PARTIAL_ |
+                                        |  DRAIN   |
+                                        +----------+
 
 Not supported
 =============
-- 
2.26.2

