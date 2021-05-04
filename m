Return-Path: <SRS0=dtPj=J7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FCEC433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 16:23:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BF661073
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 16:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BF661073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0687B1696;
	Tue,  4 May 2021 18:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0687B1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620145388;
	bh=a84OlkVtvvfyp3vb7dQ6iFVft9BiyVaAq+pzoH+Bhcg=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ppARRBFWD3+apkDUsEN+n7RGz8W5Sud6zBPrnSZmu21CXqohwnocFzaI8EhI2Kx59
	 2SPrO6VGikK6OyHazDhI/vwTHRMZLaM/43N5DPpSxP3NMpgkSlSZzhcvaJzgKGSU38
	 /Ouns5OLUJ6OMeXayQpAL5jj3OcWK8EnsO7JELas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A00FEF80114;
	Tue,  4 May 2021 18:22:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 254C6F8021C; Tue,  4 May 2021 18:22:16 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFCF5F80114
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 18:22:08 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 32BE1A0046;
 Tue,  4 May 2021 18:22:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 32BE1A0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1620145323; bh=cL94rCKoOSC+RHC5Z8Dr88x4Qp+cUy///LiEStiP3Ow=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=FaYpSnA8RjvjNmUOk5WhfkEZxekYOM59AR1QqlXNi5O743UCSTmp/fT+y8jCmUQzB
 q+yQt+Pow1LdJOhHucb58BjOlzRHFJuS85mayD88cB9ZxLU0sK4S+uRJ2GulPJqWeK
 eeYJ+C1utlakVZD72yWD+EsW+JmzSLGBXwkhYz9k=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  4 May 2021 18:22:01 +0200 (CEST)
Subject: Re: [PATCH alsa-lib] mixer: simple - Fix "Capture Volume" and
 "Capture Switch" being seen as global controls
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
References: <20210504155830.112653-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <776d9394-5c83-8af7-f7a1-6aa73390b34d@perex.cz>
Date: Tue, 4 May 2021 18:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504155830.112653-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
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

Dne 04. 05. 21 v 17:58 Hans de Goede napsal(a):
> Fix the "Capture Volume" and "Capture Switch" exceptions no longer
> working after commit 86b9c67774bc ("mixer: simple - Unify simple_none:
> base_len() exception handling") because they were moved to after the
> suffix checking, so they would be treated as CTL_GLOBAL_VOLUME resp.
> CTL_GLOBAL_SWITCH based on their suffix before the exception check
> has a chance to check for a match.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied. Thank you.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
