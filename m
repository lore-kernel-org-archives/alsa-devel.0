Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8846C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:25:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE642078D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IC97UbXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE642078D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A959167F;
	Thu, 11 Jun 2020 13:24:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A959167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591874721;
	bh=+9M69bNXuUJz3cRzKazZy0fEvV/AcejM8SZ/Xxzz5MY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC97UbXxYWDyBDyaPTwiFrIv/DT7a0bENCnRVLWoc0gMtKEJExII+w5ZR7HyzKkpt
	 /cuC6dPylQXHvw2nFDjQKxaFcl3QQyoQo5L8eb354pe2n+FpzQEixigJidM+FqEKXf
	 hjmGsFyvKAB/ZSaTKsYJQY6Yh+xfV0PeXkuyLLvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 963C9F800CC;
	Thu, 11 Jun 2020 13:24:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCA19F8028C; Thu, 11 Jun 2020 13:24:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5AD2CF800CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 13:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AD2CF800CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591874664591289043-webhooks-bot@alsa-project.org>
References: <1591874664591289043-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: obsolete abstract class for `snd_timer_read` and
 `snd_timer_tread` structure
Message-Id: <20200611112428.DCA19F8028C@alsa1.perex.cz>
Date: Thu, 11 Jun 2020 13:24:28 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #31 was opened from takaswie:

In UAPI of Linux sound subsystem, two types of event is read from ALSA Timer character device; snd_timer_read and snd_timer_tread. Before attached to any timer device, an user instance can select which type of event is expected.

ALSATimer.UserInstance uses one GObject signal to handle these events. These events are defined as derived object from abstract class, ALSATimer.EventData. However, the design pattern is not convenient for some language bindings.

For example, in Rust language, class-based inheritance is not supported. Gtk-rs project produces mechanism to upcast/downcast between super/sub classes and handles GObject class system. In my opinion, the code to upcast/downcast is a bit complicated to handle derivatives.

This patchset obsoletes usage of abstract class for ALSATimer.EventData. Instead, ALSATimer.Event is defined as concrete class and the instance of class is passed to the GObject signal. Applications use APIs to pick up expected type of data from the instance.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/31
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/31.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
