Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE8C3525A
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Jan 2022 01:24:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C20461F6D;
	Wed, 26 Jan 2022 02:23:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C20461F6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643160255;
	bh=h64EeMv4yhUSNqyVY599nfi6XpGRNHkuBvZCeGF55d8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cLIPeeGLDx+ujjI3eCs7o+0R6WpJArSw5zDUDtP7W0+2aIuStj6eetRJh31LDOxjB
	 2ZZxu3zC/vZSuZ70gSuFx5j6RKlrWBVBfXWyFeKdkVjKbSRy4t3L2y+s6P9ZgDJ5b2
	 0tjgLIptayDsm6i2mQ2FhJeZIuIS1XEWwx+Ac45M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CA46F805B3;
	Wed, 26 Jan 2022 02:18:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82643F805B0; Wed, 26 Jan 2022 02:18:38 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13008F80516
 for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2022 02:18:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13008F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="BBPi0eIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643159916; x=1674695916;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=h64EeMv4yhUSNqyVY599nfi6XpGRNHkuBvZCeGF55d8=;
 b=BBPi0eIwHeBNaDs3dI8qpsM5bTsI4ciOb5sHXGwZJv2W5qDbuixYcpT2
 AshE+XR/SEiT/y0ShA7/WV7vFsYWn8x4G2Rzzk7TJACOdZ6kVMKUnULox
 bYauiaYTZ6NruXdgWYMlcECPx2BcCAvTw5z37HdK2jKwJf1I8xw/pl5Zu
 4W396g6s7YqNEU+7Ce8jMG1MJPUxnY2o+LU4peimsm1UAdnHt3YL60HwP
 ItFpKjQJBUKOxoT+0N7rKQjiGUcP4EkTUC3yiwt4QWQq/QS5MKwUiczrK
 aHaLxwrsUIKrB53pDEAudKn5LQ0SbavsLlSBhE56spNW4qCHZhBeZ7ZVL g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236257"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="246236257"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 17:18:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="520617680"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 17:18:16 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 19/19] soundwire: stream: make enable/disable/deprepare
 idempotent
Date: Wed, 26 Jan 2022 09:17:15 +0800
Message-Id: <20220126011715.28204-20-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The stream management currently flags an 'inconsistent state' error
when a change is requested multiple times. This was added on purpose
to identify programming mistakes.

In hindsight, there was no real reason to fail if the logic at the
ASoC-DPCM level invokes the same callback multiple times. It's
perfectly acceptable to just return and not flag an error when there
is nothing to do. The main concern with the state management is to
trap errors such as trying to enable a stream that was not prepared
first.

This patch suggests allowing the stream functions to be idempotent,
i.e. they can be called multiple times.

Note that the prepare case was already handling multiple calls, this
was added in commit c32464c9393d ("soundwire: stream: only prepare
stream when it is configured.")

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index ccf3c99dd579..f273459b2023 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1505,6 +1505,11 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_ENABLED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
@@ -1588,6 +1593,11 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DISABLED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_ENABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
 		       __func__, stream->name, stream->state);
@@ -1663,6 +1673,11 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DEPREPARED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
-- 
2.17.1

