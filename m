Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C93C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:41:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B352087E
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J7sSPy1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B352087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A840A16DC;
	Wed, 11 Sep 2019 23:40:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A840A16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568238106;
	bh=mL/xXUF6DY2uldyraB2EcI3f4FcH/wuTCa7xIr6CTO4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7sSPy1o7BatmoxsT8nnhifKbNLuTf1ZBQot1nYUuGsbPpfGdIQf42rKBEO5OxEpv
	 pH2G5oMLo8+VVN3pJoXx5+PvsL36E5R9J9w5r6zy2mv6KWGjoLLxlF3WGnhhPGNeir
	 OgJMvXtrENk9sF8HVUYqjWQfPgQ2q8OMTAoUwOJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20FA2F8031A;
	Wed, 11 Sep 2019 23:40:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF85BF80323; Wed, 11 Sep 2019 23:40:54 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC6AAF801ED
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 23:40:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC6AAF801ED
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1i8AM5-0004SZ-JM; Wed, 11 Sep 2019 23:40:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jaroslav Kysela <jkysela@redhat.com>
Date: Wed, 11 Sep 2019 23:40:49 +0200
Message-ID: <2429832.PdgLd5CbFv@diego>
In-Reply-To: <15679391594432724-alsa-devel@perex.cz>
References: <15679391594432724-alsa-devel@perex.cz>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Licence change for your alsa-lib UCM commit (Heiko
	Stuebner: 1 total)
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

Am ,  schrieb Jaroslav Kysela:
> As discussed, we would like to move the UCM configuration files from the
> alsa-lib repository to new alsa-ucm-conf repository with the licence chan=
ge
> from LGPL-2.1 to BSD-3-Clause.
> =

> I would like to check, if you agree with this licence change. Please, ans=
wer
> to this e-mail and write your agreement / disagreement (keep CC to
> the alsa-devel mailing list for the archiving purposes).
> =

> Thank you for your time and co-operation.
> =

> Reference:  https://mailman.alsa-project.org/pipermail/alsa-devel/2019-Ju=
ly/153257.html
> =

> List of your commit(s):
> =

>   f449a299431a30d7d2588199f4cbd16e329db8a5
>     conf/ucm: ROCKCHIP-I2S: rename to VEYRON-I2S

I do agree to the license change from LGPL-2.1 to BSD-3-Clause.

Regards
Heiko St=FCbner


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
