Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6499BC43331
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:36:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02292082E
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jUd+e58y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02292082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AB3B165D;
	Thu,  5 Sep 2019 22:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AB3B165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567715798;
	bh=vpntTkX9fb2SNAbnuM1I09heszlAlDyDTC2OB7DSfC4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jUd+e58ykJ2EDw5UosCfgbHhVR76Ho27LG9DxKMPRnRk4XQ8OeK0e9uZpCWeoSRfQ
	 QO2vAfTaiVLARK3tHkj3ftln/bbHmMrTfJ/HjT1CkHtLdQs9Pqo9YIv4fywckdBVYt
	 bIQOtj02TeVw9QYNDR95pTREBUYvk9E2U6vuSODU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A14CF803D1;
	Thu,  5 Sep 2019 22:35:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64449F80448; Thu,  5 Sep 2019 22:35:45 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55317F80227
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2019 22:35:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55317F80227
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MD9Gh-1hwrfp1PeL-0097XB; Thu, 05 Sep 2019 22:35:32 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Vinod Koul <vkoul@kernel.org>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Date: Thu,  5 Sep 2019 22:35:09 +0200
Message-Id: <20190905203527.1478314-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:vUt90rPVuKBhMvAKaolFnfJ447V2j2l1NdTi2KuiTVUjJF/VMdK
 W4NpP0PCa6CURF+o9a0uqgojYoRFGkOjD+H1QVw6c1sl23slLJYVQ/udPPOI6YYl7pVrw0H
 +XNjujaTYQzsTuyPl38UUjbiBDNoIY6wtQJqIYkzsHssSJFDlYCwd4uGYzVyiNnUSQ1L0q/
 ROw7IblgHWQfBixsU0lQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzvcKXxZC78=:D4by9+2BPSQkdoUL99X1O1
 ZK8Ld98Bzfj/dBWG+LU0lpKk+23JjbFddiD6m+LtcCu0CXqbboDMPnG4vhR1MTF4pEebU4UdY
 V+Nkc8J7rno4TSeQ6BAoQLVrWZvs8WX36UosnuUI40wgIvB6kylyMnfYqsh4IPtbJRPDR15hj
 8ayrQT2/G+GJDDivE1TbF388/NexMqtOfE5ngN/9JkEaZncpz68mvLpCvEB0yRhDi9ejaslJJ
 gnpTw1efGODciNFPRlUKpMf3PryP1JcB0IOl83+HUXk32+hvxPDjB3MVKFVlvpyCIX6zep1vp
 Z59tLfL3UehdlDj3EVnqBnrVOWZikd7ZUjxi+joUuYmWyQWRQnYI3eV+EpkKqb6RT1eqCvxEe
 bDxJQc975yDmboJNNtdbwSM3RMCgJszZsG6V1XFbNJCBSlCd2jfUoKbUK8DVb0JVGm9U3TFf3
 fZkq2j38sNWy33k3ma8Iw/xjRTTbzZed3vm8Z7o0qD8WuQ8wtNq6MH8NicOke2QvnSLwATZw2
 6DFOOSvILMnE3tXAFYdkIa3UbW3w5+q4KDuj4Gfcs85zJetw5qwCWW6C6jORQt9TrG+IzTMyJ
 IMldpPv7l+PN9fZVHn/ANz7heyJX5cYfXAoCnrymFHrBmTzC63s5MatIJCRzxnn9TmWelQrb9
 0g2m7eBLbBR2+xoYlZ4ej8aYXmQ9t4NS3Ck0/TWLT+WHiXppC7pNNtcJ/clIhjeqAL/IphLIW
 8yLWFVYdmyV4lkN30c2xrEmk40yE0jIXcjQpw4lbbe8qweQug7/KeFCEqx5IUOT98I3IfC2Ai
 pLMj7R/jcWL8QjXa70y9hegzAvgSt1Fwj7PIx98leGjH/XBBQ8=
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] soundwire: add back ACPI dependency
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

Soundwire gained a warning for randconfig builds without
CONFIG_ACPI during the linux-5.3-rc cycle:

drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]

Add the CONFIG_ACPI dependency at the top level now.

Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soundwire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index f518273cfbe3..c73bfbaa2659 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
+	depends on ACPI
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
