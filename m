Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA69C47404
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 06:27:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048962133F
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 06:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PJqQzxA8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="ZlolaT92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048962133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32F0C86E;
	Wed,  9 Oct 2019 08:26:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32F0C86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570602422;
	bh=e5zyOQalrksKLe7kzU+OGPYcao6bBsNE1ptxFl6n1Bs=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJqQzxA8PFxMX5t50IqA0KxmgSKkmywujPqiSBJ9c3QYFPKJV3h0+z78L1V5U+13Y
	 NTzLeeG5jDM+Hq4gVh/BoUO4sFA4D9BflhTdDRofyJPVMHG2e0z0HP6B8/OtmMy/+C
	 a47t5UglzUl+jTWfmZ75QFpTyXili2H1pqJBxEGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B53E7F802BD;
	Wed,  9 Oct 2019 08:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8AC3F802BE; Wed,  9 Oct 2019 08:26:09 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8935DF800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 08:26:06 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7596AA003F;
 Wed,  9 Oct 2019 08:26:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7596AA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1570602366; bh=PfzCLWbJ2aXvFdfD0RK/lBSuS5s2XrS8eIX4JGOWsq8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZlolaT92NLpqKsoOlIM/uy8OOx1kVhNPYU5kDpMXcMw7cme3qIHJzski+27okGT+/
 en2rW7oCMo9A8t9ki5RDTyAd/c0R8Rg9rzl3X9g50myi76rwtHqNa2YkIctBlInTPn
 gYCJlYhx0UPl1ipa0tl0PHxOSCFpKAZDvOvztPRA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  9 Oct 2019 08:26:02 +0200 (CEST)
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191006152232.17701-1-perex@perex.cz>
 <fd997c93-c7c9-6ede-90c2-a94df93a613e@linux.intel.com>
 <d79e7cdd-2f94-1f00-0025-907682ab9988@perex.cz>
 <e3e763ac-d477-030c-3508-f40d692dfba2@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <7d4a2c67-4b8d-77a1-dcaa-165af565bae9@perex.cz>
Date: Wed, 9 Oct 2019 08:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e3e763ac-d477-030c-3508-f40d692dfba2@linux.intel.com>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [alsa-devel] [PATCH v3] ALSA: hda: add Intel DSP configuration
 / probe code
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 08. 10. 19 v 20:44 Pierre-Louis Bossart napsal(a):
> 
>> Added. Will be in v4. Thanks for all of the input.
> 
> I took the liberty of adding suggested fixes on top this v3 in a GitHub PR:
> 
> https://github.com/thesofproject/linux/pull/1290

Thanks. I put other little modifications to v4 (without the table changes - I
was waiting to your input), so you can stack the modifications on top.

I just tried to fix the Takashi's nitpicking and I saw some warnings from your
CI (bit definitions, EXPORT_SYMBOL), so I addressed them, too.

Please, rebase your changes on top of v4.

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
