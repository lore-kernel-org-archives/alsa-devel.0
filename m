Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8755EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 20:43:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 055DD82A;
	Fri, 16 Jun 2023 22:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 055DD82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686948227;
	bh=T3+Q1m60/nFd2R+tMFiJtuLhqjcPjNdeMf2banobDew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VpFGNt5AjZihYT03VWvq7XwIdH0g0sRdNflmwjkNrsVR5AgwZaLbaz1RXOImxuTHc
	 PBUsur7LdfTfMv6RmMigK8hwlD2T8Px1xTeFZN4jHSPYt4+5KH1at311BvZzEI73wB
	 uNZuRmu/hYrrEmv320H+zTCex6t59dV1YtzsoPVA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4641AF80548; Fri, 16 Jun 2023 22:42:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED38AF80149;
	Fri, 16 Jun 2023 22:42:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C92A5F80149; Fri, 16 Jun 2023 22:42:52 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 84C9AF800BA
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 22:42:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84C9AF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=HhzDn1f9
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: festevam@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B45BD80375;
	Fri, 16 Jun 2023 22:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1686948168;
	bh=a30SPrRPmvQkaTpaJvJdtMPmRuSKSp3jYsMkerwDdCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhzDn1f91jSrU0N/vjWvDrqlvqMkSkKKyocj1/IhuNPiDXkOdmu6SXpDJet4ZfNT9
	 rAflFWBKt8r04lNL5VFI6PvqyTYkZYlI01K2H2pusUZWgAKK1pqEPBJVZcRNZCLjh3
	 ryw83Ww7T7abW61vsC+MX9J4n13bOaHQVfe3nX/JUZUQvU2M6QkT0DiYu4ULhlMfRX
	 4/jv4TWrel9C0XriFxF/O6SJUA8ejdUYnN6KBqQTXX/y7ZnOCJHZWYPGlA2xnPkU8C
	 BptnVYLRWbKd1j3v/KmoQhbhsaThTxc5ffvOb7mto3NLtX6L1dzaYSGTrWgtxCQIW8
	 cuEmypputJvgQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jun 2023 17:42:48 -0300
From: Fabio Estevam <festevam@denx.de>
To: shengjiu.wang@gmail.com, broonie@kernel.org, daniel.baluta@gmail.com
Cc: alsa-devel@alsa-project.org
Subject: Re: imx8mn: Trying to get EASRC to work
In-Reply-To: <87d11267e2d93256e071ee7d86775cc7@denx.de>
References: <87d11267e2d93256e071ee7d86775cc7@denx.de>
Message-ID: <2f487267680da4e45daf1ae4587cc206@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Message-ID-Hash: JPUDNNDP7SIQAHI672Q3IES7ALCRK34S
X-Message-ID-Hash: JPUDNNDP7SIQAHI672Q3IES7ALCRK34S
X-MailFrom: festevam@denx.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JPUDNNDP7SIQAHI672Q3IES7ALCRK34S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 16/06/2023 16:39, Fabio Estevam wrote:
> Hi,
> 
> I am working on an imx8mn-based board with an ES9080 codec and I am
> trying to get
> EASCR to work. (The ES9080 driver is not upstreamed yet).
> 
> Audio playback works fine via simple-audio-card and here are my changes 
> to
> get EASRC to work:
> 
> 
> -	sound-ess {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "ess-audio";
> -		simple-audio-card,format = "left_j";
> -		simple-audio-card,frame-master = <&s2cpu>;
> -		simple-audio-card,bitclock-master = <&s2cpu>;
> -
> -		s2cpu: simple-audio-card,cpu {
> -			sound-dai = <&sai2>;
> -			dai-tdm-slot-num = <8>;

fsl-asoc-card does not take the number of slots into account.

I have sent a patch adding support for it.

Now I can get audio output and will be running more tests.

Thanks
