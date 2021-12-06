Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5D6C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Dec 2021 14:06:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C82AA2050;
	Mon,  6 Dec 2021 15:05:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C82AA2050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638799583;
	bh=jjxnA2TdBkzHMNYB8jDamIZDPK8KiMuqVqwKNudlPRA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O7EuoR992eXXvx6rcz0k1mUNrpGKIdtunduHUoq3Sy7Q30LLSOVkOs0RXUaTokxvs
	 /nBogCbr6lenIzsROGBm30SyvzMTyScknXDXJ4B8wBvdwZsoFi0UFVFYkJXJPqn5Ea
	 YWGu+2zt21mCyQA+bZ6UySdZVgBykRXv7cAhAHfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71640F804F1;
	Mon,  6 Dec 2021 15:05:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CB17F804F2; Mon,  6 Dec 2021 15:05:24 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2A8F1F804E5
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 15:05:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A8F1F804E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1638799510739136934-webhooks-bot@alsa-project.org>
References: <1638799510739136934-webhooks-bot@alsa-project.org>
Subject: GIT Project URLS
Message-Id: <20211206140524.7CB17F804F2@alsa1.perex.cz>
Date: Mon,  6 Dec 2021 15:05:24 +0100 (CET)
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

alsa-project/alsa-lib issue #196 was opened from h1z1:

Hi

Not really sure where to report this, are the URLS listed on alsa-project.org accurate?   They include GIT and  HTTP, not HTTPS and are not correct regardless.

ex

```
Web interface

          http://git.alsa-project.org/?p=alsa-driver.git
```

Results in what I"m assuming is a 404

```
$ git clone https://git.alsa-project.org/?p=alsa-driver.git alsa-driver.git
Cloning into 'alsa-driver.git'...
fatal: repository 'https://git.alsa-project.org/?p=alsa-driver.git/' not found
```

Should those URLs be accessilble via HTTPS?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/196
Repository URL: https://github.com/alsa-project/alsa-lib
