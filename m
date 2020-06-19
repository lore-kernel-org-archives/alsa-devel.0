Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CAC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F3220776
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tijdWVTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F3220776
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20493166C;
	Fri, 19 Jun 2020 10:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20493166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592554869;
	bh=NApRGbKI8Kme4b7OT0wHMNb+xsN+6XkT5feQqmikE5g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tijdWVTfrbsGt9WX+af6nVsj63hoVOLNQCfXWgNTMg8YQoCXqO9d++Fx+2HrT9jMx
	 7/ud6A1KhdAFRHVqh/hHAeDcM/w5N3XYsveGM4xWs1Y2ymxjM9Q9Sdq4GdRz1jmzKq
	 kYD+evsZK9hBr0ZX6d3qIwdLeHxlhGE2ki7ycByI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99678F80245;
	Fri, 19 Jun 2020 10:20:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA7DCF80252; Fri, 19 Jun 2020 10:20:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 25815F800EF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 10:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25815F800EF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592554812258071899-webhooks-bot@alsa-project.org>
References: <1592554812258071899-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq: use guint8 for the numerical ID of
 client/port/queue
Message-Id: <20200619082016.EA7DCF80252@alsa1.perex.cz>
Date: Fri, 19 Jun 2020 10:20:16 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #41 was opened from takaswie:

In ALSA Sequencer core, the number of client/port/queue is defined as below per each:

 - SNDRV_SEQ_MAX_CLIENTS (=192)
 - SNDRV_SEQ_MAX_PORTS (=254)
 - SNDRV_SEQ_MAX_QUEUES (=32)

Following to it, in UAPI of Linux sound subsystem, several structures have `unsigned char` type of members:

 - struct snd_seq_addr.client
 - struct snd_seq_addr.port
 - struct snd_seq_event.queue

On the other hand, within the UAPI, 'int' type is also used for the numerical ID of client/port/queue. Following to the 'int' type, current API of ALSASeq includes API with 'gint' or 'guint' type of argument. However, it's better to use 'guint8' with consideration about the range of value.

This patchset declares the arguments to have 'guint8' type.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/41
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/41.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
