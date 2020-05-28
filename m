Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC825C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 13:12:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6FA207F5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NjWRga8f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="CK0GkFDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6FA207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA8241710;
	Thu, 28 May 2020 15:11:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA8241710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590671542;
	bh=U9wAAcIWLkHL5Kpq1dEgWATLLErJSgQiQo7ZI5Uzyqs=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjWRga8fG2TmaY+oc63n7BX6nO/fpEfxvS6fCWOMkdcAsiTisiUa7mZ+RF4jepPJK
	 UpFqYuC90XGKUge6HETS/BzueEXGmaxtlYYkJMILJk3WCgNWEbOs14gUhJgFnPhD4g
	 UZu2LPZmj1pgPjMIOWifE5POp9NFTtAxNpcj5LsQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EC17F8014A;
	Thu, 28 May 2020 15:11:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D709F80150; Thu, 28 May 2020 15:11:30 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9233CF800FF
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 15:11:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9233CF800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="CK0GkFDo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZAmNHc2sn7EPzZ5mrcGVz1W57m05Nf1EPqTQQ7W/eJs=; b=CK0GkFDoujxX+f5RnGmvd8iz9o
 8CSNJ9r3IZ60YgKo96/EgrICqdC6wSAdBCygj5SJbvIlpMrAFTcpTHEexGrqJSWRCAvvKdVq/Rx3h
 TlIO/7tpjq7k/phguhn7gG5XxxGPwI9dPFfQWWayy8WBhpzw5tC2ZzYeiadzc82K/knM=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home)
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93.0.4) (envelope-from <puleglot@puleglot.ru>)
 id 1jeIJb-0000wH-I0; Thu, 28 May 2020 16:11:19 +0300
Message-ID: <fc5763116929f17cb1e82764421367f7df5f4cb9.camel@tsoy.me>
Subject: Re: [PATCH] Add duplex sound support for USB devices using implicit
 feedback
From: Alexander Tsoy <alexander@tsoy.me>
To: Takashi Iwai <tiwai@suse.de>, Erwin Burema <e.burema@freedom.nl>
Date: Thu, 28 May 2020 16:11:18 +0300
In-Reply-To: <s5h1rn5rh5v.wl-tiwai@suse.de>
References: <2410739.SCZni40SNb@alpha-wolf> <1674042.U9NR2fmVFg@alpha-wolf>
 <s5ha71xwwxd.wl-tiwai@suse.de> <2281380.D2QAToNirg@alpha-wolf>
 <s5h1rn5rh5v.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

В Ср, 27/05/2020 в 09:06 +0200, Takashi Iwai пишет:
> ....
> 
> Let's see whether Alexander can test the patch.

Sorry for the late reply. I will try your patch this weekend.

