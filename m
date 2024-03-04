Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22AEC48BF6
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:27:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0248846;
	Mon,  4 Mar 2024 22:27:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0248846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709587647;
	bh=CzbbppJj4URu/ZwENXc/SuZfwfRp3h53NmuSsst2lhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IYZhTnGDS5JQ6PTRap9YFPIrHRLlbltPTXwh+/HcAFH7Io7CYAtIs/5Vv2V1Hbq3F
	 eDm2lQEa4cxDdoZ4RdGyFRfxFmGlBE6RebSEcdkDsY51JRDqkzIE2Pq6z4gfpesiXd
	 SirwI9o6HikKwnsARII9PnQWh7/1RNqwAI2SM3+I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F1D4F80588; Mon,  4 Mar 2024 22:26:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E66BF805A1;
	Mon,  4 Mar 2024 22:26:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BD83F801F5; Mon,  4 Mar 2024 22:26:49 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5581F802E8
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 22:26:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5581F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R3IviibI
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D736ECE1389;
	Mon,  4 Mar 2024 21:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DBC433F1;
	Mon,  4 Mar 2024 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587590;
	bh=CzbbppJj4URu/ZwENXc/SuZfwfRp3h53NmuSsst2lhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3IviibIpF8P/rEwyPHUlxmjM4bm7oKTCJ2hG5lucAODpyCpDjyIJ1rfH+Xeztw0F
	 7vgs5XFLVSC5mmLBT5k3NYBL6tMv7CPDcaEnJlRxaa4BjqXGSfLkcnGXNtRMrfiePF
	 pA/wbX6pMCvdWKePcmF5JNOVKd9TEcROjV6BWOoQCmqcthpPKTzk50ENyRWOnl4QNw
	 exoCyPJ5B6IynansJAnBc+eVZ0lTGHFB03AX6Hl5hYS9ZtOhQqdfGdrtTD26VNAPQZ
	 Cem1whi4fO4PwuON9cUh3xhN09Flhn12xqOhXyKe1nvX4zMqzDALyPIwDyXQM4hPJ3
	 blDe15l9V0YhQ==
Date: Mon, 4 Mar 2024 15:26:27 -0600
From: Rob Herring <robh@kernel.org>
To: Javier =?iso-8859-1?Q?Garc=EDa?= <javier.gar.tab@gmail.com>
Cc: Jack Yu <jack.yu@realtek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, daniel.baluta@nxp.com,
	alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: rt1015: Convert to dtschema
Message-ID: <170958758740.1075337.15453587624816097337.robh@kernel.org>
References: <20240304142315.14522-1-javier.gar.tab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304142315.14522-1-javier.gar.tab@gmail.com>
Message-ID-Hash: FZEMDC7Z6MYEFTPBBD4L6RRKFSWNROKJ
X-Message-ID-Hash: FZEMDC7Z6MYEFTPBBD4L6RRKFSWNROKJ
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FZEMDC7Z6MYEFTPBBD4L6RRKFSWNROKJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 04 Mar 2024 15:23:07 +0100, Javier García wrote:
> Convert the RT1015 Mono Class D Audio Amplifier to DT schema.
> 
> Signed-off-by: Javier García <javier.gar.tab@gmail.com>
> ---
>  .../bindings/sound/realtek,rt1015.yaml        | 41 +++++++++++++++++++
>  .../devicetree/bindings/sound/rt1015.txt      | 23 -----------
>  2 files changed, 41 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt1015.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

