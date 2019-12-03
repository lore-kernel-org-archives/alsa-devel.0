Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A2BC432C3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A461420803
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sVdckb80";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="toEJBEQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A461420803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA3B166A;
	Tue,  3 Dec 2019 20:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA3B166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575402012;
	bh=ka6JON8VUFxwmcaifYvXZgeaILAAYcn/npOxH4RQWKw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVdckb80eJlRVia1LdTl/aqznANikrDsucGGFgmq/zOlChLgyUhSo7mvlaUxH50/s
	 6utrW8tb03VTBOlMgH5lCUbX4HjjoPWnzEJbI2/THvdQqCH8yfsm4c4n0GbZ4TkYJ7
	 EQzBtQfjVJDhRBhOyvPW+wmYjKIbu/QW00+EtgUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89402F8022B;
	Tue,  3 Dec 2019 20:39:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B515F8022C; Tue,  3 Dec 2019 20:39:09 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD35BF80228
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 20:39:06 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6DD9DA0040;
 Tue,  3 Dec 2019 20:39:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6DD9DA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575401945; bh=Kkmi8cMn+tYEBGr758UUxWYDGMWohwfZ9H18Hvp19Uc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=toEJBEQJdLxu59ayTqnZ/5cOJIrqfopZ4D8yMoLtFhEFKiBW++jQLV48UhcgLUnOL
 Cysv5LpEydf7uq3KdT6R5UFLxiWE8fIaFDmPmjSLdTFY8y+xww51Aq3FYrf2GRkScw
 7zq3CzdiAH/XfgVmTBKgmUXBYF0mEH0pT88uPC84=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  3 Dec 2019 20:39:01 +0100 (CET)
To: Hans de Goede <hdegoede@redhat.com>
References: <20191203172739.105909-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <1eb0744b-63eb-721f-cbae-4e36a219ab61@perex.cz>
Date: Tue, 3 Dec 2019 20:39:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203172739.105909-1-hdegoede@redhat.com>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH alsa-lib] ucm: Do not fail to parse configs
 on cards with an empty CardComponents lists
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

Dne 03. 12. 19 v 18:27 Hans de Goede napsal(a):
> Since the UCM profiles for all Bay- and Cherry-Trail SST cards have been
> moved over to UCM2, parsing them fails with:
> 
> ALSA lib ucm_subs.c:220:(uc_mgr_get_substituted_value) variable '${CardComponents}' is not defined in this context!
> 
> This completely breaks audio support on all Bay- and Cherry-Trail devices.
> 
> This is caused by these non-SOF ASoC using cards having an empty
> CardComponents list. Which in itself is fine, but is rejected by
> the ucm_subs.c code. This commit changes the ucm_subs code to accept
> an empty string as a valid value for CardComponents restoring audio
> functionality on these boards.

I applied this patch to the alsa-lib repo. Thank you for this fix.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
