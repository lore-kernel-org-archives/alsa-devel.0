Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05B7CE7A86
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Sep 2023 21:23:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4AD4BC0;
	Fri, 22 Sep 2023 23:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4AD4BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695417829;
	bh=lmE8y4Naioq26myIwcGDskn3NlpSCo/s3ZeWn2dloK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ORSe8AVayujdV6vmFh9YDEZzbicQBBj0aG48OOgAROkhCpDjAp8sl0lS7+Z7J8oYD
	 a/Wi2X1soQx52Zmnuq43O0A976YiqqCQQTlVlX7Fis9I/0bLxJ7Wl5A6hz09S7Ey1m
	 Ffd6HOk7bbhz28xyLpatXZgxBtVDEwxAW/ei0itc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5B04F80125; Fri, 22 Sep 2023 23:22:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1246BF80125;
	Fri, 22 Sep 2023 23:22:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96619F80125; Fri, 22 Sep 2023 23:22:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BC23EF80005
	for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2023 23:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC23EF80005
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Nv4Cz9sw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2789562381;
	Fri, 22 Sep 2023 21:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FFC433C8;
	Fri, 22 Sep 2023 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695417737;
	bh=lmE8y4Naioq26myIwcGDskn3NlpSCo/s3ZeWn2dloK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv4Cz9sw3ckJXfg8gZo7FWOFFfqKqYySpjfLY7cZhQEb3LyIpaBvywrHA5M7C21Gc
	 mcsEqkC8cx13Dy8R/0X9lYJTpyRNr1qeElcsH00EHluLpOe3wRmDsUaEfIDdc00HgN
	 YZ5dnQxIkGqFegnvjx8fmrE8SjNnqVDUNMtF6lnOb5ybGvy1egpqEP36TNfvlgqqAO
	 kv5OnNDigOmYh5tnIGwghQpSuqDTEEDzwtyzW8MsyYi2xdU3YdARgKPEIx0roJsDT1
	 QMAlycnsTsH07IM9iuVX100coPa5Ms77i08JVt5XAfgf3pojKcODfR7zRW+tGBrVPO
	 6Cus0vP5Brspw==
Received: (nullmailer pid 3638530 invoked by uid 1000);
	Fri, 22 Sep 2023 21:22:12 -0000
Date: Fri, 22 Sep 2023 16:22:12 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Krzysztof K
 ozlowski <krzysztof.kozlowski+dt@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v6 08/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <169541773236.3638470.1013241809358556101.robh@kernel.org>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-9-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922075913.422435-9-herve.codina@bootlin.com>
Message-ID-Hash: BB5ASBYBFBQOOQIJSV7CS3Q3NQVWYKGV
X-Message-ID-Hash: BB5ASBYBFBQOOQIJSV7CS3Q3NQVWYKGV
X-MailFrom: SRS0=kpay=FG=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BB5ASBYBFBQOOQIJSV7CS3Q3NQVWYKGV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 22 Sep 2023 09:58:43 +0200, Herve Codina wrote:
> The QMC (QUICC mutichannel controller) is a controller present in some
> PowerQUICC SoC such as MPC885.
> The QMC HDLC uses the QMC controller to transfer HDLC data.
> 
> Additionally, a framer can be connected to the QMC HDLC.
> If present, this framer is the interface between the TDM bus used by the
> QMC HDLC and the E1/T1 line.
> The QMC HDLC can use this framer to get information about the E1/T1 line
> and configure the E1/T1 line.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

