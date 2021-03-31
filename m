Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD6DC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:22:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2D261029
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 18:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2D261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nh6z.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 768DB10E;
	Wed, 31 Mar 2021 20:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 768DB10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617214956;
	bh=3Zlv/yuKLRK42mbVMovDV4JkZmo//OI7TjpT7Uii8Sw=;
	h=Subject:From:To:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Kwm72vbhbdHsUaFluA3lEVp5Zotgd59lgrVRdiChyn35s3JKsV+2kvtLwNdSzIgEF
	 UBY5Qzcr2qNQE1KYE4ih2Dn9x82FtnXA0Se/WbMilPAtc7gPnsozN73yDdhZJhbGW2
	 2hmyiFHPuvftofgZWt3DJRE0n3xUTRUHVgTr6W+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 132ADF80166;
	Wed, 31 Mar 2021 20:21:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90A6FF80166; Wed, 31 Mar 2021 20:21:43 +0200 (CEST)
Received: from a27-236.smtp-out.us-west-2.amazonses.com
 (a27-236.smtp-out.us-west-2.amazonses.com [54.240.27.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEF30F8013F
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 20:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEF30F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nh6z.net header.i=@nh6z.net
 header.b="cAa+zIsK"; 
 dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com
 header.b="PLVh1+Nr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zzmz6pik4loqlrvo6grmnyszsx3fszus; d=nh6z.net; t=1617214896;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
 bh=3Zlv/yuKLRK42mbVMovDV4JkZmo//OI7TjpT7Uii8Sw=;
 b=cAa+zIsKp3rEeGMYUxOqG35aoNZvnL+HdiMVTONb4nTEYTWGnEnDiTe3ErgNkpSl
 Z+tdVnr3cme336ztQYm1zVN0rWg7dN36tMsbKokQ8qLfavKGsncmbGmqDHRx3vafY78
 F+FGPcyZ4Nl/TDC0CygcOlgHHNGHheQf20Jn46vw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1617214896;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
 bh=3Zlv/yuKLRK42mbVMovDV4JkZmo//OI7TjpT7Uii8Sw=;
 b=PLVh1+NrnW6Tt5k2SuozGwUa6Jas+WZ53HIzThbG/9lQMeT9Pttl9eiy7ZgEJTRi
 dPilhaOKUtzWtGgTYumoZya3CMwxLI2c7dq4pDkjUJCXwmymHkK5sFSsEBDZNDAREn8
 ffL1zw8XigFuW+M+ttIojA055RmDPluI/mI5Z0pk=
Subject: [PATCH v2 0/2] ASoC: tlv320aic32x4: Bugfixes for tlv320aic32x4 driver
From: =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
To: =?UTF-8?Q?alsa-devel=40alsa-project=2Eorg?= <alsa-devel@alsa-project.org>, 
 =?UTF-8?Q?broonie=40kernel=2Eorg?= <broonie@kernel.org>, 
 =?UTF-8?Q?lgirdwood=40gmail=2Ecom?= <lgirdwood@gmail.com>, 
 =?UTF-8?Q?perex=40perex=2Ecz?= <perex@perex.cz>, =?UTF-8?Q?tiwai=40suse=2E?=
 =?UTF-8?Q?com?= <tiwai@suse.com>
Date: Wed, 31 Mar 2021 18:21:36 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <20210331182125.413693-1-nh6z@nh6z.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHXJlqutU2ZzEf5Tk+l1YBnPdSJ8w==
Thread-Topic: [PATCH v2 0/2] ASoC: tlv320aic32x4: Bugfixes for tlv320aic32x4
 driver
X-Original-Mailer: git-send-email 2.27.0
X-Wm-Sent-Timestamp: 1617214895
Message-ID: <010101788984f9d0-64bcaa85-ce13-49dc-bfc6-892a6a4e411e-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2021.03.31-54.240.27.236
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Cc: =?UTF-8?Q?team=40nwdigitalradio=2Ecom?= <team@nwdigitalradio.com>,
 =?UTF-8?Q?Annaliese_McDermond?= <nh6z@nh6z.net>
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

These are a couple of bugfixes for the tlv320aic32x4 driver
that we discovered after the Raspberry Pi Foundation's move to
the 5.10 kernel.

The first increases the maximum value in the regmap configuration
so that the powerup command actually works.

The second changes the ordering of the clock registration in the
module probe function so that the clocks are properly registered
before the component probe function runs.

Changes in v2:
- Corrected commit hashes in Fixes lines to be proper length
- Including inadvertently omitted maintainers on To list.

Annaliese McDermond (2):
  ASoC: tlv320aic32x4: Increase maximum register in regmap
  ASoC: tlv320aic32x4: Register clocks before registering component

 sound/soc/codecs/tlv320aic32x4.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.27.0

