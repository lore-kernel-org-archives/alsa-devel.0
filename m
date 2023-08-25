Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B0C7EE2C
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Aug 2023 21:58:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E213083B;
	Fri, 25 Aug 2023 23:57:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E213083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693000689;
	bh=nywwSi4JCfTe6/Na+Lb56v+TrIH4XSaDTdinszc8DeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BF5b5HqSCkH1o6qbJymcjPNsEr91BH1psXBd1J4LgeCBYcLrDwBxHPC48PQqfRIHb
	 xXCWN9k2EkbPM4LWCYgVFhh6c5Toq2qlMYk0ozLIyxVNC6j+53YgknJZC10Pr/1WPU
	 2ofA21Z8mOQ1vxHouUg57AUUDJ/U4FsVAo+hglVI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D562FF800F5; Fri, 25 Aug 2023 23:56:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77FE4F800F5;
	Fri, 25 Aug 2023 23:56:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7B31F800F5; Fri, 25 Aug 2023 23:56:46 +0200 (CEST)
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0EDAAF80074
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 23:56:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EDAAF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=mutex.one header.i=@mutex.one header.a=rsa-sha256
 header.s=default header.b=db/iGm/P
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mutex.one (Postfix) with ESMTP id DD82D16C0048;
	Sat, 26 Aug 2023 00:56:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
	by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfqredlHnEla; Sat, 26 Aug 2023 00:56:40 +0300 (EEST)
From: Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
	t=1693000600; bh=nywwSi4JCfTe6/Na+Lb56v+TrIH4XSaDTdinszc8DeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=db/iGm/PMySZnG5VWcyl/xJe5FF1ny2cihx61eDr//1cHmd679bwrejUy9TZPVi5K
	 QmoLPAmxNDwyX7gt9G+40qqq7UHT8WetGRzpt55xyhT5dDV8OiXTDgMj6lNTkoM3Vr
	 Tnk5eBkYwWPxb5sWyjdhuNbCBBIIxRrYIvdbDWcY=
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
In-Reply-To: <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
 <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
Date: Sat, 26 Aug 2023 00:55:21 +0300
Message-ID: <87y1hypz1y.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID-Hash: SPDJGHMXLJOUIHYTNXENHULGYSDI2B42
X-Message-ID-Hash: SPDJGHMXLJOUIHYTNXENHULGYSDI2B42
X-MailFrom: posteuca@mutex.one
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SPDJGHMXLJOUIHYTNXENHULGYSDI2B42/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Mark Brown <broonie@kernel.org> writes:

>> To properly support a line of Huawei laptops with AMD CPU and a
>> ES8336 codec connected to the ACP3X module we need to enable
>> the S32 LE format.
>
> What's the issue?  The AMD code looks like it supports plenty of other
> formats in most places.

In previous version of the machine driver I used a different CPU
component than acp-i2s-sp. For that one, I couldn't get it to have
sound unless I specifically requested S32 LE format.

I removed S32_LE from the CODEC to test if it works and it
seems it does work with acp-is2-sp. Format S16_LE is chosen by
both components and sound can be heard. I guess this patch is
not really needed.
