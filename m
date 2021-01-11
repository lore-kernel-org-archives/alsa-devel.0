Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DDC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 05:44:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8922516
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 05:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8922516
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC6A81692;
	Mon, 11 Jan 2021 06:43:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC6A81692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610343860;
	bh=iWKp95CDEIUX90/wl1G5qQXmHCRDYtELF6mLSwDvotw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AqBP2gEvS3KoRhf0Xm5v5LV/XEf/ECemJL326OnfJWmF+KiSX3wm56NFXnM+ZlSZT
	 ATxKbZbrF62XPd/KsAIiRLnb8Jr+nxMfwLgzSepYUXDuiGh4nPYN1svld6LkZ7BVfZ
	 SUG1boMg9piNhdKFClZ1px+TY6Wayhhw1a+dH7Dc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DC23F80254;
	Mon, 11 Jan 2021 06:43:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 351F2F80254; Mon, 11 Jan 2021 06:43:25 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90862F8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 06:43:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90862F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="W8GdeCg0"
Received: by mail-pj1-x102b.google.com with SMTP id p12so7106295pju.5
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2021 21:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vMMmd7niASL0GbkxyQPnOxVIMiI8ncl5HbzeLIPpHis=;
 b=W8GdeCg0Uv4Qa9tjMNDZRbfwkndQtOZnj5X4CyYAcgpr20Bp9YjN8VAAQhqfS9jPAU
 u7nH9gzeuEi2aMLL8PGj74SiItupw0gjOy8nheZODCbqV/GBse57aB1jV3Hipi4UALow
 11QgCoY9R219S+84gCL/aqim5DljdcLbshAmIZBgf+jzEAI59sd88pSWCnbyVHf/nFmu
 91NCM9qkWBzV9n1ehCBlOWngUIoNx20WZ5ooxGlv/xXTAUyUu5Ua+hkC+rOtRXDIOo8p
 vFevAnvF0+AFarL3tYGqyUMh86054aOdviMaiuCslePriMBCNAqV/37mWvH6vbNRrjjx
 JdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vMMmd7niASL0GbkxyQPnOxVIMiI8ncl5HbzeLIPpHis=;
 b=kNB1vV5Od1CSKzIwijazFsV+PlDOOg7H/PhaWk9AvyNmXsWc09jV0yC9TQ72toTHOQ
 K868+fwAYOSgOXv5JzEeH5gq0V/5NRN15aAIsdUJOTf6zgcL8YJbCM67vnANM0D2aYb1
 XCdbUhXOBa1VG/cfie+m+zxUJj/Vc++E1PNnMAVngnRJeSlSgg7G9Y6oxLpRBusr4ZTn
 NtLn24MHSY4XZJx/ux+xpSWggFMOnhBzMt86pdy55ExJFoz1l5X44RImFl3dKvg3CT8x
 AiaoUPt9PcksrRP6hslNKR/YqSD3qeFfveUmaBQp6hZ0qmlxNE73MdWhI0y3i/l3T7c1
 Iffg==
X-Gm-Message-State: AOAM5300K6WKKPzMO0DnpHEhnbcGSnMXA80OeiCfpcy/h8iq5Tb4OPQZ
 aM4I9AHSZiR6q9ojJF/sdNWRtpCyECleog==
X-Google-Smtp-Source: ABdhPJyNb71bO/KS+r+7CKUUk+mowNqb7YK+RxJx1uNuYKPOlFd4RP6N6FwKZPOgBH+uiYZrb58I0w==
X-Received: by 2002:a17:90a:4402:: with SMTP id
 s2mr16311396pjg.37.1610343795412; 
 Sun, 10 Jan 2021 21:43:15 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net.
 [61.231.198.38]) by smtp.googlemail.com with ESMTPSA id
 x15sm16726267pfn.118.2021.01.10.21.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jan 2021 21:43:14 -0800 (PST)
From: Chris Chiu <chiu@endlessos.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v3 0/4] ASoC: rt5645: Enable internal mic and headset on ECS
 EF20
Date: Mon, 11 Jan 2021 13:41:37 +0800
Message-Id: <20210111054141.4668-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Chris Chiu <chiu@endlessos.org>,
 linux-kernel@vger.kernel.org, linux@endlessos.org
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

These patches are trying to fix the jack detection and internal
microphone problems on ECS EF20 series laptops which are empowered
by Intel Atom x5-Z8350 CPU (CherryTrail) with Realtek rt5645 audio
codec.

---
  v2 -> v3:
	Restore the accidentally removed terminator of the
	dmi_platform_data[].

  v1 -> v2:
        Invoke callback() of the DMI quirk if it exists, because
        the dmi_first_match() doesn't.
---

Chris Chiu (4):
  ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
  ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
  ASoC: rt5645: add inv_hp_det flag
  ASoC: rt5645: Enable internal microphone and JD on ECS EF20

 include/sound/rt5645.h    |  2 ++
 sound/soc/codecs/rt5645.c | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.20.1

