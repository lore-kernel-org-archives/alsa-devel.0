Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCBDCD6E74
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:49:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4978960273;
	Fri,  5 Jun 2026 11:49:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4978960273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780652981;
	bh=RY7gURA/gDGK+NHLWGKZQpvt8Z0OWj64skWGBUhLXxc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ISivP14XHbfk72IsX7OX11isKOJ0GcTi1h35s4m/RxdTjHYIysQCLSCXRROpUQfCQ
	 S8vUDDeblLo2JWbpaeU6vyeDgXAT8ucIcg22kpl16PTVnA76sC/yODFPFXZlM5OcGR
	 HfABlngUx7SD5UUUKwQv0/SAIUF1y3ximex/TFp8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C897F80614; Fri,  5 Jun 2026 11:49:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B5E1F80609;
	Fri,  5 Jun 2026 11:49:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 474F6F80602; Fri,  5 Jun 2026 11:49:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780652941;
	b=MkooAOKUdT4bGUdswJ/dGehr1xJW7lM8zv8u4Lan9FniSPyKtkYttDnVYoW9zOhxScWF
	 mf5eV+MZRFlkbcMwk+KLyb6+QHrKy9I+T84J9ofijNJ4JhoT6HtMwPDNXRETfIy2wbG24
	 exwiMMbEhbOnWLP7Hto1KSrM2VVHlNdnHiksYMXpqeja5Y9yyYj/xPgsDwejXfCD7uhDm
	 YDNm451bTYrmuRfFvtRDrW+iMgn0sL8ZEMjamdG6KpdOOa6E1EPW5jExTPGtePYrSIy40
	 Gxy8YTrOOuGSCVK3CGnEt4C3Rvz3NgqAPKRBQfdtjn+QNpoJPuaMLf52XcDcOQZQ+Lw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780652941;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=RY7gURA/gDGK+NHLWGKZQpvt8Z0OWj64skWGBUhLXxc=;
	b=ryt3l0QXCoanqManBOTtGpAnDDawou7rxlaO2BYSgQL1B3brzW+5uBJbBqfKM1x3MbYo
	 j88d/WIS+5R8wgraXABONbfjgE4FDCF/B/9xYw+9uen9rSFRYVjtU91WWb2Mh54ZChBKS
	 7jwxFz83LhR51kizRoVH49T+z33SL48WpC6YUpcdLWyHqAX9oaDdu/wCugRR93foVzWcE
	 ZE5Rb7VbbBv0tegYu7T+zh5JtuBC2Wqrp8gp4hqp1x9j9tk7z9vGZynSOXh/wJ14iHszu
	 35zg+PonB5JzTM3jiS6ajqnQqbHKy6hwEZ0uDQDpvmppjfTZC8MggNWgrymah3PEdBw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B24E3F805F3
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 11:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B24E3F805F3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b6266a4950f000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
Subject: sof-soundwire: cleanups for codecs with multiple functions
Date: Fri,  5 Jun 2026 11:49:02 +0200 (CEST)
Message-ID-Hash: H6A77STJHY52FV5R4PO3ME5Q73EUPWPT
X-Message-ID-Hash: H6A77STJHY52FV5R4PO3ME5Q73EUPWPT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H6A77STJHY52FV5R4PO3ME5Q73EUPWPT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #775 was edited from perexg:

The load mechanism assumed only one multi-codec in the system, but
    we saw in #774 multiple instances of those codecs (rt1320 and rt713).
    
    Make the load mechanism straight:
    
    - introduce file variables
    - remove shadow variables
    - probe multi-codecs separately and modify the file variables
    - test for duplicate file inclusion (in both sof-soundwire / HiFi configs)
    - merge dmic configs for rt712,rt713 to one file
    
    This change also removes filters for speaker/headset/mic init includes.
    The file variables + multi-codec probe replaces this functionality and
    if the driver reports an "unknown" codec, UCM config should be updated anyway.


Link: https://github.com/alsa-project/alsa-ucm-conf/issues/774

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/775
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/775.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
