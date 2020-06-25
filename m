Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA3C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:36:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A733B207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DqpKZQ9M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wN+MxTkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A733B207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CB9418F4;
	Thu, 25 Jun 2020 17:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CB9418F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593099409;
	bh=04m4u2+mvzmpZ44TdW4eCw2RXju7PGthRuHD8q/NbdA=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DqpKZQ9MPwBWq0duZFyRsPzZgEWwI1v3kxGbMhXayDd04XYhvQke2DSMGXavZufcD
	 dVhi54ajqX3o+uqTMKQ2XaHR8xMRefAHJU3C5Omx5+cJjDlrpVvtagaxR5hILHRzJG
	 XKwXeLkO0otLsHJ0Hysg3lVTNDkC4Qcbxhb9JGEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C279DF80218;
	Thu, 25 Jun 2020 17:35:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21889F80158; Thu, 25 Jun 2020 17:35:58 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74A39F80158
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 17:35:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74A39F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="wN+MxTkZ"
Received: by mail-yb1-xb4a.google.com with SMTP id s90so6311137ybi.6
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=Jy5xo/OxV/VNYtE2APHxAVGCJ3z+jMwyCElZE6ZTgGk=;
 b=wN+MxTkZn3rz7tBxcr6OPaHIp6Dxo13dvMLYQJ1JQyOIFAwgvKNz63qzMjeNWOsIRU
 cwTHo0EByP9AjcTelUY1D6WEVJQ0sXpvKsCMsabzp8aWSfeE9uZZePBJS+zcD+enRgdm
 3N5bm+SCqtNbsgCbZvSRG4TBmwWtfLxEi5GaxhxlhdbANRVrowZz6iO3KOktemtR43ID
 q34SZ28qlD7gjhSy9Q5Z770bLvZOCQtFICEiIL6cgoJK8+yZXECpvwApbq9c+DqNSbwZ
 gfuS08dnJdjMTGSqlUXkM3PbWNZI0i+svq2sZdOtqgxRKSa1wu0+r4UNOV2R6b3w43Sp
 lsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=Jy5xo/OxV/VNYtE2APHxAVGCJ3z+jMwyCElZE6ZTgGk=;
 b=r+MVq9WSQH5tSiNyj42WtfaExuyntQKxHtFu2n69WlajWjtS/8lMMdnZIZfhAt9hKZ
 cmbhwW14fWceX+eMtNWkrsFg2sSc2se7OhWeOyoBgpH1faLz7J8JvfsJzFCZlBi7uZbG
 oDpe03ZKOB4oAlcioP+vWNV3Jh5cXjPeY7CTEwK3UoP4jZUdHjxHZOAk8ysns6dcVGYM
 QAGqBpihhgTHN3AKDt++9YJXX2oI5XYFrqO8Gef4pNgCnwUtjAgV71EG2uw2kHEKbco/
 y6hCPAwoNzNHMzBhZdHeLB+mYpidnDyIJEFV1Eg2/tU408rCEpXxeFdXIk7iAAWemlyf
 szEw==
X-Gm-Message-State: AOAM530mQ70r+MNOwRdlsbRny1kFOS7F2cRnGqioZUl1DuK5xvuocLql
 Wn/QrEGVap2UBr1EOFeceU4oIQtTvNnH
X-Google-Smtp-Source: ABdhPJz4oZ3iNP6QQXj4eUYt4fm0/1ooZxu0GCqpFhNca0NggNx22a8S/x5Rl9Mldr/y/nodNvXH25+8I14k
X-Received: by 2002:a5b:290:: with SMTP id x16mr49447975ybl.75.1593099353421; 
 Thu, 25 Jun 2020 08:35:53 -0700 (PDT)
Date: Thu, 25 Jun 2020 23:35:40 +0800
Message-Id: <20200625153543.85039-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/3] ASoC: rt1015: fix compilation errors and warnings
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

The series fixes compilation errors and warnings discovered in the thread
https://patchwork.kernel.org/patch/11622319/.

The original patch:
(1) adds acpi.h for fixing implicit declaration of function 'ACPI_PTR'
(2) sorts header inclusions in alphabetical

The compilation errors and warnings are likely introduced by (2).

The 1st and 2nd patches fix the newly discovered errors and warnings.
The 3rd patch is the same as the original patch.

Tzung-Bi Shih (3):
  ASoC: core: move definition of enum snd_soc_bias_level
  ASoC: dapm: declare missing structure prototypes
  ASoC: rt1015: add missing header inclusion

 include/sound/soc-dapm.h  | 20 ++++++++++++++++++++
 include/sound/soc.h       | 18 ------------------
 sound/soc/codecs/rt1015.c | 17 +++++++++--------
 3 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

