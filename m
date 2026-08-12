Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EEEC5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:27:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63D24601F2;
	Wed, 12 Aug 2026 18:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63D24601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786552064;
	bh=UxxvbeM3Yl9LL+8FtsTjzOF8RUmNXX26SkrueYlgyO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K7ktc3u9kIpwsH55gTLguYjh0fpvjFJyxiYlVf5bIEzOwdpzYOmAgMUOFvdT+7aok
	 GO7SMtLwGNxINTm6uVFgIVuuU/LEZszoBo7kGZchb3B0qBMwbN4oMSV2vlFIyioJ5j
	 fAK40/wJhUCZgX0ySup973FJjjTg4bJdRSMCp6dk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 224B9F805FA; Wed, 12 Aug 2026 18:27:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4C0AF805FA;
	Wed, 12 Aug 2026 18:27:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FA07F804CF; Wed, 12 Aug 2026 18:27:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786552022;
	b=bj2NA1ZUNi/V3S7oThENCkGrbcf/2uoIHzt8k+tk81CxfOLmOqw5cwNLY1U7rBpttSje
	 cj7oYoWokKuSfnvyRfmypErxhj9O6J58R8XfRVxEusBwzXd4ChE88F58wWCMXXcpQviB4
	 O42ZQ0poaqL1+gc0uFyaMBAc6fvmkZXDQYMAcp6teBOscSJ+mj26mPzhXY+opFwDGhOZF
	 Qhs8ZJ/+1Ewu3hdqV2lsjjpyYc6WlJQZH4hA0cyVpnzMhp48MZMN07/j+amONfSyN3TbV
	 NT2BAZxQdWSik3FcsgHCyW/qMpFNeGqHvdD9WATHkSA5lYUkFugU+mYQUR+uYUH0YYQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786552022;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UxxvbeM3Yl9LL+8FtsTjzOF8RUmNXX26SkrueYlgyO4=;
	b=eVwLi8UKVn5Fh/p8iP+lO5yKkEjOCQrR8CpeFe8+Mv5PHU01uRhopjn5fJT+VhvvvsRb
	 Vi03wdH1ZnKTTEHHJUZDlZuoZB3lwMok4FcpaYusGlqFHPqD+TaC6DX7Z8xSHO0uszGlj
	 yR10gnYbt483AGmPVub8Tk6t0eP7t5yK8GDKSwzHfwG/GRrteIFt+XVFfVusxhqndSM3+
	 rvU1Ny7JhzctswpUx61EvqH0J7Sdg9O9ieOPZ6fG4wT24TgVZUPENGlCVaCDXREu0URcZ
	 t4b/kG97ZdWvP9wdYFoJXmVS9HZ/OLjTT0KCCsXklTcqevDtPNpJ3hCuDpcfCaYqIaQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Lg4WJPE/";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8AA18F8014C
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 18:27:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AA18F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Lg4WJPE/
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A022643E0C;
	Wed, 12 Aug 2026 16:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D401F000E9;
	Wed, 12 Aug 2026 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552018;
	bh=XhlnfOT+3oiZagSBA5VrZ4YFcsrGkXKZxgW/khC16sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lg4WJPE/X+BJHS4GW2WpnlBOk/PLQDojUqzRM0Ethcfws1ZA0JUdNMX03LcaBf76E
	 Wyi7Y7VE2k9fyLyktTLzyE9hD9hiRNS3WnkvXmLgqm5IiVm5Y6l9pg3dlpta0XKesl
	 pAnIA33Zw/zJdq6ugiC6U6xoCTSTQxc6LuP91gAQmDhR+iS+7bbnwENsRWodssT24g
	 HgD+TKO1itfZwCthDdp9D8yqcCjR0JORKjDFt5/6ZHrNMx8kI4gpULRq5CHjdK4zRu
	 NAHW443uJVI2WEdzHWlER8He6tw5BHIKRFwSj2czZBI3z52IPAfC8pf+/3mt86cq/r
	 wthlktBAuDk7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y v2] ALSA: usb-audio: Evaluate packsize caps at the
 right place
Date: Wed, 12 Aug 2026 12:26:44 -0400
Message-ID: <20260812161500.10007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811145740.306-1-pzqqt88198@gmail.com>
References: <20260811145740.306-1-pzqqt88198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZJCIMWIXZMTB3K2BKPTSS5PSF7O6I666
X-Message-ID-Hash: ZJCIMWIXZMTB3K2BKPTSS5PSF7O6I666
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZJCIMWIXZMTB3K2BKPTSS5PSF7O6I666/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Aug 11, 2026 at 10:57:40PM +0800, 王YP wrote:
> [王YP: Move the check to `snd_usb_pcm_prepare()`. For linux-5.10.y,
>        ep->maxframesize is calculated in `snd_usb_pcm_prepare()`.]

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
