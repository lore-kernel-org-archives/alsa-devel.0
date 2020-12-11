Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB8C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:13:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0938A23EB2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 05:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0938A23EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72F4784D;
	Fri, 11 Dec 2020 06:12:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72F4784D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607663620;
	bh=NK0iS+mWyiEJD90Y4k8JCXv0ppd0Hh6n4CW4ukwTsDM=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iftgdUUv9FBO6+We0c/hqjbaSLC9L/R4T2ojZ/zNl2U0gApB2LbEpOd2mQnrQliPR
	 9OeAxt59fEoUFKWTSGJwjWvviNPCQYOhyfIpn8i+QaFTOixxESBcBrwf32eCxLCeDj
	 buMpZmlmvznQIv5qxLkrOkajgiVmX2iJFwQXVgGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCB07F801D8;
	Fri, 11 Dec 2020 06:12:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 610C6F80217; Fri, 11 Dec 2020 06:12:47 +0100 (CET)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6826F80105
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 06:12:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6826F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="SNjCwf4t"
Received: by mail-qk1-x749.google.com with SMTP id u17so5642287qku.17
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 21:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=KO0TLTAbSV+Xw3Oru8rMA3xpo11QjKkb29mavqbPews=;
 b=SNjCwf4tiBxVyQTFWptqNmrcH9xksG+ZTFXrTU8gPdc4uiHkFr2iCfmnR7UWMee2cg
 fhjCkdRJ0awrtuuPzH4Sacnysp+nHzToyTGcr/Pnvpwd3FXVik89CLcaHRK8JP4VAV9I
 OnP+rrlHSqVFDIGzs2/OvJ3rQb+Oa5hOD1YIga4Pac9PYhQzZMFkMuLQdvV5CWcIsu7l
 JRQn4l9ntbOFceQRknqQx1IXVmVD+knIBsv0lOD++yWkSItc8kb+JudOgDQ1yKMi6hNe
 6LigAN+bEc6XxFurNOmHpL8YJUyyKoPHSYvRII5T1BaejnlCS2ooGQEdJzJohV0gBcrY
 pTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=KO0TLTAbSV+Xw3Oru8rMA3xpo11QjKkb29mavqbPews=;
 b=pVGTEnUbCidsMhI+7JDIeF9gXmqSdBuQFugHQVwPbFOEbgV15zxl4MW9fNL+Z2lgIh
 +tupgqzSTg8hh1e/isDX3C88w468K5AyWkeKY/5Ep6utFaLwROV23mHcWJisv7Kv9eAO
 min6Fpgu6mmZ/gs8X7Vhf+WQ+AhHVYzbb2oFzeeXJUaQMOc2bR6vqLZCPtTp1qBi5XrC
 Cosvl4IBQtDR+71ahuYcR/KEtSIRKR+mRDuieM6+9NinzzB6eoZ9lYt8I+KWC29IajEx
 XIjFqyVnbeRN/x1zbQfxRAbpYwWQY1cQJMJ9ptGAupYf0R5UZ66gF4wxYjCdxjrdMITy
 iI8Q==
X-Gm-Message-State: AOAM5333P4mIFarNG4yjCH3Vy8HEFsmeB2v6MbRLLFA3WBqwwcsm3GSL
 1fqsgS+lN1nyOQBsrNmLusUvbxodS8G/
X-Google-Smtp-Source: ABdhPJyA9JR4qniLbdZPNYNWqWofNJqyzbVUWuMzhZpk+AZActJIkI+4xG+CR4KVh8ksOiRDl/EEWGjtfx9x
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:13a3:: with SMTP id
 h3mr13468313qvz.5.1607663560353; Thu, 10 Dec 2020 21:12:40 -0800 (PST)
Date: Fri, 11 Dec 2020 13:12:22 +0800
Message-Id: <20201211051224.2307349-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v3 0/2] ASoC: rt1015p: delay 300ms for waiting calibration
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

The 1st patch moves SDB control from DAI ops trigger to DAPM event
(per review comments in v1).

The 2nd patch adds the 300ms delay for waiting calibration.

Changes from v2:
- Use gpiod_set_value_cansleep() instead of gpiod_set_value().
(https://patchwork.kernel.org/project/alsa-devel/patch/20201210033617.79300-2-tzungbi@google.com/)
- Assuming the calibration state gets lost after system suspend.
(https://patchwork.kernel.org/project/alsa-devel/patch/20201210033617.79300-3-tzungbi@google.com/)

Changes from v1:
(https://patchwork.kernel.org/project/alsa-devel/patch/20201209033742.3825973-1-tzungbi@google.com/)
- Move the delay from trigger to DAPM event.

Tzung-Bi Shih (2):
  ASoC: rt1015p: move SDB control from trigger to DAPM
  ASoC: rt1015p: delay 300ms after SDB pulling high for calibration

 sound/soc/codecs/rt1015p.c | 69 ++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

