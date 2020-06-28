Return-Path: <SRS0=3jBL=AJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFAC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:58:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270CC20885
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MyM5VBRN";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="5sJQgZEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270CC20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD4E41681;
	Sun, 28 Jun 2020 17:57:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD4E41681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593359890;
	bh=77NGOnwFG1RsG16YFKTU4lyyBH8pYb6nezn+bED4tX8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyM5VBRNB5cd3j4ve9B3pp36P6HuORmKDH93MzXHFYioBom4skF6ANp974ViXccw3
	 NTDWU2ZbGerd6I4WQSjIANa7w35vNHsqszGDG7ZVr0n5gGyHHdiuedcSU6tZt+xiBC
	 4j9tlBs1ZZQv1KVX79h/jGUe+rW/jfqCwRguk/nk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A1E4F80245;
	Sun, 28 Jun 2020 17:55:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30087F80245; Sun, 28 Jun 2020 17:55:37 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09A3AF800E8
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2020 17:55:30 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DBFE0A0040;
 Sun, 28 Jun 2020 17:55:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DBFE0A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1593359729; bh=Sy9u8fyQ4Zb5fJTz0St2QRgSWQEAx1fAjhGBSmXH/5A=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=5sJQgZEzZlvePYfn0Sud7LkRmgUvz3jo0iW2upoRd05BbNw+mOxgC9hGIwejV7zSi
 NhSBdOC9Mp1nUndiT6WchrCHrrhdu3vfz2s1wk+zCnvj9B2N/bau6aofgmkLsUHSc2
 l484ZJqA7oxLKm9XL/j9y4c+nPfkEw22QHGv1wSM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 28 Jun 2020 17:55:26 +0200 (CEST)
Subject: Re: [PATCH] ucm: Allow empty strings in "${var:...}" substitutions
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
References: <20200627183052.97118-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a9f4c3fe-9e68-8bf7-ea79-5fc77f4cdcc3@perex.cz>
Date: Sun, 28 Jun 2020 17:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627183052.97118-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 27. 06. 20 v 20:30 Hans de Goede napsal(a):
> Recent ucm-conf changes introduce checks like this one in various places:
> 
> If.mspk {
>          Condition {
>                  Type String
>                  Empty "${var:MonoSpeaker}"
>          }
>          True ...
>          False ...
> }
> 
> The 'Empty "${var:MonoSpeaker}"' part can only every succeed if we do:
> 
> Define.MonoSpeaker ""
> 
> But so far that would result in an error like this one:
> 
> ALSA lib ucm_subs.c:367:(uc_mgr_get_substituted_value) variable '${var:MonoSpeaker}' is not defined in this context!
> ALSA lib main.c:983:(snd_use_case_mgr_open) error: failed to import cht-bsw-rt5672 use case configuration -22
> alsaucm: error failed to open sound card cht-bsw-rt5672: Invalid argument
> 
> This commit fixes this by allowing empty values for "${var:...}"
> substitutions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Mea culpa. I had this change in my local tree, but I forgot to push it 
upstream. Anyway, thank you for your work and testing. I accepted your commit 
to retain your credits.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
