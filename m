Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E7C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EEF22A83
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EEF22A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C717D16FC;
	Wed, 23 Dec 2020 03:19:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C717D16FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608690015;
	bh=07FJ94/JhhjeGtGooCgnuze+tKQIH5U96CHlFU0af00=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLWuMabf1tcgUonMMsXybRqJEaGh5kI/OgvJSDbY+LWvoEpZmOICGcXVm9gF1p1F+
	 Obu/JVMdgSw7PogQvTFt5t+UzijTMeizvzTZC7RePHh/j7kAUJgQ3pnOSwwTTUXw9N
	 jgKegkDUR4Oo2QADXFo79uWAnS/k1cFs8vOac59w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D487F801D5;
	Wed, 23 Dec 2020 03:19:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A3EBF801EB; Wed, 23 Dec 2020 03:19:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDF65F8013F
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 03:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDF65F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kFa3GeVw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 924DA22202;
 Wed, 23 Dec 2020 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689959;
 bh=07FJ94/JhhjeGtGooCgnuze+tKQIH5U96CHlFU0af00=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kFa3GeVw3KSWYUEidErjZa2qej7snOtvL2FGGqjBAkvu+3IMgn/ezbWQ4oI9YbdKa
 XSkrt78/k8NVAP7Ecd8dOs3u2b85nRFiGU1NBkh0Gd2zgv4WbBAVRpCKNIWrqdtzxz
 RcCnogIF8/hLuUpM0gZf8bnF9xqcMj7yXjGX7JY28plQ03II4zJw/0Sh2GLljUItYK
 s44KbRvIEfR+MOjUA6SWNl+yZSBN7REu6NRCRV1uHQtiyeoJrSAd/GCzHSR6FSK3Q+
 meiaHcfOvb/zCQn6vFl1vDC74NT+BMwmfkTyG9ImI/doUrazwJMisl/ZrlS5iHBuTx
 o+5oJK6USxA5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 051/130] ASoC: SOF: IPC: fix implicit type overflow
Date: Tue, 22 Dec 2020 21:16:54 -0500
Message-Id: <20201223021813.2791612-51-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>
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

From: Curtis Malainey <cujomalainey@chromium.org>

[ Upstream commit 7c1d0e554a359cca77bfabd2a29b06f5322d172d ]

Implicit values may have a length of 15bits (s16) so we need to declare
the proper size so we don't get undefined behaviour. This appears to be
arch and compiler dependent. This commit is to keep the headers aligned
between the firmware and kernel. UBSan discovered this bug in the
firmware.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20201120144025.2166023-1-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/sof/header.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
index 10f00c08dbb7a..aae673b2bb5e2 100644
--- a/include/sound/sof/header.h
+++ b/include/sound/sof/header.h
@@ -30,12 +30,12 @@
 
 /* Global Message - Generic */
 #define SOF_GLB_TYPE_SHIFT			28
-#define SOF_GLB_TYPE_MASK			(0xf << SOF_GLB_TYPE_SHIFT)
+#define SOF_GLB_TYPE_MASK			(0xfL << SOF_GLB_TYPE_SHIFT)
 #define SOF_GLB_TYPE(x)				((x) << SOF_GLB_TYPE_SHIFT)
 
 /* Command Message - Generic */
 #define SOF_CMD_TYPE_SHIFT			16
-#define SOF_CMD_TYPE_MASK			(0xfff << SOF_CMD_TYPE_SHIFT)
+#define SOF_CMD_TYPE_MASK			(0xfffL << SOF_CMD_TYPE_SHIFT)
 #define SOF_CMD_TYPE(x)				((x) << SOF_CMD_TYPE_SHIFT)
 
 /* Global Message Types */
-- 
2.27.0

