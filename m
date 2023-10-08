Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E380FE95A8E
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Oct 2023 05:17:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 042CD91;
	Sun,  8 Oct 2023 07:16:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 042CD91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696742242;
	bh=EWfEySMIHcEZpgZcolTZHLTL0n7Z1fa2Lb39mIDJ4D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MqhIsUDVhnPkFfz0zAyA5EqnUdyATGllLQELDgxiHTscm0Aa4M/Dy+Yl0NDSY/yTS
	 tRRBHHCBLCREqFtfeKNR3vaxZPC4BYvNfOxWAdnjaySNgDDjKY20GU34Pv6vd45T2o
	 s2QJe8SIseEkT6QnqDgfewMCbPHQYfA9mfjlkV60=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E69FCF8027B; Sun,  8 Oct 2023 07:16:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DC23F8019B;
	Sun,  8 Oct 2023 07:16:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2977F802BE; Sun,  8 Oct 2023 07:05:16 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A176AF8019B
	for <alsa-devel@alsa-project.org>; Sun,  8 Oct 2023 07:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A176AF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=w1H0jrg9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C1474CE092F;
	Sun,  8 Oct 2023 05:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90216C433C7;
	Sun,  8 Oct 2023 05:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696741481;
	bh=EWfEySMIHcEZpgZcolTZHLTL0n7Z1fa2Lb39mIDJ4D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w1H0jrg9m3TkWpRkDm1nTyZaxroCotWXSuwEx5MvI3c1hOJoa6UCIRN1HQBBDoy4a
	 +XnTGmEBX+tUqTBNT58HakOasGrin9fDR76BhvHLS1tb6oJrW3ugUz9iRZiM1qiQSD
	 rpqVbuqtlSHCWT6L6T0iAaKaaAZ0huaNv8mntaFw=
Date: Sun, 8 Oct 2023 07:04:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Message-ID: <2023100811-shakable-derby-0b91@gregkh>
References: <20231007213820.376360-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007213820.376360-1-jmkrzyszt@gmail.com>
Message-ID-Hash: SQZMYPKPM7U7UQVXNHT66RKTDFDFVOTJ
X-Message-ID-Hash: SQZMYPKPM7U7UQVXNHT66RKTDFDFVOTJ
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SQZMYPKPM7U7UQVXNHT66RKTDFDFVOTJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, Oct 07, 2023 at 11:38:18PM +0200, Janusz Krzysztofik wrote:
> Since types of arguments accepted by tty_ldis_ops::receive_buf() have
> changed, the driver no longer builds.
> 
> .../linux/sound/soc/ti/ams-delta.c:403:24: error: initialization of 'void (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const unsigned char *, unsigned int)'} from incompatible pointer type 'void (*)(struct tty_struct *, const u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const char *, int)'} [-Werror=incompatible-pointer-types]
>   403 |         .receive_buf = cx81801_receive,
> 
> Fix it.
> 
> Fixes: e8161447bb0c ("tty: make tty_ldisc_ops::*buf*() hooks operate on size_t")
> Fixes: 892bc209f250 ("tty: use u8 for flags")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  sound/soc/ti/ams-delta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Odd no built-bots caught this, maybe no one normally builds this file?
Anyway, I'll pick this up in my tty tree now, thanks!

greg k-h
