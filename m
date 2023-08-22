Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70174EE4996
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Aug 2023 15:04:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB97C827;
	Tue, 22 Aug 2023 17:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB97C827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692716653;
	bh=r8DOp2zP2dg8hhV0RAU5rx+GCyUhEkolBaRpChsgAj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FuePDPyuGRsTxwO8SP6jJG4HKO9W81B4thLpjRVyKIcDv5T0iq4dP2neBqvmzEbvT
	 sF5Vk2M46CBN+XoCMAg4VXfyvEESylHizqoSqUat7kMxSZYTsNoveuoUV1qigC8nLh
	 RmTOffFutPoKUfcWCvHY2LIgBxoAv5jhcIrq4KDI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 696B2F80552; Tue, 22 Aug 2023 17:03:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00D3DF800BF;
	Tue, 22 Aug 2023 17:03:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B574F80158; Tue, 22 Aug 2023 17:03:18 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB048F800BF
	for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2023 17:03:11 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 19BFF11F1;
	Tue, 22 Aug 2023 17:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 19BFF11F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1692716590; bh=gcQdTWmQbCuwso98KFWCyqR2s+0746yuVsLWGIffJAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2iClrVceiP70gY6rGpLP6p/P5cyND7F3OqVDdTJLcqnuYrSeKJx/lkQUiZKoO4XQ8
	 VxwLFn2ILzlWlZfHqHt59YOp8tA+64rw9xxrXUc0E7DdU/qPL3qMhOgpnvXNgKAntP
	 UdzSfC6ePCint0nASwGr344jwuuG/W0u2IXSWhrc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue, 22 Aug 2023 17:03:03 +0200 (CEST)
Message-ID: <43b25b8b-3e28-bd91-a29a-846a5aa7579e@perex.cz>
Date: Tue, 22 Aug 2023 17:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 01/17] ALSA: pcm: Introduce MSBITS subformat interface
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org,
 tiwai@suse.com
Cc: alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com
References: <20230811164853.1797547-1-cezary.rojewski@intel.com>
 <20230811164853.1797547-2-cezary.rojewski@intel.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230811164853.1797547-2-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: PHIJK7D7WBKLG4IXOGCQNOW2BZS7HHMI
X-Message-ID-Hash: PHIJK7D7WBKLG4IXOGCQNOW2BZS7HHMI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PHIJK7D7WBKLG4IXOGCQNOW2BZS7HHMI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 11. 08. 23 18:48, Cezary Rojewski wrote:

> +#define SNDRV_PCM_SUBFMTBIT_MSBITS_32	_SNDRV_PCM_SUBFMTBIT(MSBITS_32)

What was reason to add 32/32 format ? Subformat STD + msbits == 32 should 
already handle the maximal resolution. Until we do not have 64 bit formats, it 
seems like an useless extension.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

