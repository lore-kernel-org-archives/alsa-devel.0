Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE360C54ED1
	for <alsa-devel@archiver.kernel.org>; Sat, 24 May 2025 01:30:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 516BA601E5;
	Sat, 24 May 2025 03:30:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 516BA601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748050248;
	bh=sCSwnpkTY7FdvP3cwIBYR0j75kTI00Ttzr+6qqpxaQ0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f0BS/VCkVltFTRKN4nbyHq0zlLcLgNJgXkSIb0RzuqJ01UVy7qBBErR2hNhjbrWrz
	 GBKD0an4Jbx4ixnyPA7RqzOEJgqfYji4USuTybZXXttaIQD2s7mpmeaggJdTTXVU7e
	 LUIuPjVTC1J4tndgY4vdHWKXIbDWXJpbUriwzmi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3288AF805C5; Sat, 24 May 2025 03:30:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E72C0F805B5;
	Sat, 24 May 2025 03:30:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0641F8026D; Sat, 24 May 2025 03:30:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B503F80246
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2025 03:30:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B503F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18425265c7c8fd00-webhooks-bot@alsa-project.org>
In-Reply-To: <18425265c7935500-webhooks-bot@alsa-project.org>
References: <18425265c7935500-webhooks-bot@alsa-project.org>
Subject: ALSA UCM error (ssl2)
Date: Sat, 24 May 2025 03:30:04 +0200 (CEST)
Message-ID-Hash: HA2DCOFJG4XA2ZHBBRIK4WYNU5ARZ375
X-Message-ID-Hash: HA2DCOFJG4XA2ZHBBRIK4WYNU5ARZ375
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HA2DCOFJG4XA2ZHBBRIK4WYNU5ARZ375/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #565 was opened from dddobriak:

Hi,
I had to change my config to avoid the following error:
```
If.ssl2 {
    Condition {
        Type SubStr
        Haystack "${CardComponents}"
        Needle "USB31e9:0001"
    }
    True.Define {
        ProfileName "SolidStateLabs/SSL2"
    }
}
```
I replaced Type String with Type SubStr, and everything worked fine until the next update.
Could you please fix this?

Thanks!

[alsa-info.txt](https://github.com/user-attachments/files/20420260/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/565
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
