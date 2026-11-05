Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880E606A909
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=k5VnV1Ol
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85184601D9;
	Thu,  5 Nov 2026 12:51:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85184601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793879529;
	bh=waODVkYHPEGWaB7uWUDkBvWiSLK8q+SQsF6hurA18YY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=k5VnV1OlAxzVZAWGuytFUITJtc5ZPisa2gYlmU902xKWicBoVo91FueFNeZxrca80
	 bYhsFap1A/BOI/KXz5SHyKJ6Bx9rBf7YblRzAYwzAfb2YtZQH3x/Jwy7dOsFHEp8Zz
	 mab9YBC/IUDq7o7+3N39qBaQutgW2lYi3Zk2YmfE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A70E0F805FE; Thu,  5 Nov 2026 12:51:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DCB4AF805F6;
	Thu,  5 Nov 2026 12:51:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADBA6F804FF; Thu,  5 Nov 2026 12:51:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793879486;
	b=Wam0RPCglKcvBkITwJhLyh9vrRfWd1txmErsFJhwwQVIEAIqKfAQ+DQHeo5PiwUyBy0q
	 qo9L+TuKcjrKj6s0BM5SgUwVE6gTpDGrq7opVKVZk/+XyAaphbZcSN40uc7/s6nyKE99U
	 L9m7424Dyo6msjiNfQv3QRbZ+JqJlgUoeRDn9equ9avu1xEAikIeTN50XaE1PlJcDZxo+
	 MfqNN7aCrgc5o2V0y0CxCVgvHfp5VFBJfThmJIfsWRoJtCd0YcKC9fCsoxa7a4XTaohaa
	 zH23GDya23eJnRbnxQSwX2D2PRLJE/ax634dVjeW/tgLiBGSz6+TxB6us4JuhzmYv3g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793879486;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=waODVkYHPEGWaB7uWUDkBvWiSLK8q+SQsF6hurA18YY=;
	b=W3r+XfV2U+Kaxo3PXwZ1t4/3dGvZDdNBkhSPGKUHiaf/4jojfO8Dhezyn2MXZ6MaIFjw
	 DygRInZiCdPZDNTX6yoyIm/PrC3sbA2xI2Z0hKuMdlakzXqkp2uhzloKLiTnLTgTYDz3s
	 MAZ5rFCR0OTj9p+yObparZgMknPdr7+2kjpxRbJYH95mJg9SZE0D9V9R4ZGvPOz0I7Pk8
	 O8nG9MdnbRypLd2XaG9Ld8cI3ZbZ8NMEmW7ZlFZwIe0DUFfWLGTQvFkySShCk5ua7SzHi
	 Xj5fVMr7hXDgH7XGCgq/OGjEBxK03tjmuut/cbeGeGYkQRKkDvvZz45QsHc2uhWl1gg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A7636F802DB
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 12:51:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7636F802DB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e523e326915d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/904@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/904@alsa-project.org>
Subject: Add LED support for tas2783
Date: Thu,  5 Nov 2026 12:51:27 +0100 (CET)
Message-ID-Hash: DBS2NW3BOEHM3P3CZJ26DE4P7247VOQL
X-Message-ID-Hash: DBS2NW3BOEHM3P3CZJ26DE4P7247VOQL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBS2NW3BOEHM3P3CZJ26DE4P7247VOQL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #904 was opened from jimxbj-dot:

Speaker mute LED support.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/904
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/904.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
