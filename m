Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835ECCD6E6B
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 03:06:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF60B6025F;
	Fri,  5 Jun 2026 05:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF60B6025F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780628765;
	bh=JrTTpnVGPsQ/hHDAEGiFWV7kn979VwuZy0qBqltJJM8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Qy6Ukb9rdCcK4nREjl0ISR5J2dNAbIRuSiyxU8beXYPeIkmH/S+IxlsRBSceaeG04
	 2c2VBEg9aPGxEiesk7s2aUwOPv35I7Lb4p5U/IOMDBma1P6Oa0c98RQFUU8ZU2r2pe
	 LW2quO1cT+4TvbhvjCybfZ65t8bFtSf5/qc2oYhw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A6F9F805FE; Fri,  5 Jun 2026 05:05:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4F2CF805C1;
	Fri,  5 Jun 2026 05:05:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C187CF8047D; Fri,  5 Jun 2026 05:05:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780628722;
	b=g7CJ0qku4RNjKZctpAvnMA7f2ibOFLA0YDlRhTMeo5JhVJgRC7P4d/jjfbX3NRe9voDH
	 D0O+qY/ODxyWP6NnPCUx0lvPFUSmWM1Hhl76c00U76Gqn/DvedyIBWLYbZ5Mo5pVxJMQi
	 5RcqzyyH7JUIJc4j+UCqJOj4Hm6ntcNN7ERiQ+pz5dXFWPKIQz6EZxJ3DhLKEWJOhFKg2
	 73i7kzOoudLwssE2yF7dPmTqtR5rBkK0s4HNdFk+HAS6VcKCALhMCoJiVI75NSJuU/QEX
	 TTFgwT798sQXz2sENiXoTJIfzga+ZTplWodTDaR2KfRLrfi9Rt4pp7QELE6zkwqkPsA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780628722;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=JrTTpnVGPsQ/hHDAEGiFWV7kn979VwuZy0qBqltJJM8=;
	b=SzGBzNsBB25sKmb5fLF/shUlfRC4B7vRElAsUV87yH5hguhowz1cnoIyB6ni49cql++s
	 Y9gAqAsGUnDF3z+vYxlAxfDIMdbx1WeIWP8m6TcymzJHhCArghPxQs2+MRmuOHJsY2ec1
	 ii9CJjYTYiVjDCFQfikZh8M/AhYkJ8r00tgLV7FhP1ha9vCkWOKxMdaifRCO72agHbHEX
	 /N9qQNhenTrgY6KVrkoP5vwfQzgfWJ2jn+7PXz9n2PB7CQDEFggR0U284tQm00n6K1zWb
	 ydNXwhAFGp9eiW5Aoi28EaUbYD7uBQnbB1whhbMlLs4Lwg89F3S/FWlBQZwlnJGqQ7A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1813BF800D0
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 05:05:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1813BF800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b6106320458c00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b61063201a0f00-webhooks-bot@alsa-project.org>
References: <18b61063201a0f00-webhooks-bot@alsa-project.org>
Subject: ucm2/HDA/HiFi-mic.conf: hardcoded "Mic Jack" breaks mic capture on
 HDA devices without that control
Date: Fri,  5 Jun 2026 05:05:22 +0200 (CEST)
Message-ID-Hash: UL4APBQN3KQIB27UNSZWGJK5VTAWYZRE
X-Message-ID-Hash: UL4APBQN3KQIB27UNSZWGJK5VTAWYZRE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UL4APBQN3KQIB27UNSZWGJK5VTAWYZRE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #777 was opened from qaqland:

On Acer S40-54, there is no "Input Source" enum control, so `If.micsetup` falls through to the `True` branch. However, the actual jack detection control is `Headset Mic Jack` not `Mic Jack`. As a result, the microphone is registered with no valid JackControl.

I applied this [change](https://github.com/deepin-community/alsa-ucm-conf/pull/9) on deepin and it works correctly on this Acer S40-54. But I'm not sure if this change is correct, and don't have other HDA devices to verify.

To avoid interference from the distribution, I confirm the above issue with the Fedora live system and generated alsa-info.

[alsa-info.txt](https://github.com/user-attachments/files/28621633/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/777
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
