Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF2C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:52:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF1F23D4D
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bi2l8a7N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz0r7R1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF1F23D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF15986E;
	Mon, 29 Jun 2020 15:51:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF15986E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593438763;
	bh=ExLjXgZWw/0zjrLIbDaeGd7JgcoFGq7lfg4yUAVlg6k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bi2l8a7N6TfwJa/8nPpiTUJHQSYH4ePpRvXFxsTw3/TqfcZiYRD3E2hJlt5FxoiZd
	 mqyBzp+9/k01jsNzkq3L8bgOkYRITz59ebCMUwKudZ6Fg0c1wIoWHnGd7KWwVy6ZMJ
	 AIlGmLN0W6ji2dw/syUS8eVItHr2hYRRm5DL4I24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48375F802BC;
	Mon, 29 Jun 2020 15:49:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3738F80229; Mon, 29 Jun 2020 15:48:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC352F8021D
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 15:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC352F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Bz0r7R1n"
Received: from localhost.localdomain (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 045EC23D69;
 Mon, 29 Jun 2020 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593438473;
 bh=ExLjXgZWw/0zjrLIbDaeGd7JgcoFGq7lfg4yUAVlg6k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bz0r7R1nDnMuHaPhVhn84xesH7NHGDr7OTDK1nygMTqPm+4oSIQCWfSS6aXABp2kB
 rraIaPu9JEvGAjS6ZGHIx/lpDsbMBstg45zxtfonC+8bPV2vzix6rqoplDZQUPlTLS
 eU6DuYRwKG6MeU/1TWk5QBrDZmaVc5IbI09dXOsw=
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v5 1/3] ALSA: compress: document the compress audio state
 machine
Date: Mon, 29 Jun 2020 19:17:35 +0530
Message-Id: <20200629134737.105993-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629134737.105993-1-vkoul@kernel.org>
References: <20200629134737.105993-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

So we had some discussions of the stream states, so I thought it is a
good idea to document the state transitions, so add it documentation

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index ad4bfbdacc83..ad89af9b31c9 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -151,6 +151,57 @@ Modifications include:
 - Addition of encoding options when required (derived from OpenMAX IL)
 - Addition of rateControlSupported (missing in OpenMAX AL)
 
+State Machine
+=============
+
+The compressed audio stream state machine is described below ::
+
+                                        +----------+
+                                        |          |
+                                        |   OPEN   |
+                                        |          |
+                                        +----------+
+                                             |
+                                             |
+                                             | compr_set_params()
+                                             |
+                                             v
+         compr_free()                  +----------+
+  +------------------------------------|          |
+  |                                    |   SETUP  |
+  |          +-------------------------|          |<-------------------------+
+  |          |       compr_write()     +----------+                          |
+  |          |                              ^                                |
+  |          |                              | compr_drain_notify()           |
+  |          |                              |        or                      |
+  |          |                              |     compr_stop()               |
+  |          |                              |                                |
+  |          |                         +----------+                          |
+  |          |                         |          |                          |
+  |          |                         |   DRAIN  |                          |
+  |          |                         |          |                          |
+  |          |                         +----------+                          |
+  |          |                              ^                                |
+  |          |                              |                                |
+  |          |                              | compr_drain()                  |
+  |          |                              |                                |
+  |          v                              |                                |
+  |    +----------+                    +----------+                          |
+  |    |          |    compr_start()   |          |        compr_stop()      |
+  |    | PREPARE  |------------------->|  RUNNING |--------------------------+
+  |    |          |                    |          |                          |
+  |    +----------+                    +----------+                          |
+  |          |                            |    ^                             |
+  |          |compr_free()                |    |                             |
+  |          |              compr_pause() |    | compr_resume()              |
+  |          |                            |    |                             |
+  |          v                            v    |                             |
+  |    +----------+                   +----------+                           |
+  |    |          |                   |          |         compr_stop()      |
+  +--->|   FREE   |                   |  PAUSE   |---------------------------+
+       |          |                   |          |
+       +----------+                   +----------+
+
 
 Gapless Playback
 ================
-- 
2.26.2

