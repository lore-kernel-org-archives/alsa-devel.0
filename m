Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444C9EE57DB
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2024 22:41:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D953F868;
	Thu, 12 Sep 2024 00:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D953F868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726094473;
	bh=/xiImiOfAuxbq92nARxzw1Fr4T89VVu8vEx0VLUJu6A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=p0kACF0DZ5QIcHA70TYVJmZkXNb1QI/Rymz+Ea1+dHio262j0lpcx+3QXV0D8zj5J
	 JOw4bhY4MH6/YW6POclCgflBsnp8uQzsRzBH4hLMt7nT6ygxVUS5/+Yv8Hr+fA4Ck7
	 MyKk5TeJZ+Lfie8Kcm9OJsbEEvnmJY3k209Ve9Jw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E693F805BD; Thu, 12 Sep 2024 00:40:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F37A1F805B5;
	Thu, 12 Sep 2024 00:40:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C942F801F5; Thu, 12 Sep 2024 00:40:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D7CAF80027
	for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2024 00:40:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D7CAF80027
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1726094434925732613-webhooks-bot@alsa-project.org>
References: <1726094434925732613-webhooks-bot@alsa-project.org>
Subject: Mic mute LED only follows internal rather than selected
Message-Id: <20240911224037.5C942F801F5@alsa1.perex.cz>
Date: Thu, 12 Sep 2024 00:40:37 +0200 (CEST)
Message-ID-Hash: RRAPUZO3RBT4XPCOCVQMGSIHDTB3CXCR
X-Message-ID-Hash: RRAPUZO3RBT4XPCOCVQMGSIHDTB3CXCR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RRAPUZO3RBT4XPCOCVQMGSIHDTB3CXCR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #440 was opened from JL2210:

I have a laptop keyboard with a key to mute the microphone. Using this key mutes whichever mic is selected as default. However, the light on the key only changes with the internal microphone rather than the active mic.

Pressing the key when a headset is plugged in doesn't change the LED, but pressing it without a headset does.

[alsa-info.txt](https://github.com/user-attachments/files/16971038/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/440
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
