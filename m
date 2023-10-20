Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E01C001DF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Oct 2023 13:15:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9517BC0;
	Fri, 20 Oct 2023 15:14:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9517BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697807719;
	bh=e+jCIUxM299jy/aru3/WUYQ3hdOvk7PCPjNY+dX+gIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BM87hT+LlHg0j//J7Tm6iXeqqtfzYXYfX4gzRGb81GF01EPNZskecyOakTRJe9xw6
	 3eYX4djHbvuvn9yq+bsQ7RdKOfeEm20CFkdW/H5oG5DKT4Y9uVB1JygXB07ARbkwKJ
	 4TZfOISJsxPWTjf1i1XGingGSMdyqOrTHIlI/pdk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01DDBF805B3; Fri, 20 Oct 2023 15:12:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4C41F805B3;
	Fri, 20 Oct 2023 15:12:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0754CF8025F; Fri, 20 Oct 2023 15:00:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 55F33F800C9
	for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2023 15:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55F33F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=DuXl/kKy
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87B5E61297;
	Fri, 20 Oct 2023 13:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F6AC433C7;
	Fri, 20 Oct 2023 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697806819;
	bh=e+jCIUxM299jy/aru3/WUYQ3hdOvk7PCPjNY+dX+gIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuXl/kKylLhoWxLMCDMS2vR2WBWxRi7IO7/klLXO4i/JlfCj1zD4Oilf4A/gTiZGN
	 7nEG528E/Pn5EEsgkT0yO0nDt7hNd5rfnu655OOxYll5/I8yc0Mj0d+Gc9fO+2OcZL
	 Q3GqyQ8njX+lRH1IXMfqb3yqGPNg29EFg6ReyHGA=
Date: Fri, 20 Oct 2023 09:00:18 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>,
	Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ALSA: change mailing list to linux-sound on
 vger
Message-ID: <20231020-tightwad-caddie-962412@meerkat>
References: <20231020071247.973909-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020071247.973909-1-perex@perex.cz>
X-MailFrom: konstantin@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4VZVXIIP3VEPDIB34T76PGSCIXYJTA4L
X-Message-ID-Hash: 4VZVXIIP3VEPDIB34T76PGSCIXYJTA4L
X-Mailman-Approved-At: Fri, 20 Oct 2023 13:12:23 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4VZVXIIP3VEPDIB34T76PGSCIXYJTA4L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Oct 20, 2023 at 09:12:47AM +0200, Jaroslav Kysela wrote:
> As discussed on alsa-devel mailing list [1], it is useful to have an open
> mailing list to avoid moderation delays for the kernel patch work. Use
> linux-sound mailing list for kernel driver related threads.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K
