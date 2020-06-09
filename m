Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CBC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:09:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F91207C3
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rFvBwpsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F91207C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E244B1684;
	Tue,  9 Jun 2020 11:08:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E244B1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591693742;
	bh=lSyo51taR74q2+ycK9QSiYQEJJuXUxVX9FP2NuPhFsc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFvBwpsQDIXWbrgJPHQ6nMtsqkAP0mlBEgDmBDOr8pyU7hid4qVl32nq0ZuAN9HzO
	 oF6rhCI+q+STIZPHlWaRFIJ1cKWgrizXVYQeq6r1F1PIxkMl3i6NjkQfz6Vxt2cdSZ
	 7hsUFLa8jPLf/IutvhxFJSr7sxT9PGTabH5Ne5Fo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FB19F80278;
	Tue,  9 Jun 2020 11:08:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83737F8028C; Tue,  9 Jun 2020 11:08:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B1B35F80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 11:08:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1B35F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591693685913017988-webhooks-bot@alsa-project.org>
References: <1591693685913017988-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: timer: add global method to retrieve current source of
 timestamp
Message-Id: <20200609090809.83737F8028C@alsa1.perex.cz>
Date: Tue,  9 Jun 2020 11:08:09 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #27 was opened from takaswie:

ALSA snd_timer kernel module has a parameter for source of timestamping. Applications cannot refer to the parameter via UAPI of Linux kernel, however it's possible via sysfs.

This patch adds an API to refer to the parameter.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/27
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/27.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
