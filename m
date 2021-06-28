Return-Path: <SRS0=rSKw=LW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB81AC2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 10:17:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3858E61C6C
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 10:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858E61C6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0A241672;
	Mon, 28 Jun 2021 12:16:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0A241672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624875441;
	bh=KWcFklCrv4Ob1SOov1y7qddvatwUKyqcZqb+6P9h47E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0a1NYEEkNTIBcEomcpgQQz/1nBOnWbgpJD9rSLBo9hF6jRY9CNxzXkFjnErraPqJ
	 l3o9X2TWmaez0U4lWF89gKIYsUX3ho8QvSHv8GgshKPSmpt8lVcq65neIRsluYB1y9
	 vWjW2CjQPZJil8DZOlOEapJcwnZA879iYc9qT0FA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C8EBF80217;
	Mon, 28 Jun 2021 12:16:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB1AEF80229; Mon, 28 Jun 2021 12:16:28 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AF3FF80137
 for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2021 12:16:21 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1423BA0040;
 Mon, 28 Jun 2021 12:16:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1423BA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1624875381; bh=C/yb0/lAlQf+Yldyb11NIjWTROdjQzOSYBUTtru7+Jc=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=DNtW+3qQPLOdijuxDL0HpDyDJJzQP1olfrRWVH6jf0RV4uq1y/CBzY8cCsJOf4L/u
 dkkaW9u7LAKgml+0XB1X43uhfHbijzhtAvBdKP2k0JDJux3OkJb32xMWSs1FRIdpeD
 ZiyxcPYFEKJpOr1cBvHa0tGJ2OOwkpl34J+oiB4c=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 28 Jun 2021 12:16:19 +0200 (CEST)
Subject: Re: [PATCH alsa-lib] Fix build with --disable-ucm
To: ALSA development <alsa-devel@alsa-project.org>
References: <20210627223527.10725-1-mforney@mforney.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <131a1e50-cd25-34cd-6197-15ff75ace1c6@perex.cz>
Date: Mon, 28 Jun 2021 12:16:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210627223527.10725-1-mforney@mforney.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Michael Forney <mforney@mforney.org>
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

On 28. 06. 21 0:35, Michael Forney wrote:
> A recent change introduced a dependency on ucm to several of the
> other components, but this was not made conditional on whether
> BUILD_UCM is enabled.

Thank you for your patch. I fixed this using inline functions:

https://github.com/alsa-project/alsa-lib/commit
/f4f29d42be8b8ad60ea4c5697374adad4bfe6868

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
