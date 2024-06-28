Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EFBC2BD09
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:57:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62786231C;
	Fri, 28 Jun 2024 20:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62786231C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719601023;
	bh=nbZ4B4IuGzfJbPVBIOmAq3RdE0TDLUZCXRFXhHZu+Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yn+UPgLk+aVYVq9JTDMWiSZx13WNzacDd/iVLm5VYJ1uUkT83lPzubyh011NgVjQx
	 aRxoGyz1EsjiGV77CWROdjgWyO6AW8bR/5Lz9cXjKYtM6CPwBU/jZGiM/hUOs0Ax0t
	 D2r4i8OSpeV6o0+4BVQpP/qilizKMK81a3niFcoU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F29F9F805AF; Fri, 28 Jun 2024 20:56:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 966F5F805B5;
	Fri, 28 Jun 2024 20:56:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DBF3F80423; Fri, 28 Jun 2024 20:56:19 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6057CF800E4
	for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2024 20:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6057CF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gJshG7sA
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 46B67CE4292;
	Fri, 28 Jun 2024 18:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C38C32786;
	Fri, 28 Jun 2024 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600967;
	bh=nbZ4B4IuGzfJbPVBIOmAq3RdE0TDLUZCXRFXhHZu+Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJshG7sAzkli8Ku4dDLbq7WqEPiAmGjfjwS28P42WdkkeNjV0Dv68mtlkPn0X5+lb
	 gEZ02GOVBsAKsO5kxHT/coAxwFlaZw2cLlsD/ov7y3OTYuEydLxB+JDNuh2cbapWRF
	 1cyXqblStMzwyVWxPEGmXln/zF4/nqXdjdare73iQaMZ7e3jiQMaH0jYHUEoE/zg7I
	 D4F3LwVxJ3UW9AAJMSqJxdOiMxwu8m8ACWjkGD9T4Tt307HkAUuqI5WNfQBLZNBPio
	 DUKs9kBsfNRZqvCfYv8kNxjk3fyxYmUFQJpBY2c8b4JdOKuT7rVL/++GMctkEX+ahY
	 4znbyfQH/3NXA==
Date: Fri, 28 Jun 2024 19:55:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on
 dfsdm audio port
Message-ID: <20240628195558.121de053@jic23-huawei>
In-Reply-To: <171952014620.474983.15354726969773132715.robh@kernel.org>
References: <20240618115912.706912-1-olivier.moysan@foss.st.com>
	<171952014620.474983.15354726969773132715.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JEBJ4A4XPRFWV4KANBOVZOOK3RBQBX5H
X-Message-ID-Hash: JEBJ4A4XPRFWV4KANBOVZOOK3RBQBX5H
X-MailFrom: jic23@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JEBJ4A4XPRFWV4KANBOVZOOK3RBQBX5H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 27 Jun 2024 14:29:08 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 18 Jun 2024 13:59:12 +0200, Olivier Moysan wrote:
> > Fix warnings on DFSDM dtbs check
> > Unevaluated properties are not allowed ('dfsdm-dai' was unexpected)
> > 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > Fixes: 11183ac07a74 ("dt-bindings: stm32: convert dfsdm to json-schema")
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > ---
> >  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Applied  to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

J
