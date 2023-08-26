Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B65EC83F01
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Aug 2023 11:33:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E17C84A;
	Sat, 26 Aug 2023 13:32:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E17C84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693049595;
	bh=Glx+CvhqRB42VyB+7AeWxbMoe0DL1EGwsOqC+RbBUBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EotSFCXBJNDJ9bUvOypA2dz0h/V5VoCVJfvaQoXpKYxEgU9IgDMix411xoUTz2Nec
	 GsH/NXOMdv1C09RCibMkPr1XHuopJjyF4facFiFbuKcM6HkGECjnwwoTgOgTiGcMAp
	 WYT/8MgsddNFkUcjJ8U+eBiGqWiofv5zN+u2xdow=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 203A9F80536; Sat, 26 Aug 2023 13:31:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B79B4F8025F;
	Sat, 26 Aug 2023 13:31:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1AEFEF80158; Sat, 26 Aug 2023 13:31:51 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3D13F800BF
	for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2023 13:31:48 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1295511F6;
	Sat, 26 Aug 2023 13:31:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1295511F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1693049508; bh=P89WtP3+RwdW5O2CN2q4KTEQBrMo/5f06O0Jfep8kYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V1NBjGC+HL43zkLcDvnMaU3ei6YrFpsDp6tfHfVI8dgvwwNPZBJ+k7VXhugHMSYlw
	 dRZU+DbrqLY0sx2RuBhp5du8dGdiRbu1+Vy/l8u23xV256zMsljuQgj3x6Zp2UMvl1
	 hRRuAu0nKbUpysWBVE3RTHT5DSVDIREp4ZsZbXww=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sat, 26 Aug 2023 13:31:44 +0200 (CEST)
Message-ID: <73a6f02e-0df7-243a-85ac-48ca5a650cba@perex.cz>
Date: Sat, 26 Aug 2023 13:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ucm: docs: Add IVEchoData
Content-Language: en-US
To: cujomalainey@chromium.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.com, ethan.geller@gmail.com
References: <20230824213312.1258499-1-cujomalainey@chromium.org>
 <20230824213312.1258499-2-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230824213312.1258499-2-cujomalainey@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: TZMONIIGKRXQUBGW5SQARYSSEDAVFGMM
X-Message-ID-Hash: TZMONIIGKRXQUBGW5SQARYSSEDAVFGMM
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TZMONIIGKRXQUBGW5SQARYSSEDAVFGMM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 24. 08. 23 23:33, cujomalainey@chromium.org wrote:
> From: Curtis Malainey <cujomalainey@chromium.org>
> 
> Provide a UCM value to mark devices which are needed to be opened only
> for HW purposes but should not be consumed for userspace.

It would be probably better to describe this in the standard ALSA PCM API than 
UCM. If the device is special, applications without UCM should be also allowed 
to identify them.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

