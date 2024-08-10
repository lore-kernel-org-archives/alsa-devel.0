Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6A6C3DA7F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:28:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 919812319;
	Thu, 15 Aug 2024 10:27:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 919812319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710485;
	bh=FoMGXcxzmZi6fsVLQcG2de1o9CKISWaGNCi1QFogghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JoHIg7gNMxF/CWYWfkq8t5Qm1umbhS1GqmPEJTiYnJKtZpyG3UlbvLXu51LcADuut
	 QbKQ1x79+0Fcms5DL4Bx2i1glinrpAFP0AgisNDsNFN6hY8RCplbVLlkpBzlUsRdU5
	 jQ9FaQ7Kgj7umGnjaPls3iEggSOH76mDqnqLQL+8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8FAAF80C79; Thu, 15 Aug 2024 10:24:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F4DDF8081A;
	Thu, 15 Aug 2024 10:24:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35B23F80236; Sat, 10 Aug 2024 15:34:51 +0200 (CEST)
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 725C0F80236
	for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2024 15:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 725C0F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.a=rsa-sha256
 header.s=s1 header.b=NMm4nnLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
	t=1723296602; bh=FoMGXcxzmZi6fsVLQcG2de1o9CKISWaGNCi1QFogghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMm4nnLSuRckPGTr6LEmABPa7lLHILGmiOC4ai/zz/aq8AOWf38e31cnej5cgkBKj
	 FRD0HANPayEpxa5OFHMTYrqOAm56dN9iAVyj6OC4wwpIFg1jElKc64tTbo+9j3o+E9
	 S64Gpfq1vuG8yk+Qr9GGeVyE1NidNgmFhtdYUPZM=
From: Luca Weiss <luca@lucaweiss.eu>
To: Luca Weiss <luca.weiss@fairphone.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: 
 Re: [PATCH 0/3] Add DisplayPort sound support for Fairphone 5 smartphone
Date: Sat, 10 Aug 2024 15:30:01 +0200
Message-ID: <2741308.mvXUDI8C0e@g550jk>
In-Reply-To: <192e3c22-fd63-4891-86b2-89a3383ab76d@kernel.org>
References: 
 <20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com>
 <192e3c22-fd63-4891-86b2-89a3383ab76d@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-MailFrom: luca@lucaweiss.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YB4HVEDDU7HLC4TILLITI2VDFALL6KVC
X-Message-ID-Hash: YB4HVEDDU7HLC4TILLITI2VDFALL6KVC
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:23:28 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YB4HVEDDU7HLC4TILLITI2VDFALL6KVC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Samstag, 10. August 2024 14:35:00 MESZ Konrad Dybcio wrote:
> On 9.08.2024 10:33 AM, Luca Weiss wrote:
> > Add the necessary sound card bits and some dts additions to enable sound
> > over DisplayPort-over-USB-C, e.g. to a connected TV or monitor.
> > 
> > The UCM files can be found here:
> > https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing/
device-fairphone-fp5/ucm
> > 
> > Two extra notes:
> > 
> > 1. I don't quite understand whether the sound driver should have
> >    SoC-specific compatible or device-specific compatible. Some earlier
> >    patches by another author for a QCM6490 board and a QCS6490 board use
> >    device-specific compatible - but from what I can tell this is not how
> >    it's generally done for other sound drivers?
> > 
> > 2. Unfortunately DisplayPort enablement itself for Fairphone 5 is not
> >    upstream yet. This is blocked by DSI display bringup upstream which
> >    is blocked by DSC 1:1:1 not being supported upstream yet and just
> >    working with a hacky patch. Nevertheless, DisplayPort audio was
> >    validated working with no additional sound-related changes so once
> >    DisplayPort gets enabled, sound should also just work upstream.
> 
> You can enable DP and keep DSI disabled for the time being

I need to enable dispcc for DP which breaks simple-fb from my testing?

Maybe I can figure out the correct clocks and power domains to put into the 
simple-fb node? Do you think that would work and be sufficient to make both 
simple-fb and DP work?

> 
> Konrad
> 




