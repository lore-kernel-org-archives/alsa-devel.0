Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADD606A31C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=iLYBDH4K
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 526CA601C6;
	Fri, 27 Nov 2026 09:59:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 526CA601C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795769995;
	bh=KwtxOtrgiFUapr201T9SoXb9Gj+V/f+9kqyn2Yh8XEM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iLYBDH4KgRE0qOCQZ0Q1gaVA0S/E1Nt6CRfyj0idXUSllw4Fq67Xxcqi62Q9Njw2b
	 GFyxd925PfPkK/RHTaHfDodOAWgZYGsjHiE4B70SLLgtobnXWKx51vWw1YVyTJy02n
	 XOZuIyvCl+xr4qpcXcybaf/EXA80IGPeUokx6Nao=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3B16F805F2; Fri, 27 Nov 2026 09:59:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DC0FF805F4;
	Fri, 27 Nov 2026 09:59:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3680BF805A8; Fri, 27 Nov 2026 09:59:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795769954;
	b=Qrga/+d8E5AFPshkD/ElHRk+dm2DRahbAU1FIg/7h9S8ZNeqq2dGnWP7JDtWRQcbA6pZ
	 SMtqoPCZtdRzndLRE6TioUwDpe10/kSmlR9J0hYBROLuWQ8NeT0qzvMetQygfoaD4ppY4
	 BOfttho5KiNTlcll1bIFHy8dMxfbygGUrWFsS8OX6gObGnF+K9YQa2NTGeFHaEQ3dnIv7
	 iGcfNhrPaRoKaVmcvJZK8dWky50Iqz1It/qZ3Mvj5jkaPuG7I4wWFEcfGM+eucoeoq4VN
	 0E+c/rXrAakDmLTRnULs9Z16tckKMD55nvbKeVe6hJClwj+cNq0hPOpxqAJXqyXydLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795769954;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=KwtxOtrgiFUapr201T9SoXb9Gj+V/f+9kqyn2Yh8XEM=;
	b=B2MugAXqmblfhfdUzQD/1x/aav6bEB/WFRXseEL4M5F/Q+jSw5ac8/fTY+Yno6exIidt
	 Ej9mQd66PR2iNqDKiUlsF+qd4vqEjQys+DXIPzgF5FHjcaNW4Q2mRZr/DtJikuWbYPExp
	 FIUBvNa9ntERJlBm1xbZaDZIYFfQmqNolUYVZ54dWrwiA2Sm3rTvN7SaKVS9SCOz+c39t
	 ZT34IHOAOY/TdL/Qnp7hW0jFNVUQQUKhY6XB7wBjzG7pogUJcB+LeTcwvv9OmpvYM6ZoO
	 ebwXSumXDMp/L49QF2t0ytJdxcELhMiS7zb9iovnNRBqMBTsDCIxHU3xBdRy4NTVVxw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 460E8F8024C
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2026 09:59:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 460E8F8024C
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ebdb41eaf9de00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/930@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/930@alsa-project.org>
Subject: Display Port, HeadPhone and VI Codec Support for Glymur T14s Gen7,
 ASUS A16.
Date: Fri, 27 Nov 2026 09:59:15 +0100 (CET)
Message-ID-Hash: GJWP6L7JIPSHLQDHST2S6ZXL2NMHPQXX
X-Message-ID-Hash: GJWP6L7JIPSHLQDHST2S6ZXL2NMHPQXX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GJWP6L7JIPSHLQDHST2S6ZXL2NMHPQXX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #930 was edited from Srinivas-Kandagatla:

This series adds support for Display port and Headset Audio support for T14s, Glymur CRD and A16, I have included https://github.com/alsa-project/alsa-ucm-conf/pull/881 from [lmacken](https://github.com/lmacken) so that its easy to merge the series, tplg related to this are alredy merged.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/930
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/930.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
