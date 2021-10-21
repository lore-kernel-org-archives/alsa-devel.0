Return-Path: <SRS0=mh1Z=PJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 08:14:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93149610D0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93149610D0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0D13168A;
	Thu, 21 Oct 2021 10:13:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0D13168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634804061;
	bh=Aw+bkt1MQIpw+sXLeJ2Bv8LJv7XzbXXGvlrdJH3IDZA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wcqz5vMuNZMgFrPM95vn6mPY9i7y8K2w6QvlCwp63KkGYMRB6btOaJ/KfitbK3prH
	 CB6IdrFrpn4qtcMYuDsVcEsVYh6u+LGrn3MBsIauJBekD+Fu0eWcU14+bHsbL3OAZ4
	 +Vj14jAN03BXwrDst+6CpIX0d3i5WlSjywGiwYrQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1923FF80249;
	Thu, 21 Oct 2021 10:13:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 897B3F80254; Thu, 21 Oct 2021 10:13:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BEDE4F80240
 for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2021 10:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEDE4F80240
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1634803982555174112-webhooks-bot@alsa-project.org>
References: <1634803982555174112-webhooks-bot@alsa-project.org>
Subject: a52 plugin not working with PipeWire
Message-Id: <20211021081305.897B3F80254@alsa1.perex.cz>
Date: Thu, 21 Oct 2021 10:13:05 +0200 (CEST)
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

alsa-project/alsa-plugins issue #37 was edited from sjnewbury:

Using the lastest code since v1.2.5 I can successfully get AC3 output through HDMI when using speaker-test.  Defaults use a huge buffer and gives terrible latency, but it works.

PulseAudio also works fine with fairly low-latency using "tsched=1 tsched_buffer_size=32768 tsched_buffer_watermark=8192 fixed_latency_range=yes mmap=1".  This doesn't need the rate kludge any more.

When I try pipewire using mmap I get the below messages in the log, no audio:

`spa.alsa: alsa-pcm a52hdmi: mmap_commit wrote 512 instead of 1024`

With mmap disabled, no errors are reported, but still no sound.

Is there a configuration for pipewire which works with the a52 plugin, a pipewire bug, or is this another a52 plugin bug?

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/37
Repository URL: https://github.com/alsa-project/alsa-plugins
