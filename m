Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603AEC53219
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:42:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA318601FD;
	Tue, 28 Jul 2026 14:42:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA318601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785242565;
	bh=9Ne1gNGoIQf3TI1dgHQ16RfoOLAunxRr9B37JCsMS1M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DsYyFCK9IUbopdu93B5ioaZinAlJK8WNictnnphlsiFJFgtuVLbzKNqpET5YMp/kQ
	 QK/ynCIdKfNMS9MFDtkSt+sdIqoNwHgJtSV9dtMQGZHaCJC6C1OkprwE2TabEEevXD
	 OExawXW0bi/7dzEyHDhxFQZKDVGG4SyzSXB1YEYw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8A36F805FE; Tue, 28 Jul 2026 14:42:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DAD0F80600;
	Tue, 28 Jul 2026 14:42:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF6B0F80526; Tue, 28 Jul 2026 14:42:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785242525;
	b=oj/6P9468ZL8DM8yMspQ68ZhEb5EShIYcj7vJ5m5TJKXTa/ypmdI11eEMozqPbhGG+kL
	 fd1UQmrRH7jbPjM3jdWz7oII9/yAUAHukCz/tfH3PYybCIsbeY1UzfWCprHHC72ScyjPr
	 U23qZw5plZ8xljxGEJcrhfaaeO2I0q4RKKoNB1RRVFqYdT78Ftox6pYS0T7mgWE0O+YzH
	 DNQ+fbQB5L930HCgw11/SYJbXpJfLZ2b9cjkH//gdM1NHtjjBisLbTKhe4mgJRoeLVn0v
	 sL/vtQm+qUEjIzM+HZXaaQrZWLzbbLtv0nU7up9l1IifTWF8piMEZkaaCZ/DlZgL6TQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785242525;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=9Ne1gNGoIQf3TI1dgHQ16RfoOLAunxRr9B37JCsMS1M=;
	b=Vj5uzF8r/mhzT3jBf3iCvFuEclF9XU9Xv9dmS6z3J3xYae4l8Tf1uF4/xuaJJZ6IHBQJ
	 wOy6qYOguvMiz013J9UI6bgrV354vM0YdYtes4nkTXBPtmQ2BFgGmeKj8dUFNulj71xzX
	 UOEoa4baSjr6HUkFbwo1iM1NQk8ags6Ph0mNBf1XNlX/aDugBCoNXHRw4eUMgZrSzKVHb
	 PCt8Sw4q53zogRaN9h8WBbd00QQDBXF8NGngqm5nQigiRnRILOgczaRO7EvXkXHsgEjB8
	 qPndgaK2fACv8Yl5kDvhA7NX8IGw/kPV4r3CwII1JlO+PvTFzqd/7X0qWAxtz+PM/6Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 855B1F801F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 14:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 855B1F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c6749df8613d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/820@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/820@alsa-project.org>
Subject: ucm2: Qualcomm: Add Acer Swift 14 AI (SF14-11) support
Date: Tue, 28 Jul 2026 14:42:05 +0200 (CEST)
Message-ID-Hash: 4IIIZ74C33EIXKIHN5DSEA6LG7JMIYOT
X-Message-ID-Hash: 4IIIZ74C33EIXKIHN5DSEA6LG7JMIYOT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4IIIZ74C33EIXKIHN5DSEA6LG7JMIYOT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #820 was opened from victorien-a:

The Acer Swift 14 AI (SF14-11) is a Snapdragon X1P-64100 laptop whose audio hardware matches the Lenovo Thinkpad T14s: two SoundWire WSA speakers, a wcd938x headset codec and VA DMICs. Reuse the T14s configuration.

Note the machine reports board_vendor "SX1" rather than "Acer", giving a DMI id of "SX1-Swift 14 AI-Bluetang_SX1".

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/820
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/820.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
