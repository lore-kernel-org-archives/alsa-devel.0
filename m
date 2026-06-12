Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47995CD98CF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:14:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D76360202;
	Fri, 12 Jun 2026 23:13:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D76360202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781298840;
	bh=581tWOrgO6Ej1DvcqHQqknH9ldkLKMGmTJxzrFiSgGg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QC/mr7gfp8fBOHkvhVbwjT9/JMqpS7nk90rwrAvM2MDk8+rIsXBhGTQVnHzkPV3HK
	 7hiwFIz05qx4uH3QxhOhWuqKdgum1HyAZfaWf4aDnb0GubszLyOeGGnN+Espqz8JzC
	 h7pr7Q6XF4Pi8TWz46C18+j855o9OYscYPXa3DVA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD6F6F80601; Fri, 12 Jun 2026 23:13:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77964F805F3;
	Fri, 12 Jun 2026 23:13:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71415F805D3; Fri, 12 Jun 2026 23:13:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781298800;
	b=K8K43gBF8WgiMCXDNsO1pPIXYSpgwQCtULjmuYvrWKiVTJD8vr3sWboZ6mjIUAz894Pm
	 j82tsjzCVO37AaNqPPmpPX3lovZiwT8cHmCgABERa/xFnKDOJSpo0xJzYx/egaL/3hWwC
	 fbW9YqsklaIwZOCAboJQ3xLsrsStb4Y1QwR1iYRX4LfSuLCyJ1NmkRlBXss+seyd2ytSq
	 1j88+TjS0X3qLt8NRDmaRi/KBPAsELKwMexEvEw4TSmdXq1bd4H7Y3LF5s97IetrMeQbm
	 EgjQzHpD+CHt3FTf1UddXz/RI8qB7c1dKNkfb0unjKepfil73xWRjr3zCylKaL6YqjQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781298800;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=581tWOrgO6Ej1DvcqHQqknH9ldkLKMGmTJxzrFiSgGg=;
	b=qMeq1YI6T9Fti9V+1yHxagWgF1YV3EYcsUbD0Yf/tK/2kMQGtTIX/sSp5vJC3BKQUqyC
	 WM2sBwvVmRvVKPCan7SU6rYEccUFtFTEJGabJ7WbqXtq6I4BAP2Yu5CaI6+fovdNiSHpd
	 mUazCc9SMGapNdMITUXL0rTr013aYKbYs/hSFyKPXmXjXzo7992FU+dl96C+cHl2viwob
	 3SkxOyuWwi9CZ4/Ak1ax0A7BKlKcugz1wrb5DYOcxuZyE/WYeDhbF8UlTCD73+QYirlBd
	 xQ/COyRwa9W4UO7UtrBjRPow+W2mwlKqDQ52Uls+tyEBg7hTCXm16fpxEhdJgB1rVyA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C58BAF805C8
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 23:13:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C58BAF805C8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b871d1f9941100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/787@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/787@alsa-project.org>
Subject: ucm2: Qualcomm: add Lenovo Yoga Slim7x Gen11 support
Date: Fri, 12 Jun 2026 23:13:21 +0200 (CEST)
Message-ID-Hash: 4X6XN5PTE7LUZO4HCV6KJ73ZHBPF3E4Y
X-Message-ID-Hash: 4X6XN5PTE7LUZO4HCV6KJ73ZHBPF3E4Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4X6XN5PTE7LUZO4HCV6KJ73ZHBPF3E4Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #787 was opened from Srinivas-Kandagatla:

Yoga Slim 7x Gen 11 supports:
	- 4 speakers
	- 4 dmics
	- Display ports

This patch adds support to Speaker and DMIC's for now, Display ports are not enabled yet.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/787
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/787.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
