Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B0C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Apr 2022 08:54:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15608170F;
	Thu, 14 Apr 2022 10:53:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15608170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649926460;
	bh=cEQEvphBiIzg6/kr9UccLiqAiwpoYj2x8zoUPjFGmKU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jxRqaXi9mwLwMFUf+opdEjBzVKZHXQhyWAYEjmDd10IMGxtmFK8R+Axq+a3On2aXz
	 WCKm55NBz1VRb9K5wdbcEDHpI+AIh57hPrO92nEC2A1lqF7xIWUUaDkfRRjyEkAz1j
	 XuoSA0jNEIMBcgMMHSnWuPDafZeDzupmbUlaQB5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78A11F80212;
	Thu, 14 Apr 2022 10:53:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1AE5F80431; Thu, 14 Apr 2022 10:53:22 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 951CFF80114
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 10:53:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 951CFF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qnyXFQ7F"
Received: by mail-pj1-x102e.google.com with SMTP id
 mm4-20020a17090b358400b001cb93d8b137so8704756pjb.2
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uLc5LuG9DXxlk7SdW/vHLWzAxidCNAK1f7OoSBQxLQc=;
 b=qnyXFQ7FYH5F6pL3WLFATSJXtdiijMkQeXs8/yj2+YwPJaHulFoZGbQiHMbiDE91+p
 cUe7Yx6OF2vgFsoIl386+fhn2xBWMuowEbN/Rndu3udC/AwQyDi/NM8zUWH8wJ7AKS/T
 nvia84DR4Fkn1T+iKmcuSCbpgTpIGF23+DhJFCKfiUQQqPkRUX/gpRVW7BRr/72tzQ5Z
 T/OrY30V5Z0kkU5f6rmlBXzUyVmrwaNZWMe740WBz4QxmrzN+gdmoEhRd0T+2clmz9Eq
 tzGDDnrErsY1hUJ+uKF+GNxwtitUgH7qCauyKMLekTWHncPkceUxauzh4B4/RVMpny6i
 V6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uLc5LuG9DXxlk7SdW/vHLWzAxidCNAK1f7OoSBQxLQc=;
 b=QYsvk3neL7WbN7PXN+ha9Dxk1BlyZBCOOLi23LMIZ5b+fjl5G9KICzgpv2+5PNA3A8
 XQ/gUhsr8C4xX7Mvn5hRw1iWdPCif+aynNOsbYUcW+WSa+5jN8bD6dxFNinQNJ5Yd9lJ
 k7PlVXHiGF7FuBXNbjy7rmvC9FA+lebRiv8+VQryGPWSVweyRTDFfX2wKcRAm3Xmh64b
 rYBpPGNQtjDIT/JUpDHynbn9qu/zepoyJw6n2byuUD/m0hHpwNGAnJEPtEctqs1rmoMt
 3Pp3c5DR4DlUK22gUmhQGd0DuKw6f+eTx3f1Trras5DByfqjDv3OsIflDHFaJAKC1zwF
 oC7w==
X-Gm-Message-State: AOAM532qlBvguexd//fC/mgo5YEXLQfd6v2+UBa0V5gV1erBSttva+uk
 BXUl8kaa83azXomI11scqno=
X-Google-Smtp-Source: ABdhPJx0tQpLjh8XEtImq0YVQ7dWH0j69VdBypkfkQcK9Fda3lLIGA5Klhd5KmwXibG5Bvu/7fwUzg==
X-Received: by 2002:a17:902:cf05:b0:156:8445:ce0f with SMTP id
 i5-20020a170902cf0500b001568445ce0fmr46185920plg.99.1649926394326; 
 Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a056a0000cc00b00508343a6f9esm720759pfj.5.2022.04.14.01.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: lgirdwood@gmail.com
Subject: [PATCH] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Date: Thu, 14 Apr 2022 08:53:10 +0000
Message-Id: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/img/img-i2s-in.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index f1f36f15a503..09d23b11621c 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -342,11 +342,9 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
-	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(i2s->dev);
+	ret = pm_runtime_resume_and_get(i2s->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
-- 
2.25.1


