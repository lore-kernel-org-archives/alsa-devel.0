Return-Path: <SRS0=+bKl=72=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB312C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 07:36:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B63207DD
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o1VQI9NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B63207DD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E16481660;
	Sat, 13 Jun 2020 09:35:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E16481660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592033774;
	bh=33O7KzkSoADVEp8oXUbfKWVcIoZR2h2KU8Yq2te7U8M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1VQI9NYKC+X9NzQun74H4QRWTy1KqfrdV44EyijBaZJbXZTW/eMx5nEYDA8wNF2s
	 r8S3SpVuQYc22I4/ieDMjxa0H4d7kmm+9tsSbtBB+amCmXxpfoabie7fuhe7Jjo7H7
	 FWCLJifc4vW3ZBbQ4S7E4DEkC3u3yWKi27VqXTEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66AC5F80278;
	Sat, 13 Jun 2020 09:35:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1256F80279; Sat, 13 Jun 2020 09:35:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 260B0F800C7
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2020 09:35:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 260B0F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592033711652971983-webhooks-bot@alsa-project.org>
References: <1592033711652971983-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: obsolete function with two arguments
Message-Id: <20200613073520.D1256F80279@alsa1.perex.cz>
Date: Sat, 13 Jun 2020 09:35:20 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #35 was opened from takaswie:

According to guideline of GObject Introspection, API with multiple out parameters is not preferrable[1].

This patchset replaces such functions with more suitable ones.

[1] https://gi.readthedocs.io/en/latest/writingbindableapis.html#multiple-out-parameters

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/35
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/35.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
