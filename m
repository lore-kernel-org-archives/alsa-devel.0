Return-Path: <SRS0=67eO=X7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE13C4360C
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Oct 2019 14:11:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDD720862
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Oct 2019 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AXazkWaH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="UF4vzWac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DFF5836;
	Sun,  6 Oct 2019 16:10:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DFF5836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570371087;
	bh=l9yYIFb6vxjYtlsBFSO7uK6Ltrvxxo/B8IulKyGBdlE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXazkWaHBOAbLE+ffILPe9XzfQ/Y0/3E8QKfAD30tvQMg7SMEXBeb6liEVRVnsKFX
	 7LqRsVJySx0qsQ1VjBqHoOQh/iITt2bvVEP6SIDQS6hEED38Xs6NNxp15VJDm3B8JT
	 vEWBTQtWwEaKIcHadpd91cQQqPUmpsS0TSY7ahIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE76BF8038F;
	Sun,  6 Oct 2019 16:10:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1162DF8038F; Sun,  6 Oct 2019 16:10:35 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A19D8F800C4
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2019 16:10:31 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 62AF6A003F;
 Sun,  6 Oct 2019 16:10:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 62AF6A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1570371031; bh=CBOCUWULr3o3+8DT2wGHXdzBvndWP8jyNg/weOGn2js=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=UF4vzWac9RxSYCU4OtB0fr4Lc0hFFn3WaPaMph2jGrHsEtDjv+1nDeoM/+FrAk17T
 0OP+rYk8T5/C7cUY/OYQWB6Yg+PPNCUInISchLKK3Dasw3L4cpR9rQTxzqVbpiW/PR
 5CsCqRlMHdYOHBDsDsukNf1L96JlvoAhRS6N2hx0=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun,  6 Oct 2019 16:10:28 +0200 (CEST)
To: alsa-devel@alsa-project.org
References: <20191006104715.GA14691@ubuntu>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <7f7434ad-407b-002d-d2af-860ce49bae32@perex.cz>
Date: Sun, 6 Oct 2019 16:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191006104715.GA14691@ubuntu>
Content-Language: en-US
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] what's the kernel policy WRT firmware parsing
 security?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 06. 10. 19 v 12:47 Guennadi Liakhovetski napsal(a):
> Hi,
> 
> I decided to have a look at whether the ALSA topology parsing is bullet
> proof against malformed topology files. It seems not quite to be the case.
> At least I seem to have found a possibility of crashing the kernel by a
> malformed topology file. I haven't tested it, so, maybe I'm wrong.
> 
> In principle, firmware files can only be written by root, and if you have
> root access to the system, it's anyway doomed. Is this the approach and
> we aren't really trying to make topology parsing 100% safe, or do we want
> to fix any such possible parsing issues?

The kernel should not crash. Dot. If you found a serious issue, please,
report it or better, send the fix.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
