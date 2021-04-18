Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94CDC433B4
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:48:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0956052B
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0956052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B18F1662;
	Sun, 18 Apr 2021 15:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B18F1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618753680;
	bh=Bn949B3i2O6oZxCqk82p5UdJ9o6CYHzdRkg+2EJQ1pg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uc6rqcFd6DYcOdGamcXegFJaPBFjWqbgVoLZy1w/khSL8hUM6G1w3qJXzVioyxf/8
	 yL5tadRyDZcf26UGPeAugmukO15j90XSXP9cHjEXFIsuKcBwKT6Eb6L5IpK3ELtGVJ
	 D+6Oi32RGWwKcOvsHcEJK7uf+26wLdwknlr/7iTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAAE3F80168;
	Sun, 18 Apr 2021 15:47:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71952F802DF; Sun, 18 Apr 2021 15:47:08 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04DB4F80164
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 15:47:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04DB4F80164
Received: by mail-qt1-f173.google.com with SMTP id 1so24304421qtb.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 06:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OO8HlSAOh1aWj0vwR0W/mxOKNyqV/ZAodTDZbXHtumI=;
 b=tQVusJv6CQvizXtatfWoA1bHsOWlGRyxctM7yjbkBQuLU+wXcfdHRubnQ+rGegLn0N
 pxY4UU6fOluqBpa5ovqxPj2h//2CIAXcYob/8bnzGX2u41ZZBbE6uR2AFZW847D80exJ
 mMbPjY4/l1owYFe/twnLNwP+GDY11L6ov6AxBHU/mnMunLJy0Rff1mIZZZ4CiHrJL+Zr
 GzLdvRe1Ua404uZwCI+G3waLnF5VaA6AHbV7ITKPWLvrdVDw1um6oUnvnez+gMMgVzEB
 vQ4/toMo8c7ZWjXnJYf9DHkvCCuHFJPWqpzEjTsPPxqk8ZYymTpSKGa4tIa2fyZZMeCd
 v4aQ==
X-Gm-Message-State: AOAM530bjzUQJgjYbOxFMcr8hzdkOCt/8i5y2vfZrGEdeFECeYQhWhNZ
 T+6Jy23RsIy4RmJod/BlEwI=
X-Google-Smtp-Source: ABdhPJw43SYFAR4HD1Zgk2/Pi19zrSv0kI+C4U+tRzPZtDX+1TepZ6hyUh6dYtoi9t9Gj1BULXiZgA==
X-Received: by 2002:a05:622a:46:: with SMTP id
 y6mr7495111qtw.154.1618753620258; 
 Sun, 18 Apr 2021 06:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:5b5f::f3be:e978])
 by smtp.gmail.com with ESMTPSA id p23sm3927937qtl.8.2021.04.18.06.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Apr 2021 06:46:59 -0700 (PDT)
From: David Ward <david.ward@gatech.edu>
To: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] ASoC: rt286/rt298: Fixes for DMIC2 config and combo jack
Date: Sun, 18 Apr 2021 09:46:53 -0400
Message-Id: <20210418134658.4333-1-david.ward@gatech.edu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>
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

The last two patches in this series fix a longstanding issue that prevented
the ALC3263 codec from using a headset mic. This codec can be found on Dell
systems including the Latitude 13 7350, Venue 11 Pro 7140, and XPS 13 9343.
In fact, there is an ACPI quirk for the XPS 13 9343, which forces it to use
legacy HD Audio just to avoid this issue:

https://lore.kernel.org/alsa-devel/CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com/

This may allow that ACPI quirk to be removed. Either way, the other systems
mentioned above do not support this quirk and already use the ASoC driver,
so this fix is necessary for headset mic support on those systems.

Note: there is likely other handling for this codec that only exists in the
HDA driver, but which also belongs in the ASoC driver. Commit 394c97f824fa
("ALSA: hda/realtek - Change EAPD to verb control") describes an issue that
does not seem to be resolved in the ASoC driver, to give an example.


Other patches in this series are not specific to the ALC3263. These patches
set the correct combo jack configuration when headphones are inserted, and
fix a misaligned value set in the DMIC2 Configuration Default register.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=114171
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=150601
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205961
Signed-off-by: David Ward <david.ward@gatech.edu>

David Ward (5):
  ASoC: rt286: Fix upper byte in DMIC2 configuration
  ASoC: rt286: Configure combo jack for headphones
  ASoC: rt298: Configure combo jack for headphones
  ASoC: rt286: Make RT286_SET_GPIO_* readable and writable
  ASoC: rt286: Generalize support for ALC3263 codec

 sound/soc/codecs/rt286.c | 34 +++++++++++++++++++++-------------
 sound/soc/codecs/rt298.c |  9 +++++++--
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.31.1

