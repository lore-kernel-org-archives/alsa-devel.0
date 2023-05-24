Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8528CC77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 16:48:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCBC63E7;
	Wed, 24 May 2023 18:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCBC63E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684946892;
	bh=8v9nXhIARW7mgGIWAvaJS96doEoDifx1SUT8CATEbsM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pm5mjHCbFHQ9+sNHHLqYmC4KZvUh7Sg0A9ZPpQWV4MBcOp34Ct8dcuFavAquUr/mA
	 TWYVcaPWe6KSQboA6wmjKxFTTtxsjnXG44Xq/2GLVI8pI+/SFhAhcwd/gVwLWbLMmw
	 rpnuoLxO/NnfGWZCJh+RVx9+p6qJCnIluM1jasS0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D06D4F80548; Wed, 24 May 2023 18:47:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5146CF8024E;
	Wed, 24 May 2023 18:47:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3ECFEF8024E; Wed, 24 May 2023 18:46:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4728EF80086
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 18:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4728EF80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1684946814602925539-webhooks-bot@alsa-project.org>
References: <1684946814602925539-webhooks-bot@alsa-project.org>
Subject: topology: pre-processor: Add support for object arrays
Message-Id: <20230524164657.3ECFEF8024E@alsa1.perex.cz>
Date: Wed, 24 May 2023 18:46:57 +0200 (CEST)
Message-ID-Hash: Z5IB4AW6V3XPY5QKT6XV24JHNIDUW4VZ
X-Message-ID-Hash: Z5IB4AW6V3XPY5QKT6XV24JHNIDUW4VZ
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z5IB4AW6V3XPY5QKT6XV24JHNIDUW4VZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #216 was edited from ranj063:

Introduce a new keyword, "ObjectArray" to instantiate multiple objects of the same class with different attirbutes. For example

```
ObjectArray.Base.input_audio_format [
	{
		in_rate [
			8000
			16000
			48000
		]
		in_bit_depth [
			32
		]
		in_valid_bit_depth [
			24
			32
		]
	}
]
```

This would be expanded into 6 objects with the rate, bit_depth and valid_bit_depth combinations of the arrays of values above.

```
Object.Base.input_audio_format [
	{
		in_rate 8000
		in_bit_depth 32
		in_valid_bit_depth 32
	}
	{
		in_rate 16000
		in_bit_depth 32
		in_valid_bit_depth 32
	}
	{
		in_rate 48000
		in_bit_depth 32
		in_valid_bit_depth 32
	}
	{
		in_rate 8000
		in_bit_depth 32
		in_valid_bit_depth 24
	}
	{
		in_rate 16000
		in_bit_depth 32
		in_valid_bit_depth 24
	}
	{
		in_rate 48000
		in_bit_depth 32
		in_valid_bit_depth 24
	}
]
```

The Objects definition is an array so that multiple combinations can be specified so that we deal with only valid combinations. For example, 16-bit bit_depth is only valid with 16-bit valid_bit_depth. So if we also want to add those combinations with the multiple rates, the definition would look like:

```
ObjectArray.Base.input_audio_format [
        {
                in_rate [
                        8000
                        16000
                        48000
                ]
                in_bit_depth [
                        32
                ]
                in_valid_bit_depth [
                        24
                        32
                ]
        }
        {
                in_rate [
                        8000
                        16000
                        48000
                ]
                in_bit_depth [
                        16
                ]
                in_valid_bit_depth [
                        16
                ]
        }
]
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/216
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/216.patch
Repository URL: https://github.com/alsa-project/alsa-utils
