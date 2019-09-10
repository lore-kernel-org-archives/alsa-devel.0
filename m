Return-Path: <SRS0=R5RK=XF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC6C49ED9
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:34:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405D92082C
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vqzK3Vfd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ofb.net header.i=@ofb.net header.b="OTf82RgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405D92082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ofb.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA32C1681;
	Tue, 10 Sep 2019 19:33:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA32C1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568136885;
	bh=pR4+xIXziZGxvz7umQQwEjTSJoNMJEfpbOvymIf3aj8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vqzK3Vfd1hqSjxQVI5OQlRep8/Td8SDb2O3NwKOR0t5cJFro6q/kAd5T1MGh7GWbL
	 PKC419VVWFERCNSkEAQSLEEYxHVxFDLnHN3iHG8DpdD2/Pj/+Kij2FRrzwUjY4Vcry
	 zNZGo7syUzaK7xhezrRK+0LcfFvEvan44fGwAhrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54070F800C9;
	Tue, 10 Sep 2019 19:33:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02A07F80368; Tue, 10 Sep 2019 19:33:53 +0200 (CEST)
Received: from egnor-li.ofb.net (egnor-li.ofb.net [IPv6:2600:3c01:e000:283::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3147CF800C9
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 19:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3147CF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=ofb.net header.i=@ofb.net
 header.b="OTf82RgZ"
Received: from ofb.net (163.242.197.104.bc.googleusercontent.com
 [104.197.242.163])
 by egnor-li.ofb.net (Postfix) with ESMTP id 9C49C117FC6;
 Tue, 10 Sep 2019 17:33:46 +0000 (UTC)
Received: from localhost.localdomain
 (host86-142-59-18.range86-142.btcentralplus.com [86.142.59.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by ofb.net (Postfix) with ESMTPSA id 59D7D3E923;
 Tue, 10 Sep 2019 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ofb.net; s=ofb;
 t=1568136826; bh=JU2ZXIZGbMWL0+yeFomgN69JKrPct9nPBiJ4k97a2r8=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=OTf82RgZVZaF3E7b4QB3skh/DFh/+A2QSyN1ZcVzxhVXHfajnzjmCvG6VfIB7flrS
 SXYUYL2ic3lVmmHGPJJIZDfrPQP5ybNiwLk0Uex+1fLyPO/+FPfbZ1tnE5xy+nf0jK
 HmA7A5UdCEtZIJ4ZnUqcY2qp8dosePGr+DseqU/0oizdyNb6+t6tXpXDkc8zSgeASz
 IZswJKyuw5mY6RZGQlLJrfFpiB6SjetxVc3UarqKcVoT7us5atsPly1ppz25R/ucTT
 +2THeZbN3qX4bqDDbWaEiIXGzb75rMlZGMMGhsTmm0gSWT1bxf09bwRZ4WV8dOPtZ6
 Xv2hRILO3wt9Q==
Received: from frederik by localhost.localdomain with local (Exim 4.92.2)
 (envelope-from <frederik@localhost.localdomain>)
 id 1i7k1R-00038U-5M; Tue, 10 Sep 2019 10:33:45 -0700
Date: Tue, 10 Sep 2019 10:33:45 -0700
From: frederik@ofb.net
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20190910173345.63bv2xa4vlkxicxj@localhost>
References: <20190904164706.gwjbcywbj7emnwvr@localhost>
 <s5hv9u19x2f.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hv9u19x2f.wl-tiwai@suse.de>
User-Agent: NeoMutt/20180716
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] parameter for pulse device?
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
Reply-To: frederik@ofb.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Sep 09, 2019 at 07:52:24PM +0200, Takashi Iwai wrote:
>It depends on how pcm.pulse is defined.  If it's defined to take an
>argument, it can work like that.  (Or sometimes you may need to pass
>the argument explicitly like "pulse:{device=mointor}".)
>
>The standard pcm.pulse definition provided in alsa-plugins repo
>doesn't take the argument, and that can be the reason.

Thank you Takashi. Would it be easy to change alsa-plugins so that it takes an argument? Is there a chance that this change would be accepted?

If you can point me to the section of code in e.g. "plughw" where argument parsing is done, then I would probably end up modifying alsa-plugins myself, just to simplify what I am doing.

Thanks,

Frederick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
