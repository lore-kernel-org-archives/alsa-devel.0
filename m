Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDEC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 16:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D6D22DA9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 16:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D6D22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3853A1666;
	Thu, 10 Dec 2020 17:07:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3853A1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607616504;
	bh=sxd0w/rKG7WyP42I/3ov9Y2A8JUEXh7q1Z17nSwXHCw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EV6GvyWuR1HAJ/ywufgJOIlFox08hTBCg5AdNXmufvU8njvNqDctPoHao70aNGezz
	 /DZZP2dP8cnC5Y8j7ZXkDczDIowResLqS633umzYnhVdAvpjObGHh+rDUMaDCgZPGn
	 uSK7zJfi4Wj3dUC8sG2YfSucjR2DBZEvU0hyURQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D5D8F80105;
	Thu, 10 Dec 2020 17:07:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B98EF8016E; Thu, 10 Dec 2020 17:07:32 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F095CF80105
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 17:07:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F095CF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BbuUNdyz"
Received: by mail-qt1-x844.google.com with SMTP id c14so4023282qtn.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eWcL1BT1QnuDHTcH3v/ubnDXY+zwmaZ9OopY/z1kEGs=;
 b=BbuUNdyzevxIabi7TLgvhg09a3l3rlMVzOrqHgXrwq1KJl/vitSwd6WlcNDBm+oM7D
 eeFGQEeECpb36rhNTEbLjd3tX4ZJeSxkrmc1MZi3LLF0FHtq7yO7RymW0wJFpuUqrcgl
 HBk5OYlFWLhi7JHM48BtAISHG9k4PeJAswUpg0py0Yjqed+A4RCouWuQ2uDVfKpEMqex
 izHG7Xw3iU9aMyp9vu+29D91cW5EIlrwj7py6s/C3tCL/DdoYQXcsf64pDHuYdZthoU2
 wORc5RXFFo8Zo5cNMInUmIIj4tWj99tdl4D23xq7u39u93KxDd8J5jR2kKboHUGd6Y4g
 /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eWcL1BT1QnuDHTcH3v/ubnDXY+zwmaZ9OopY/z1kEGs=;
 b=dLfOxEVAy5QPmaASph7EHRQBaRWLFtqPvAcDXvc/EE0abPCua9QSMpE1mlF4bQPE4c
 oLCzaU1SLBePi8FlJft9zUwoEiuj2EoSZZWw8CfC5lAi7bJdPfBkiF37Xj82172CMiAy
 71npJCiORL1uy1CtNxzfQdsPcBosaRSBxTmHX7rLiWr2YQvhpqSVA7t+sPjqkjw0eSue
 mY5CVZMo5P3O3SlsvIKj6tSnMs5osYe/BznCbCPYK7rVUraUN7RS6UIqM5Idhmcy0RMd
 0W9KoAdQT73aE5clH8MQGwHtGLbIiMEfHvUVVWt/svxiqhqPqmNa1JINLc1Q4Zcz4pKa
 bhog==
X-Gm-Message-State: AOAM530+exMqYE0PR5+Krh5q549NmJLV7bY/KXWtA+0yCVfn8b0BkfMj
 7AMCsUQaMqHQw4+z7JOHX/4=
X-Google-Smtp-Source: ABdhPJwUjH70nFSoAI0x9PvKB6ZmS8lQ3yjwtIsKxQRfxgl3pLZr2BSXQm9apIOqjGjNbGnWBrOVhQ==
X-Received: by 2002:ac8:7111:: with SMTP id z17mr10060844qto.369.1607616442534; 
 Thu, 10 Dec 2020 08:07:22 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223]) by smtp.googlemail.com with ESMTPSA id
 d190sm3852290qkf.112.2020.12.10.08.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 08:07:22 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH v2 0/5] ALSA: hda/ca0132 - Fix no-audio issues and add
 documentation.
Date: Thu, 10 Dec 2020 11:06:52 -0500
Message-Id: <20201210160658.461739-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

This patch series attempts to fix the no audio at startup issues that
have been occurring for some users, using information gained through
reverse engineering the ca0132's onboard 8051 processor.

The issue of no audio on startup seemed to be caused by two separate
problems: not resetting the codec upon initialization, and not making
sure the DSP allocates it's DMA channels correctly.

Tested and working on all cards, except for the AE-7. The AE-7 shouldn't
have any issues, however, I don't have one on hand to test.

Connor McAdams (5):
  ALSA: hda/ca0132 - Reset codec upon initialization.
  ALSA: hda/ca0132 - Add stream port remapping function.
  ALSA: hda/ca0132 - Add 8051 exram helper functions.
  ALSA: hda/ca0132 - Ensure DSP is properly setup post-firmware
    download.
  ALSA: hda/ca0132 - Remove now unnecessary DSP setup functions.

 sound/pci/hda/patch_ca0132.c | 558 ++++++++++++++++++++++-------------
 1 file changed, 354 insertions(+), 204 deletions(-)

v2 changes:
-Remove conditional mutexes from patches 3 and 4.

-- 
2.25.1

