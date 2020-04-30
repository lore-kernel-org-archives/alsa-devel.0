Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F5C8300A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:27:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53548208CA
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H8tUwZX9";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Q0aKUF2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53548208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B8C11671;
	Thu, 30 Apr 2020 14:26:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B8C11671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588249628;
	bh=zpAZ0nIS2bIGefskZcg8r8i74wv7wL9HHPAQoApg9FQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8tUwZX9oEMTimlj/r0My/CffH0qqoaUPdAIQfs1AQlmd8BJq21xrlMe5u1AmaURW
	 3eS9kS3Rblqq/7xD5WPCMUwHZ9kj/k9uNQbViA40TE6nxEUn1FfZ9S7FWv4hOxanYY
	 Cb+uDC3aU+1e7xpHdxbKBTh3NKu8gruHpGV6oELU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 340C7F80136;
	Thu, 30 Apr 2020 14:26:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F390EF801DB; Thu, 30 Apr 2020 14:26:14 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C483F800B6
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 14:26:08 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 28D37A0049;
 Thu, 30 Apr 2020 14:26:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 28D37A0049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1588249568; bh=4Je7mTA7ZehJ2uAL/ynWhlYd5Pmvvdol7EJU9K/jFLY=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Q0aKUF2vMo7EJ8qjZjaJOp2kvmGVht59jXWgiyhS27JtpsCfkUiMft1LvoMa9CmWC
 lx6BmhHh5O4itZwUNDVDEb9dhD+3bXe7S0LYiE7xQA1vRXtzs4qccvtoDS3m9Pmf7w
 51Yg1KwJJ8Ie6D+XYgaHM4rDqEL0KAJOp+NbJPHo=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 30 Apr 2020 14:26:06 +0200 (CEST)
Subject: Re: [PATCH] fix infinite draining of the rate plugin in
 SND_PCM_NONBLOCK mode
To: sylvain.bertrand@gmail.com, alsa-devel@alsa-project.org
References: <20200428120918.GA459@freedom>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e1c5a0f5-6dab-c042-dcf9-873a421f8085@perex.cz>
Date: Thu, 30 Apr 2020 14:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428120918.GA459@freedom>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 28. 04. 20 v 14:09 sylvain.bertrand@gmail.com napsal(a):
> The draining function of the rate plugin does not handle properly the
> SND_PCM_NONBLOCK case. It can write data to the slave plugin each time the
> function is called, but does not update its internal state in order to
> reach a stopping condition. Use a last_commit_ptr workaround to reach such
> condition.
> 
> signed-off-by: Sylvain BERTRAND <sylvain.bertrand@legeek.net>

Applied. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
