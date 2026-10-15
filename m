Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473CACC6B33
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:53:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2FCB60225;
	Thu, 15 Oct 2026 14:53:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2FCB60225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792068803;
	bh=x0UAIyVKTtlngQHRn2dy9YGl5AAArcsVH8wtk8kC48w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gZCv0c9sovVqc5xg2vUTv7iW8s207Px7cVDUxsiSdVNTeOdX9NhB3jqbhKwSmhvwN
	 omXK0j5gsqb0VxwReQT9vIt9lcNAMdb6IpP7LWndIHm5NSBg3lBH4phMQzbE5jas8M
	 YTBmsxjWHmKwL8g7ksjMhouKIN+ZTEWd6q5bQmsI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 720E3F805FA; Thu, 15 Oct 2026 14:52:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDBC8F805F0;
	Thu, 15 Oct 2026 14:52:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC2F4F804CF; Thu, 15 Oct 2026 14:52:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792068763;
	b=S/htX2zIKL/HcwP5OpZpEI1cVjfni5FhGqZ5A6FDKYo9KjLBwtgW+5MJWCaiPGeGbiJ5
	 lWE7GekiZhgtyJRsgfQNvTYZBXz/sQ62JwjBE5y9+2gfgc9vyDAoVmpzKyJ+4RIO+CwtZ
	 iRr/DnVp06wSC03+qpQZ0nqIW1XJ1ppeVUH6zSmP/vLofoN4BPR4nKRmFD5pbjKnIoLg1
	 n6lI495E3+zk+oQYY6qdYajtMUR+qfi5PlpRH/u2rwO32o5h+L534xys80EIDYrn/PPre
	 4Of6+Lm7usue2hWBnrbh+8EOj3m+vkvv9kQT4xa6yTyjP+DvDB80URM1GdT6/YJYvwQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792068763;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=x0UAIyVKTtlngQHRn2dy9YGl5AAArcsVH8wtk8kC48w=;
	b=aje7kU2lN09HlCV6iEXZ/3xsiHNwt57zc6pp3WnokpkXCA2JgpixehO8O647xEsQMe8r
	 Ym5LAWqBpGY3nvG1kp2aM7y1oHDP9/DETXIbmhKZ7NeyuEQZaA9YS7xnMA9Vj6p6wRWM7
	 ryCXP7rLMwYCChr03vx0njsCNrVlPKu/F3BUnwSC0gHRINJkuJ/awrqoxDdVydQVNLzgi
	 LYTDYf5QTGP89+tBTRiKVAWlRgPPC7Aas4gpXXN43/QpcJ8+VzslG3zyxPTVEjyX31PMN
	 H0vC3soegdnMn2gzVp7mbTDQHMyU9TS22C7qSDvOKAmGEeFi8kZvv5WOj7nEwzshF3Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EC993F800FA
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 14:52:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC993F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18deb50b26815f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-plugins/pr/67@alsa-project.org>
References: <alsa-project/alsa-plugins/pr/67@alsa-project.org>
Subject: Fix latency error check in pulse_delay()
Date: Thu, 15 Oct 2026 14:52:43 +0200 (CEST)
Message-ID-Hash: ODQVO25Z2N3DQRXGLH74H2I5AYAU4TBP
X-Message-ID-Hash: ODQVO25Z2N3DQRXGLH74H2I5AYAU4TBP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ODQVO25Z2N3DQRXGLH74H2I5AYAU4TBP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins pull request #67 was reopened from argothiel:

There is an issue with `pulse_delay()` which calls `pa_stream_get_latency()`. PulseAudio documents that this function returns `-PA_ERR_NODATA` when timing information is not available yet. The ALSA Pulse plugin compares the result against positive `PA_ERR_NODATA`; it therefore treats that temporary condition as an unrelated failure and returns `-EIO`.

Change `PA_ERR_NODATA` to `-PA_ERR_NODATA` in the comparison to not miss that branch.

Fixes #65.

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/67
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/67.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
