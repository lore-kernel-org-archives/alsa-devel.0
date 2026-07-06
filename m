Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B6C43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 04:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 021BA6021A;
	Mon,  6 Jul 2026 06:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 021BA6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783312098;
	bh=EIh9Lr7UiXFgEBDOpyx1m8W/6+SZv++furD/8DV7pdo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=offO4tmxc8N4t3l4nVU7/9YxSrbwdRLkhH7cLjoPwXZPz9ehIccV5s9F5G+f+88Mi
	 CCJm+hlC2USLY1/1h2u82UeGhwOik2uwmD9qcTLK7QYQ6JUorsgNeaqM493GIc72o7
	 g32z8m0bkIrPT+sbxRGju+WOe14QEn9v8saKawyY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B050AF805F9; Mon,  6 Jul 2026 06:27:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 048FFF805EF;
	Mon,  6 Jul 2026 06:27:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F5D4F80524; Mon,  6 Jul 2026 06:27:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783312056;
	b=cYSmCQFZMMpFQ0O4UjxX8ef881pazsWFRX6DnhLY7anoN3ORNs13e8JSuGBRFPjC3vJm
	 uuHZWxDTvvc5pwQ88LCVwwEwpa/xj3E3N2r+j6x9jtRgegc5qHP+iSBGfE5hVzZ1tl4wI
	 YxdnC0CrIP+ztXz9gwc/LYGNZ6XlaTkebOtcyZNQGSdlt+pDXiD2yDyA1LY1/xFHuj8Vb
	 UFi95rMRotCdyHdv3Abn/oX1985G6PCton/Q4QCZ0ya7tzq4vO8Ps+i1DnC6fKE6eyCG2
	 I2XyHImxhnegYdYcDOItRYSD3knKn7u1lvNT/eLdTRhmGcKyrAJOmDho93htCJCdJSA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783312056;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=EIh9Lr7UiXFgEBDOpyx1m8W/6+SZv++furD/8DV7pdo=;
	b=mRezTbuPcKstc5hicUH0SK+gSESJVJfdhnq/9+g99Qfo9R/0Xgmajy3/fzZ1D4rf+utf
	 4PvNQ6U6EGpKLR5IZttxTaD0JDcBfFfTW2q5S1Uiym0zMX/aM8j/ON0GUbDOdNycPhTdO
	 VhN+RLK81vra+dP7a4dVjDChkepzEg4JCj/aac7JtydkBfwk/qF0isI/O6H46FqhDwhz+
	 d/vxjMAN4mh0x4Fmv3r28Uliepb6oC8i1H6iRIAOaKjCPTHyUe/VT8cRLBgUbVqb7F7IR
	 ogwIUyZze0K5T0ITmIvx9qyY/y3fLVzZi6i7NkdMfNZ+EZ/rQqrqG1OkFnujtKLUbfA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E910F8047D
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 06:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E910F8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bf98dd914be300-webhooks-bot@alsa-project.org>
In-Reply-To: <18bf98dd9126d000-webhooks-bot@alsa-project.org>
References: <18bf98dd9126d000-webhooks-bot@alsa-project.org>
Subject: [Feature Request] Support for ESI Maya44 eX PCIe Audio Card
Date: Mon,  6 Jul 2026 06:27:37 +0200 (CEST)
Message-ID-Hash: U6KNAKJWLJJFBO5J6XNU37RS6N6VXP7Z
X-Message-ID-Hash: U6KNAKJWLJJFBO5J6XNU37RS6N6VXP7Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U6KNAKJWLJJFBO5J6XNU37RS6N6VXP7Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #515 was opened from pobanville:

Hello,

I am requesting kernel driver support for the ESI MAYA44 eX PCIe audio card. The hardware is visible on the PCI bus under **device ID 0e51:0003**
but no kernel module claims it.

I have rune the alsa-info.sh diagnostic utility and uploaded the system configuration here : 
https://alsa-project.org/db/?f=86cdf5dce0efc9f35f5dd16c81b21764b899ed3d

I daily drive linux on this machine and mostly a beginner but somewhat comfortable with terminal to test things out. I do hope this card get supported in the future.

Pierre

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/515
Repository URL: https://github.com/alsa-project/alsa-lib
