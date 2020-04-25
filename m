Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5860C54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 12:07:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF8C20714
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B7UsBuAK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="UbtiJR35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF8C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8858D167C;
	Sat, 25 Apr 2020 14:07:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8858D167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587816471;
	bh=RQK7lAAbqH/xTq3h7to9f4L3aYUGAwjVfcpysHshOz0=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7UsBuAKnT4kxKGd7inGqZ5n0GFtMAKSsFg4F4KzDzm4lP5F8wlLV0d6qLhCFfjQo
	 Roi/qAJZ5necc4YxIVg2Vzm+j/1+6+hNMTtQDeJ4kxXYKmA65WabNNckPVzDD+XE6q
	 ch5t2fO+0uC5w6VXbgROhj1lgxF44SQaTgVTa3jA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EECCAF800BE;
	Sat, 25 Apr 2020 14:07:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61CB6F801EC; Sat, 25 Apr 2020 14:06:56 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E6E3F80105
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 14:06:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E6E3F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="UbtiJR35"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dp0MYOyqpRjcReJKaakI59MCXjxig4u3IcNefMj0PaI=; b=UbtiJR35s3eRZqXo0m4k+jPMlX
 SsQDxzymXjUmpXBUL5RDFLM2IsZE1yqRjBNFRz9/0s9mIERFKsunMO9k9zkix33E+LTTrnpynqCM9
 I/NC0tYSLwnWtqmUaWTe5qALcm+8WDYPXeMkVV6OcvvUecan0VM2HFRetCoYihJyB9Y8=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1jSJa4-0008ub-MV; Sat, 25 Apr 2020 15:06:48 +0300
Message-ID: <548c8312bd8ad65993c3169faf30054fdfa83558.camel@tsoy.me>
Subject: Re: High-bandwidth/multiple transactions per microframe in usb audio?
From: Alexander Tsoy <alexander@tsoy.me>
To: Pavel Hofman <pavel.hofman@ivitera.com>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Date: Sat, 25 Apr 2020 15:06:47 +0300
In-Reply-To: <ee53ad0d-2d61-545b-7afd-64a5ed37c702@ivitera.com>
References: <ee53ad0d-2d61-545b-7afd-64a5ed37c702@ivitera.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

В Пт, 24/04/2020 в 11:42 +0200, Pavel Hofman пишет:
> Hi,
> 
> Please does the current USB audio driver support multiple
> transactions
> per microframe (high-bandwidth mode)? I could not find it in
> endpoint.c
> but it may be there or somewhere else :-)

This should be transparent for the driver. See usb_submit_urb()
function from drivers/usb/core/urb.c. It allows packets larger than
1024 for isochronous transfers over High Speed and Super Speed buses.

