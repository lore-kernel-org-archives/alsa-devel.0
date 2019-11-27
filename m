Return-Path: <SRS0=hmI4=ZT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7A6C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:52:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657222071E
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q9PCP/gP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="bf5mbSEk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="bf5mbSEk";
	dkim=neutral (0-bit key) header.d=ab3.no header.i=@ab3.no header.b="BjuQmDhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657222071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=ab3.no
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81B5A16FB;
	Wed, 27 Nov 2019 12:51:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81B5A16FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574855536;
	bh=4ktepzhhSVIhjDOhQkv8tm748CwSHlWO1AU58kzNR48=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9PCP/gPbU9DXQIz4uuRTdpAQPg7EfE9ViViq19fKDKEi3ERVFtiwnzU5TDfUPMF6
	 1QNzFEe1gdXIJnDy4eR+CVvZ23poZAYaX0e+1Si+OuyNe4PeriiFh2aoif6K04R46Y
	 tj9TSd/fOx8zenLoum2AMuZ+FteLJyiJNyO2LToo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 102E7F8013B;
	Wed, 27 Nov 2019 12:51:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B598CF8014D; Wed, 27 Nov 2019 12:51:24 +0100 (CET)
Received: from mail.ab3.no (mail.ab3.no [IPv6:2a01:7e00::f03c:91ff:fe70:361f])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 043C7F800CE
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 12:51:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 043C7F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="bf5mbSEk"; 
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="bf5mbSEk"; 
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="BjuQmDhZ"
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 814252A3245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1574855480; bh=gdIqIw0L6MGNg8qnledozXHQvs84NN7g9Seglj8+aWQ=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=bf5mbSEktltaUj5x4+P4WOt88T9tZe7i3PDWPO77v4UzjetX7KkCorsU7dEUNo1P4
 IKcmQ5PrJeiOIzqImN0dE6n4lPYdhoRJ+05FkodgBN9I3iXdOc2AsmacH4k8CyE1zB
 0HajUQP9HbQiFVx9E7F5ayDrO+FEaqKT00YNXVhU=
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 6888B2A3246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1574855480; bh=gdIqIw0L6MGNg8qnledozXHQvs84NN7g9Seglj8+aWQ=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=bf5mbSEktltaUj5x4+P4WOt88T9tZe7i3PDWPO77v4UzjetX7KkCorsU7dEUNo1P4
 IKcmQ5PrJeiOIzqImN0dE6n4lPYdhoRJ+05FkodgBN9I3iXdOc2AsmacH4k8CyE1zB
 0HajUQP9HbQiFVx9E7F5ayDrO+FEaqKT00YNXVhU=
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 3134C2A3242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1574855479; bh=gdIqIw0L6MGNg8qnledozXHQvs84NN7g9Seglj8+aWQ=;
 h=To:References:Cc:From:Date:In-Reply-To:From;
 b=BjuQmDhZObA98nGM0yeHNfyiGrj+FCtcWTUs2jSB9z27apaqU6hUYLRdeOy4YCZXE
 ZDxcBDAu165/Zp4KdmeB+SdMTyO5Qk6qbh69ZgdMdPpcq2GSneC82Ucd/dvfqQ7kPZ
 YRFU+lmBFOhky918yZy3s5oEPZZZSct63DOWBB7Q=
To: alsa-devel@alsa-project.org, Curtis Malainey <cujomalainey@google.com>
References: <CAOReqxjFaWhYCzzyZ90Pc5EvzUky6kCYqakz2XBwSOii9d3maA@mail.gmail.com>
From: =?UTF-8?Q?Mads_L=c3=b8nsethagen?= <mads@ab3.no>
Message-ID: <c22f818f-a819-84a4-f903-80dbdfed35ca@ab3.no>
Date: Wed, 27 Nov 2019 12:51:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAOReqxjFaWhYCzzyZ90Pc5EvzUky6kCYqakz2XBwSOii9d3maA@mail.gmail.com>
Content-Language: nb-NO
Cc: Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] Headset button mapping in the kernel
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi!

Is this related to Android Wired Audio Headset Specification? Just 
wondering (I asked about it last month[1]).

Would be neat if it were possible to get headphone buttons working on 
Linux in general.

- Mads


On 25.11.2019 20:25, Curtis Malainey wrote:
> Hello ALSA Devs,
> 
> I am looking to get some feedback/ideas on a possible change to
> headset button mapping. Locally we are carrying patches that implement
> the mappings in the machine driver (which we understand you do not
> want upstream.) We are looking to see if we can add a new API
> (something like a sysfs path potentially) to have userspace pass in
> the mapping, if it chooses to, so the mapping can still be done in the
> kernel. That way we can carry just the config locally and remove some
> of the kernel patches we are carrying locally. Thanks.
> 
> Curtis
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
