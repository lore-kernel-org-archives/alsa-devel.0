Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E0ECA9EC5
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:19:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87362601FF;
	Mon, 12 Oct 2026 23:19:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87362601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791839963;
	bh=se2qX4ni0llEKDqiWkQz5ou5fYzAZaRL3YlEo36mDlk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kqDLW3idj+0vk7OUs4jofzupgwbK0cVnjhnqZ40JUGOgQzUVVNJ7jRYI47Vg+omda
	 JJkG5uCdatdLoRaM2PF6rnDAaz9Rn8CShCjBAROXxm5HLLVov7UCrh7bk1h4fxURw6
	 XMiDJKh90ZJOLZivbsuEbAVsihpFxtzW3/TVFE4w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FF31F80601; Mon, 12 Oct 2026 23:18:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B349F805F1;
	Mon, 12 Oct 2026 23:18:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB303F80526; Mon, 12 Oct 2026 23:18:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791839923;
	b=d6teUG649YNtsvFVXkEnCwVuT+cMHDZJNkdO1/cZ/Z0bByuwpLix0AHQJpvtAjIJjan6
	 VTQpnUklXptQzls0sqyZ1PVA4lZ3OOCKuF/xdy6zRyXf+FHZtGXIW5PfGyM/aiOqcnCvT
	 rcpFqOOj73A/3+GuCxi/ceRAXnrx0Bq4wPc7Cg+wZngAjkBIhcwOaFwsbqHfT3w1uSBVl
	 enZP7gg9EiO9DC+TqyDiboPvbL6PolmoYuHVhdyqi9+VQ1IGS2buHwTsxrySxY1GYy0Wy
	 g0ud3IfM7XgPQ1pBgkJTcUuId0xjLzuZoO0krLCIJPvjpq7yq+g7RB/3PQvOfTH9ojQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791839923;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=se2qX4ni0llEKDqiWkQz5ou5fYzAZaRL3YlEo36mDlk=;
	b=Jo6KoURreGgMSKG6rAxmFHXQGD97zNY4PxcJAf4voN0wqsJGWe0QBVwKObPV/LCeqxB8
	 FhqYtzYJbtkKhLxkKZymmVxLIJZ+dA5+6NKhSPMlHSMzSahfQIREtKmo6CnW+yOot8kdF
	 bnrDR8pX1R6nJd7DnBZwOytYgd2KvcX7gXfQWeOohncwXSpiNcTv/0C4aD3cWjpjj1Bvw
	 QIb3rHgZFgiS3NozUqvHR+BJnbZNjL4ehhrehG74AJeI26oA2bSFvEy+FrQ0GHfoUOrop
	 8OpTxYD9sU0Q0w2B0YY5gTPnXnJSbG8ENV3JwwIt2MT2l0bJGJfhr5hpCZI2ZZj2PzA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 30123F80424
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 23:18:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30123F80424
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dde4ea4da93900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/877@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/877@alsa-project.org>
Subject: HDA: Handle better Bass speaker including 4 channel mode
Date: Mon, 12 Oct 2026 23:18:43 +0200 (CEST)
Message-ID-Hash: 2JMIA6YJQ5PDDHWMJ5AYNUOTDSG6RTW6
X-Message-ID-Hash: 2JMIA6YJQ5PDDHWMJ5AYNUOTDSG6RTW6
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2JMIA6YJQ5PDDHWMJ5AYNUOTDSG6RTW6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #877 was opened from CSVincentS:

Follow up to  #533.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/877
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/877.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
