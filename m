Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37AC47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 12:55:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D56613C9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 12:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D56613C9
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADFAA179C;
	Thu, 10 Jun 2021 14:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADFAA179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623329745;
	bh=EdzbBHso7jBm2UFF/a375CIpB6jtbhV+bsFHjbnmC2s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bc4gpFluetOQX2sPIqilvSPv8xEEBr+ZF7WTPOa6pmPv/n98go3fTt7uVdw0mfso0
	 uLhurLCXMMTYeb2g+x2qMG90xrurxmYNra6a+669gatW0uU7S//7sudTDSbZ5qNVfb
	 6p0ynWAhv5JgWXHI8hF3j1eZhXHzH73gehbJX8/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F41F800FC;
	Thu, 10 Jun 2021 14:54:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D2A3F80218; Thu, 10 Jun 2021 14:54:54 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BD80DF801EC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 14:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD80DF801EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623329690674726963-webhooks-bot@alsa-project.org>
References: <1623329690674726963-webhooks-bot@alsa-project.org>
Subject: pulseaudio can't load configuration for snd_hda_intel
Message-Id: <20210610125454.1D2A3F80218@alsa1.perex.cz>
Date: Thu, 10 Jun 2021 14:54:54 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #99 was opened from hzhuang1:

In v1.2.2, the content of HDA-Intel.conf is in below. v1.2.2 is widely used, such as in ubuntu 20.04.

```
Syntax 3
  
Define.Use ""  # a non-empty string to use UCM configuration for HDA devices

Define.AcpCardId "$${CardIdByName:acp}"
```
With this content, pulseaudio can't load configuration from UCM. Then I tried to edit the content. Change it to
```
Define.Use "2"
```
or
```
Define.Use "3"
```
Pulseaudio worked with "options snd-hda-intel probe_mask=1" on DELL laptop.

My question is what's the real meaning of **Define.Use** at here. Why the default value of **Define.Use** is empty string? Even in v1.2.4, the **Define.Use** is also an empty string.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/99
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
