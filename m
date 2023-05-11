Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB30C7EE22
	for <alsa-devel@archiver.kernel.org>; Thu, 11 May 2023 05:17:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BB63FA3;
	Thu, 11 May 2023 07:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BB63FA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683782223;
	bh=iFUpQ4D07YSZNO0RTuCRy1luLl+VzUEaBiyc3WJiu8c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aRWGmhwDoa3lvJnGnG5NJMZP8si9v/TzFIok4tc4xDKZM4JFuEHCrTUQ2whRTxSl7
	 hjaQ7gc+kGkLJdImD0jG7SwVZlrGTtuKx9NawLMJ+/myhECDJk3FYbXP/S8U8bHGck
	 yhHayG7nAbir0uCPRjqT3d7niTNzvvoyLjxsDsHo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCAAEF8032D;
	Thu, 11 May 2023 07:16:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2362EF802E8; Thu, 11 May 2023 07:12:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57730F802E8
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2023 07:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57730F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UE1segLW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8645563442;
	Thu, 11 May 2023 05:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA92C433D2;
	Thu, 11 May 2023 05:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683781843;
	bh=iFUpQ4D07YSZNO0RTuCRy1luLl+VzUEaBiyc3WJiu8c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UE1segLWGdZbdEoQ77McrCIOz+FbLlRdwBaCxQsiLp1itu+lnIlvUf5VtI77lCHJH
	 UZIG/AMgKf+Mtt7cGCwyIddO8DVWEZL6Mb6UCzo5n8QRNgpW42hKNKPmMpPMgNo09d
	 Sf8UNSMDpYocIjWpWS/nUWnqa37xWTlUKMPDqEf3eEQ/8CzS454nCsE5SVacdf5XTt
	 StKTJyYJI8Zjf/giCk01Z4zfiHAxTrpGRf2ja174uFeXSq2N7Z7r25cCKoRUFTxf/j
	 rDaAu8kquFwDB5pugszTWO5t7y9KnOxA96dK6ycKIm8yJ1Q0nWdk+WhWEx/W09ggdp
	 GmdWVFzf+fNow==
Date: Thu, 11 May 2023 06:10:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Walker Chen <walker.chen@starfivetech.com>
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
User-Agent: K-9 Mail for Android
In-Reply-To: <ef13177a-2028-9fc9-628a-e3d287758207@starfivetech.com>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-4-walker.chen@starfivetech.com>
 <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com>
 <20230509-overheat-pliable-00d60523637e@spud>
 <CAJM55Z9AxMVw=ymfFBb=45nODq89O8dMebzRgo-XD0GKduDBYg@mail.gmail.com>
 <f27b7ee7-f23a-35a2-3b82-71f50871dfcc@starfivetech.com>
 <20230510-riveter-ridden-3f056251e623@spud>
 <ef13177a-2028-9fc9-628a-e3d287758207@starfivetech.com>
Message-ID: <CE38599D-24DF-4FD4-8CDF-F1A70673B972@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: MIN5S2CO4GI4ZLFEYB3REAQAD22GKFTK
X-Message-ID-Hash: MIN5S2CO4GI4ZLFEYB3REAQAD22GKFTK
X-MailFrom: conor@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MIN5S2CO4GI4ZLFEYB3REAQAD22GKFTK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>




>I'm trying to understand what you mean=2E so the conclusion is that I nee=
d to drop the file
> 'jh7110-starfive-visionfive-2-wm8960=2Edtso' from this patch=2E
>When I submit the next version, just keep the TDM node and the pins confi=
guration for TDM in patch [3/3],
>need to drop the wm8960 stuff=2E
>Right ?

Yes=2E

>
>Best regards,
>Walker
