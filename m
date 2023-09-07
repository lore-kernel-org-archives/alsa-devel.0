Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DB8EE14D4
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Sep 2023 09:57:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4B33A4A;
	Thu,  7 Sep 2023 11:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4B33A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694080645;
	bh=mM0JcVmjQBwg2L+s+Z5a+scf9lawERwrqGvhO/cyEyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PqyXcJuiAEhK5CioNBJJYmbTHPSvY+UuRPV+cqQBPxFup9c6HW7iSIv//zFRsihzX
	 F5aO7Dp+lIcXvkSbPN70Ei/aOB5Lib2eT1/uY2FuRtQe0c40z4bYm0MCDnAJg/Me9p
	 rCliIhxtYyn/8RHuQApql4AXxupRIqFxr34Lshqg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B98EF80570; Thu,  7 Sep 2023 11:55:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F791F80549;
	Thu,  7 Sep 2023 11:55:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88C51F80494; Thu,  7 Sep 2023 11:55:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1924AF800AA
	for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2023 11:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1924AF800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256
 header.s=dc header.b=YSzuTvQA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOVoT6V7KWNNEIeADoIjwh0zS86Ag75fR3Q12aE6oes=;
  b=YSzuTvQA1jS+b4RjgU0BGQ9rm6YONlbqmUWkHmpA7Ni8z+ubJcrp4Xi4
   QSyaSS4iH3rh7puO2ZE0ujv75PkCRRHmoJqmItOf67TgDYmEH3tZulHik
   5r7mYK/CQtqqOQ9I9Xfv6/q81mevXo6QCyyLqrCEcHf+66hVN9wv/nNOI
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600";
   d="scan'208";a="65324670"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:31 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ASoC: rsnd: add missing of_node_put
Date: Thu,  7 Sep 2023 11:55:20 +0200
Message-Id: <20230907095521.14053-11-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OLZFW5JFYWC357UYIO2AZ3SAJQCM7MZ3
X-Message-ID-Hash: OLZFW5JFYWC357UYIO2AZ3SAJQCM7MZ3
X-MailFrom: Julia.Lawall@inria.fr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OLZFW5JFYWC357UYIO2AZ3SAJQCM7MZ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

for_each_child_of_node performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/sh/rcar/core.c |    1 +
 1 file changed, 1 insertion(+)

diff -u -p a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1303,6 +1303,7 @@ audio_graph:
 		if (i >= RSND_MAX_COMPONENT) {
 			dev_info(dev, "reach to max component\n");
 			of_node_put(node);
+			of_node_put(ports);
 			break;
 		}
 	}

