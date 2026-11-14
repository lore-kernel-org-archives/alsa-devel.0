Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63406606A329
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2026 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=I6phnqSK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FA6A60201;
	Sat, 14 Nov 2026 10:44:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FA6A60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794649487;
	bh=Ujb7lZ0BEGDFI9Ib1zNPgTERTWP9u3j0jcfj6QRYri8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I6phnqSKuvDCEzPXxLdzswsYa7ZyGwtFOblAF0p/sWXLiHqHLMp1gTtYEoJIDa/s6
	 z1VpKCHPRPPmNvU1S3lZVotXFcMoYlfKg5bsuYoAQfcVfZbAW09VDe0hY+ocIsoIAW
	 9FIys7UvjBleFOjJOttQaOE//MNPoPGqjMH5xS70=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F36EF805FB; Sat, 14 Nov 2026 10:44:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02FB9F80601;
	Sat, 14 Nov 2026 10:44:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A35C0F80580; Sat, 14 Nov 2026 10:44:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794649444;
	b=jGru80LqPEFrouFrMfvYEXONcy1+w4rtOlUBZUXzAEcvR4dj8eYF+7m9kzratWUn0k9n
	 WshUi/tQPbOvxDxg90dh3YknLSqQv5c2+tb93XD8MATnVRWWPdHrh+0TEqCiNAzHAIgbI
	 5Vw0p0S/wkxwYUc4UirNRRTqnX3yfpXMBP5Qqf7q12WaW6aaTwyq4d+8rvfkEg6Ggt07J
	 VtzDuofb6ts5/PFtdGoXEF90nyJeQ7TmZw/Hr4i/zrfB4OAnemOcC8okIo5f08GUi2RlC
	 mGtasRAdr3aSXgft3cMwtz1PGjymhvCd2rhxuPdN8s2zyBNX6loa6/tmKVdw1P6UypQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794649444;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Ujb7lZ0BEGDFI9Ib1zNPgTERTWP9u3j0jcfj6QRYri8=;
	b=pvdckpsuMDfK33thmfHXr9Yy5o0bL4ChkKuI35l2n5ONd8GfmTMLgtl0NBxbOVbDFLbD
	 z4WeLoHRG93y0uju5KJ5hZAxY3E1PUxQm8Qe6AHzIKzgIH/L6r1GOfr9k25Nc95iGTPuf
	 6fmTZHCA1IEFbbDWCfpfA8AhL2SLVT0glNL7yYQQW8nZeCqGck7jeZFboBejtB/uTeM7M
	 JjmeooCl/4wXtKXEzY7m1gPcgvHcM6enIjTyVPudgrEY2D9ZCU/CdAI23Y3f+I55/ilFe
	 93PdB/Ti8tg9FuoZkvR5rYNFja2txkGuxo4a59Xl2kV+sufeV9McW5AskjpK2tEgpoA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 89BE5F80100
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2026 10:44:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89BE5F80100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7e028df04e700-webhooks-bot@alsa-project.org>
In-Reply-To: <18e7e028def70b00-webhooks-bot@alsa-project.org>
References: <18e7e028def70b00-webhooks-bot@alsa-project.org>
Subject: Unfullfilled dependencie
Date: Sat, 14 Nov 2026 10:44:05 +0100 (CET)
Message-ID-Hash: XLFU4JIWOJEZZR74NGVICGAASWMAYF5W
X-Message-ID-Hash: XLFU4JIWOJEZZR74NGVICGAASWMAYF5W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XLFU4JIWOJEZZR74NGVICGAASWMAYF5W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf issue #911 was opened from brandtan:

I download the atom rpm for my Fedora x86 and tried to install it using GNOME Software Center but error:

Failed to resolve transaction: 
Problem: conflicting requests
  - nothing provides lsb-core-noarch needed by atom-1.60.0-0.1.x86_64 from @commandline

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/911
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
