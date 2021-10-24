Return-Path: <SRS0=sa53=PM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C698FC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Oct 2021 13:23:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C0160F70
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Oct 2021 13:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3C0160F70
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 300EB165E;
	Sun, 24 Oct 2021 15:22:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 300EB165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635081806;
	bh=WebPCIcUhqG0F9R0TyydiMVrPS021xBu3bKn7wrHMVg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U2MBhSfnLeuM9F+dteOeyQiG2DOAE+KPQPacTrgAad+rWH6ICZdqWWppznrPzMye5
	 9fgDvG/x+5SXgseogX5H9EFMEq4zZxqAS6Ncrc7rLtVuJ10VOvvUSrFi8Rfu8YKEdY
	 tbxpvsn/BgFtdUJqSaMtm88x5zdxs3HGCoZIZt8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 944B8F80269;
	Sun, 24 Oct 2021 15:22:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5556F802C8; Sun, 24 Oct 2021 15:22:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E606AF80086
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 15:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E606AF80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1635081749650825977-webhooks-bot@alsa-project.org>
References: <1635081749650825977-webhooks-bot@alsa-project.org>
Subject: Where did snd_pcm_parse_control_id() go?
Message-Id: <20211024132233.C5556F802C8@alsa1.perex.cz>
Date: Sun, 24 Oct 2021 15:22:33 +0200 (CEST)
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

alsa-project/alsa-lib issue #186 was opened from Saur2000:

It seems `snd_pcm_parse_control_id()` was made private in 1.2.5 without any prior deprecation. It is still present in `pcm_external.h`, and our code now fails to link with:

```
ld: src/plugin_control.o: in function `plugin_control_load_user_control':
src/plugin_control.c:254: undefined reference to `snd_pcm_parse_control_id'
```

What are we supposed to use instead?
And why is the function still in the header file if it is not in the library?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/186
Repository URL: https://github.com/alsa-project/alsa-lib
