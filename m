Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94658C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 14:23:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0123651B9
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 14:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0123651B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58B221883;
	Tue,  9 Mar 2021 15:22:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58B221883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615299823;
	bh=y0G6stpuvdAfR2DYHuH/ctOOg6eTqCoSPEkKwvjIGCw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WvHmL7cikt9ttwmmsAPGLCNJckL0KOyEPDCiOUP4TOVZg/uFqMk3ax2JSH+Nx7QMq
	 otMrR/knttUcPIBVDFyYhHpGsrN23tsBvtdRVJ4MmhYDR6MrvSDAm1fJbSiaVGf+++
	 nBPp5/jhxIA4aOwNcDtAkxqqKUkPocvvzVerCrxs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9525F8032D;
	Tue,  9 Mar 2021 15:22:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5475F8032B; Tue,  9 Mar 2021 15:21:56 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D04EF80227
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 15:21:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D04EF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zE6Oke1u"
Received: by mail-wm1-x336.google.com with SMTP id
 t5-20020a1c77050000b029010e62cea9deso6509313wmi.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2021 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uuunhz4NVbgt9DS/9Uu7zQbhYemZOp1upoBNYz2qHKM=;
 b=zE6Oke1uYpEL93BU1SzCXg4rAN3Hbt7L8fLgcvD3MoC2yQ58TRyGXFFbiOkBxIZMYK
 E/IrFrBh1engrQznWZHdrezeHHDnunIBi6WkBvB5sLeKeY9GsKAsbnmTQoW7SRKlzLoO
 EHfyKyrTJBFsHLNAmAVVWJwtvRNQdDfQcEy7zzSfiZmMIYqzPuJuq7ez1qGK3nNoZKWY
 dnugJnLkYjyf6/RhO3Z3+8J8AKKBaMNe0TfXtw1TYX1GhDHAzzG59cChNNd5n8jHvYaH
 aARBI/SL5ofCq4y7xC7+jVZcGwPsW8gkGra8CWb5jIa61WOrklB7h/LldzKu3vlRlrU2
 Je5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uuunhz4NVbgt9DS/9Uu7zQbhYemZOp1upoBNYz2qHKM=;
 b=O+8LWvp5JwnJHpjh7RtIooWO96ReXFu+RS/4LB6jzAhpxG8/On79BBue9aHXXSfsc4
 tuABZVpWW0qH8/giJjgkiLj7QtQ8Oll2vcqS3brgS3DEU/l4Wy9YooNyHxvuJqb4I6AL
 c9vQ7TX8NUnarNn2B2+eKhmqIBqXxRVM9da0L+5zb0bpjmBi1aqaAjoEUn2QX3e6rFjv
 VKyRoMvhbscj9ePo7HYKxzOiDL+x63Ii/MbyZjHKeYyHrRoaTduMB9e/bDqzw3bRenjo
 BEPvIsi9hQVVnaMgEWSXKx6RIEOvjAWY5bX381Wd8UXQ+7INuGSfM25gn0BlX4Am3VRZ
 b3WQ==
X-Gm-Message-State: AOAM532QPFpUCqcOIQriZRUfYWoEArFhUzx+xroPd1yuYGO4jw/QGqxJ
 IaS+nCls/G1j7y9Q+kZq8kBopA==
X-Google-Smtp-Source: ABdhPJzpStRN37EUxIxXe8L6OZuLIdr6qJSH8rCEnhhSFX+L7iYjHQbbx1WqeoUTXNoaAZdfuYaDRg==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr4405267wmb.134.1615299704651; 
 Tue, 09 Mar 2021 06:21:44 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id j14sm22265123wrw.69.2021.03.09.06.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 06:21:44 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
Date: Tue,  9 Mar 2021 14:21:26 +0000
Message-Id: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: amit.pundir@linaro.org, alsa-devel@alsa-project.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 john.stultz@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

During testing John Stultz and Amit reported few array our bound issues
after enabling bound sanitizer

This patch series attempts to fix those!

changes since v1:
	- make sure the wcd is not de-referenced without intialization

Srinivas Kandagatla (3):
  ASoC: qcom: sdm845: Fix array out of bounds access
  ASoC: qcom: sdm845: Fix array out of range on rx slim channels
  ASoC: codecs: wcd934x: add a sanity check in set channel map

 sound/soc/codecs/wcd934x.c | 6 ++++++
 sound/soc/qcom/sdm845.c    | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.21.0

