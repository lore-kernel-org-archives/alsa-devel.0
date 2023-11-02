Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A51C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 21:33:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8950D827;
	Thu,  2 Nov 2023 22:32:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8950D827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698960779;
	bh=Q6RAt9WDoMmKifTz8osglDccZBx2+JeWzwRjjrF32hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XZH8U8TSZcX5cqNPai1xUobat38KFn2SVCpeOJRg+7H/Pa7XETgD9MkfHe5zBTUwB
	 +YGIGKtSgC5occeyCnlyfiXW91OjJM1NDV/zCwAINkv3BuwJEgwBzVUkTGAarPAzPx
	 1A9+UXWjzpA1G+BHegMbpuv/lTQ3bMK/aSQJJzxM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC0E1F8014B; Thu,  2 Nov 2023 22:32:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A028FF80290;
	Thu,  2 Nov 2023 22:32:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE731F80290; Thu,  2 Nov 2023 22:32:03 +0100 (CET)
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E84A3F80152
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 22:31:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E84A3F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=mutex.one header.i=@mutex.one header.a=rsa-sha256
 header.s=default header.b=fjJx7RCR
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mutex.one (Postfix) with ESMTP id C716016C0059;
	Thu,  2 Nov 2023 23:31:56 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
	by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGFwVGpa-qcb; Thu,  2 Nov 2023 23:31:51 +0200 (EET)
From: Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
	t=1698960711; bh=Q6RAt9WDoMmKifTz8osglDccZBx2+JeWzwRjjrF32hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fjJx7RCRxmL0vI4FsOD0Ut7IzvWscnPYs4ITJjcb1+QVmI7C/v8FgQjInLbQPGOy0
	 kKzqNo2xwygkacxKxwuEEYsLBwpiXOzbqrKMYncfWtpdgMelM/OrdMtG2GMJ6uVJsb
	 5S2KpcbnOGPnYKjNqz4DaOWp/n+WW8PEuDlOCt68=
To: syed saba kareem <ssabakar@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Yang Yingliang
 <yangyingliang@huawei.com>, Venkata Prasad Potturu
 <venkataprasad.potturu@amd.com>, V sujith kumar Reddy
 <Vsujithkumar.Reddy@amd.com>, ye xingchen <ye.xingchen@zte.com.cn>,
 linux-kernel@vger.kernel.org
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops
 support for acp pci driver"
In-Reply-To: <fcb8f03e-bad1-966c-d454-b7ef7cb62454@amd.com>
References: <87a5v8szhc.fsf@mutex.one>
 <fcb8f03e-bad1-966c-d454-b7ef7cb62454@amd.com>
Date: Thu, 02 Nov 2023 23:30:16 +0200
Message-ID: <878r7f4zdj.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID-Hash: 76RI6ZZ3UVP4FWXM7QI2ZC2GCKXQS3X5
X-Message-ID-Hash: 76RI6ZZ3UVP4FWXM7QI2ZC2GCKXQS3X5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/76RI6ZZ3UVP4FWXM7QI2ZC2GCKXQS3X5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

syed saba kareem <ssabakar@amd.com> writes:

> We haven't up streamed pm ops for Renoir platform.
>
> That is the cause for the issue.
>
> Will upstream them in a week.

Did you manage to upstream the pm ops for Renoir platform?
I have checked the latest commit on the for-next branch
( ed2232d49187cebc007ecf4e6374069b11ab3219 ) and the issue is still
there.
I still have to revert commit
088a40980efbc2c449b72f0f2c7ebd82f71d08e2 to have my driver function
properly.
