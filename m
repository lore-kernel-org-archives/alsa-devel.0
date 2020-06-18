Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD11C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B411221F1
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AftRcR9L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+hCTKDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B411221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3BA61687;
	Thu, 18 Jun 2020 03:25:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3BA61687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592443562;
	bh=/wUskEBPkDlGuTw0FJYcgRRsQyOeMwrGcwZ4cte4Wio=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AftRcR9LfY0P3v1Ex+KgZUptlki1hyWcAVTvoHxC4Pe+PknirPePHxPeldmJlr3ah
	 y9RN7tqcSy5ppOSTSUPtuK5yC/Pl5/1+rGh9hqKJDY1xYj6JXltHyf4fLkKj+XX6lq
	 Zbd0w94HjO+oEhvTxuJIRHEKVBvf0rrL//fwT4aE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C669F80393;
	Thu, 18 Jun 2020 03:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B3F4F803A6; Thu, 18 Jun 2020 03:12:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5ABCF802C4
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5ABCF802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c+hCTKDG"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22A3321924;
 Thu, 18 Jun 2020 01:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442769;
 bh=/wUskEBPkDlGuTw0FJYcgRRsQyOeMwrGcwZ4cte4Wio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c+hCTKDGJxy9oH0L/DBpdkf3BsnF9vUfgayR6mawzI+17hZ38ECHlvcyzZwcyEGAc
 dphGmdWmCfcdINv5UQznF2umiOJBaullXBymIooZXzvAy5przLiRbyjCArG/ofRWZt
 +6A4Wgy7JE3mcwM6ulwTl/FHuDVlb8cSrNWmd1qw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 217/388] ASoC: codecs: rt*-sdw: fix memory leak in
 set_sdw_stream()
Date: Wed, 17 Jun 2020 21:05:14 -0400
Message-Id: <20200618010805.600873-217-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Jack Yu <jack.yu@realtek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Rander Wang <rander.wang@intel.com>,
 Mark Brown <broonie@kernel.org>, Shuming Fan <shumingf@realtek.com>
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

[ Upstream commit 07b542fe831cbefce163ad1b3aa7292c8a6332b8 ]

Now that the sdw_stream is allocated in machine driver,
set_sdw_stream() is also called with a NULL argument during the
dailink shutdown.

In this case, the drivers should not allocate any memory, and just
return.

Detected with KASAN/kmemleak.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Shuming Fan <shumingf@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>
Link: https://lore.kernel.org/r/20200515211531.11416-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt1308-sdw.c | 3 +++
 sound/soc/codecs/rt5682.c     | 3 +++
 sound/soc/codecs/rt700.c      | 3 +++
 sound/soc/codecs/rt711.c      | 3 +++
 sound/soc/codecs/rt715.c      | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index a5a7e46de246..a7f45191364d 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -482,6 +482,9 @@ static int rt1308_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
 {
 	struct sdw_stream_data *stream;
 
+	if (!sdw_stream)
+		return 0;
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index d36f560ad7a8..c4892af14850 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2958,6 +2958,9 @@ static int rt5682_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
 {
 	struct sdw_stream_data *stream;
 
+	if (!sdw_stream)
+		return 0;
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index ff68f0e4f629..687ac2153666 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -860,6 +860,9 @@ static int rt700_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
 {
 	struct sdw_stream_data *stream;
 
+	if (!sdw_stream)
+		return 0;
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 2daed7692a3b..65b59dbfb43c 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -906,6 +906,9 @@ static int rt711_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
 {
 	struct sdw_stream_data *stream;
 
+	if (!sdw_stream)
+		return 0;
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 2cbc57b16b13..099c8bd20006 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -530,6 +530,9 @@ static int rt715_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
 
 	struct sdw_stream_data *stream;
 
+	if (!sdw_stream)
+		return 0;
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
-- 
2.25.1

