Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E33C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 04:30:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7E120801
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 04:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WCiESI7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7E120801
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E32AD1678;
	Fri, 12 Jun 2020 06:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E32AD1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591936211;
	bh=l5nTLUPKowfVK7x8gIr4vWoqYRT9yrYYdCJuIKt8aQ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCiESI7P/mHSBKcGjrKJkQfXBeaKiyM6TJsRHfCRWg/fW6mme49zftHM3gioXoAma
	 9+eBcXNXdBnP2CIAbZjB6AsslJBU6/mZp+a7907iq0dcvvod8KrL8WvndkswT3nIHY
	 IR/MiZxpXxqPCs8OGOAM+02v3JuaG/1EVyM7Puu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5753EF801F7;
	Fri, 12 Jun 2020 06:29:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AFABF8021C; Fri, 12 Jun 2020 06:29:12 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3DA64F80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 06:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DA64F80058
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591936141922130108-webhooks-bot@alsa-project.org>
References: <1591936141922130108-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: ctl: obsolete abstract class for snd_ctl_elem_info
 structure
Message-Id: <20200612042912.5AFABF8021C@alsa1.perex.cz>
Date: Fri, 12 Jun 2020 06:29:12 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #32 was opened from takaswie:

In UAPI of Linux sound subsystem, snd_ctl_elem_info structure includes union member.

Current implementation of ALSACtl uses abstract class (ALSACtlElemInfo) and concrete class (ALSACtlElemInfoBool and so on) to represent variation corresponding to each of union member. However, the design pattern is not convenient for some language bindings.

For example, in Rust language, class-based inheritance is not supported. Gtk-rs project produces mechanism to upcast/downcast between super/sub classes and handles GObject class system. In my opinion, the code to upcast/downcast is a bit inconvenient to handle derivatives.

This patchset obsoletes usage of abstract class for ALSACtl. The target is ALSACtlElemInfo. Some APIs are added into the object to retrieve data for integer/integer64/enumerated element type, then the object becomes concrete class.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/32
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/32.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
