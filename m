Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD1C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:33:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816EC204EC
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oaMMdCQc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tPhU/g97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816EC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1414E4E;
	Wed,  8 Jul 2020 13:33:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1414E4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594208031;
	bh=vPbmlmMFrE9cr7f6nvVFGxg4RQJe/xvJKPmZXk2NPKk=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oaMMdCQca0xpyFUUjoFI8Jlhvh6JMlrX3tgvmG8ypW68esLWjRX1MbrDtpS9nLd57
	 K0zMCpQJjI+9TGQVoMxkNGdrnVB9vTN6Eg/I05zMJnjjfNm7aQwuystP1f5HuwXf7b
	 TdhkJi9DzByML01dc3ZUNP0bwn9d+aSwDapFLYZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86091F80115;
	Wed,  8 Jul 2020 13:33:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71520F80161; Wed,  8 Jul 2020 13:32:58 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D883F80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 13:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D883F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="tPhU/g97"
Received: by mail-yb1-xb4a.google.com with SMTP id r17so50974014ybj.22
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=YgBvzWR/6mpx68PUV0u/0UmSPzbBc/aq4zhlyxD89Lg=;
 b=tPhU/g97C2Z9SoM8ukg3lyY+3LzQapj8WUc18iKxxIvFIPIBVYsImiZZTksfXNn0Rp
 /u6MVD8RMLKN4oTgFKBWgkrPq2rchoAerhtQugqBXsWQ1mk88GWSFlEw3PRwCm7UnLHk
 hPtY06QOpF0a/mfdYHGH9u+h3e+3EcKLjrZauYyYRCLWHbZmmK4mgWNCiCGk8RO6S9Li
 sYog2Ghm34YtGC1ehfzdKSHJ7zi31GisiZyyiaLy8JSBuIlBJcyo95nU7jRU3m3n5ddt
 oMSc4gO25rUxH0TolfImhu386WOMWG61g0d5Vt9eIVrw5mbgX+4UkJ2Wq46c3kyC1kjE
 DGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YgBvzWR/6mpx68PUV0u/0UmSPzbBc/aq4zhlyxD89Lg=;
 b=LrK9plPDGkk1rLQ17zHl4VW1W98/s0gWiAURxtzR2uF56W4i98LUxInA9DXDRwyzio
 ++iBSTyOTH6pQ11KytJ7A+f35Qaxo7sm6/Rnk1VAMrjzxRJNQogoq1xQA+dtkpJ8/oNP
 lm2ZbqNh5qLSPMWhOHlHIbmp+bsPez7fkudUMhx807CF62aaO6I/1T3SoMFrNhYvXx0z
 s68Lp8kW068OYoW1NngVe0He1TuWjuqW3Kl9JuAA/Km1v34Oy2dgKlcHyYw/x3aQ7Xpe
 AUOOzYwcJFvfZ1yX1tEmPmAt9HQajN6pDzggBCYGlmoy4azDelR27lvq4A6E7LOAMdRr
 GVnA==
X-Gm-Message-State: AOAM532hSip/MZ3tz8sW2/N/dG8o9bOiDmtGmECInFr/CWhIZHVK3exz
 JhYHrA20d7i37TqVyjnEYu0aSpuDlQpb
X-Google-Smtp-Source: ABdhPJwU4spJyyoGNxb4Jb/Nayvl3kBlAxo/YfV/UKlWZ45gyrvKZTUsEkc+OeRI3n3s+NQ3+Y/0sJm9ITXu
X-Received: by 2002:a25:2e43:: with SMTP id b3mr95187736ybn.190.1594207965184; 
 Wed, 08 Jul 2020 04:32:45 -0700 (PDT)
Date: Wed,  8 Jul 2020 19:32:30 +0800
Message-Id: <20200708113233.3994206-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 0/3] ASoC: mediatek: mt8183: support machine driver for rt1015
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tzungbi@google.com
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

This series tries to reuse mt8183-mt6358-ts3a227-max98357.c for supporting
machine driver with rt1015 speaker amplifier.

The 1st patch is straightforward: re-order the header inclusions.

The 2nd patch adds document for the new proposed compatible string.

The 3rd patch changes the machine driver to support either "MAX98357A" or
"RT1015" codecs.

Tzung-Bi Shih (3):
  ASoC: mediatek: mt8183: sort header inclusions in alphabetical
  dt-bindings: mt8183: add compatible string for using rt1015
  ASoC: mediatek: mt8183: support machine driver with rt1015

 .../sound/mt8183-mt6358-ts3a227-max98357.txt  |   5 +-
 sound/soc/mediatek/Kconfig                    |   5 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 171 +++++++++++++++---
 3 files changed, 153 insertions(+), 28 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

