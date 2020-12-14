Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F05C4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 07:37:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BFB22582
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 07:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BFB22582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EC5D1717;
	Mon, 14 Dec 2020 08:36:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EC5D1717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607931426;
	bh=6JV/Y7WgzOgMKEBY2qBgSg4bUYqimc5pG0yPiZIy80U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKcscMpF05ympEr8xlo0zn9ygGTxcwNP2mZ9L6EhptMGCKEFoXNjVgItYGMgkHNBX
	 V1ws87w3fP2TvLPb01uoLeayHeLb0PWjOEObtDAjWMZkeKNl9t9aOQoK0nt/PHryvI
	 RbFmznaEYavUlWNSXoJyI+6HjuCD0RaK2WMizMII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87661F80171;
	Mon, 14 Dec 2020 08:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C838F801F7; Mon, 14 Dec 2020 08:36:14 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2115F800ED
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2020 08:36:07 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4CB4CA003F;
 Mon, 14 Dec 2020 08:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4CB4CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607931366; bh=gHKfSxe+Se/gEGYouid54iIj5LcCBeZSGLUnO85JdcQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=p42UoI4FJ905a9K0tSieQ4O4Y20ZJgkV+ICrpk6dvp9QWX//C5pDv21q4a0YBwTMS
 UnTTpJbwyoz8WUImOQqo4GUg7BPUACcUTlPcsL9hrJ51rbCN/MxCVQE3x7kkc76Z8Q
 wLvZMv4lEVDZJ6buL8XtFdf7LomXKDeFDZwQcyvE=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 14 Dec 2020 08:35:56 +0100 (CET)
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume control
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20201214064903.2746-1-jack.yu@realtek.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <8eeddc8c-91cb-e62d-6114-547117d4d83e@perex.cz>
Date: Mon, 14 Dec 2020 08:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201214064903.2746-1-jack.yu@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 derek.fang@realtek.com, bard.liao@intel.com, shumingf@realtek.com,
 flove@realtek.com
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 14. 12. 20 v 7:49 jack.yu@realtek.com napsal(a):
> From: Jack Yu <jack.yu@realtek.com>
> 
> Add main capture switch and main capture volume for callback to be in
> single operation.

Could you be more verbose, what you're trying to do in the patch description?

> +	 * "Main Capture Volume" looks the same as "ADC 07 Capture Volume",

I would just use "Capture Volume" and "Capture Switch" here without the Main
prefix to follow other drivers.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
