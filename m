Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA83C6369E
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 15:05:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAD724654
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PkUuuOJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAD724654
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20BC316F1;
	Thu, 19 Nov 2020 16:04:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20BC316F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605798327;
	bh=sI88vgo0DPOp7XgE2iSxQpIYQMXpp5pyvceSCSE6gRA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PkUuuOJmihTvJyYFJ+OWJX2OXQ3f39Qets7mEIW63KVNI6FcyGW3aAZ0dBIiMC646
	 YfvAs/L1uuV+sDAO/5gAhzjgMUA70+WoBWzv+FefNrZVlij6KWQEew7+o6ncjwnFTp
	 R388k7SrICHTB7UoLigf02PtZCf8O1xg/TOjL53s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9D6BF80169;
	Thu, 19 Nov 2020 16:04:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E58CF801ED; Thu, 19 Nov 2020 16:04:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 368C4F8015A
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 16:04:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 368C4F8015A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605798256206105947-webhooks-bot@alsa-project.org>
References: <1605798256206105947-webhooks-bot@alsa-project.org>
Subject: Better documentation with the examples
Message-Id: <20201119150425.5E58CF801ED@alsa1.perex.cz>
Date: Thu, 19 Nov 2020 16:04:23 +0100 (CET)
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

alsa-project/tinycompress issue #8 was opened from Andres6936:

I have compiled the program and when I run the `cplay` script I get an error:

```shellsession
andres6936@Tierra ~/CLionProjects/tinycompress-master/src/utils $ cplay TestAudio.mp3 
Error: Can't find sync word
```

I have already checked out different mp3 files and I keep getting the same error.
I have also tried different options, but it is always the same error.

Issue URL     : https://github.com/alsa-project/tinycompress/issues/8
Repository URL: https://github.com/alsa-project/tinycompress
