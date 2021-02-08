Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FB5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 10:24:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8F364E7D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 10:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8F364E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62D8A84D;
	Mon,  8 Feb 2021 11:23:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62D8A84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612779850;
	bh=4C3tPD50CEd9pBqDw8N/qsws6wz6P3hTFdoBw3ClvXQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+enoyJEdUDp9sHsdhcXRysHpa5Oa4kc0a8gJlVmvriHyS1e7x5DlcV5EYVYB63GL
	 BEIrpTx6f54mTtZoqO2cO2TlfnVpvm1E9iUPnKUbwIVNH4CZzBE6F5Jr4IhsRjmf6L
	 Oa2a9We8P8ty1w+xV76gUy78qnRM4jMyKFWlaDAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8EE2F80169;
	Mon,  8 Feb 2021 11:23:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06460F8022B; Mon,  8 Feb 2021 11:23:13 +0100 (CET)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3DB4F8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 11:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3DB4F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="mFe1w9DJ"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id A41C1A1564;
 Mon,  8 Feb 2021 11:23:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=at4jZ4jFp6mO
 dj2ztTnNdUQgOjcn7s5UMzIujxqvxMk=; b=mFe1w9DJ8y53Wf4P/7vu/IcC5equ
 c4Fb+Zyxde0kVPErILqi+EUdtOtCNg24A4RTxF9W0/5lkPLqzpubs10fs4/+u45c
 W0Ko2HZWLs7uqBD9ahFaqep85TfIdLju2+gzlwHUSTBVNOBF656LylYucFmjHv0J
 LEuvn4ZAYPEK0XMDAAZyMdg86d7Qougll1ZHQOc0gp/fGOY960kwsK8YkJzICN/S
 MlNIuWL2Omd39oReoF5BIvWmEGt6dcqQq6LEWEHUOqb/6lzN5V4wq8PXzLdLvzZJ
 ftIOlV0gz6GWBVxwoFn5iuwJIV5e0uM7h/NRQUnIn3Bf6kEMNv1oM+ciWA==
Subject: Re: [PATCH v2 0/9] ALSA: add virtio sound driver
To: Takashi Iwai <tiwai@suse.de>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <s5hpn1h81ot.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <da7fd8cf-9c4d-082d-70bd-b27e242a4eb7@opensynergy.com>
Date: Mon, 8 Feb 2021 11:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <s5hpn1h81ot.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Takashi Iwai <tiwai@suse.com>,
 virtualization@lists.linux-foundation.org
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

Hi Takashi,

Thank you for your hints, I actually applied them all. The only question 
that I have is...

On 03.02.2021 19:07, Takashi Iwai wrote:

[snip]

> 
> - Don't PCM stream names need to be unique?  They are all the same
>    string.

What did you mean here? Substream names?


> 
> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

