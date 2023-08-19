Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF26EE49A0
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Aug 2023 02:48:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 919CBED7;
	Sat, 19 Aug 2023 04:47:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 919CBED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692413317;
	bh=oU+6WMg6c2UrnTMLgklxjc7ykpSmhNqopEee8qwkVPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XKyDwiCze+g5nfPXKZSOQmeOzZ0ohnkeN8l/n9BbilD9+LvoAI1w4GFX865pxYwDl
	 JUfdpGAzcDPdPP7whPiQswC7BxViEg/0ZhxehOCefytLGTf4zL7vr6BbrVphdW7BHt
	 K0vrE7zByP/hB6DsvWhUcuutTLmcg8ahsuuJam0M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B0F2F80536; Sat, 19 Aug 2023 04:47:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CC66F801EB;
	Sat, 19 Aug 2023 04:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76DCAF801EB; Sat, 19 Aug 2023 04:47:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D1E3F8016A
	for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2023 04:47:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D1E3F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UA/UNvXw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B1A5D6303B;
	Sat, 19 Aug 2023 02:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3ADC433C7;
	Sat, 19 Aug 2023 02:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413221;
	bh=oU+6WMg6c2UrnTMLgklxjc7ykpSmhNqopEee8qwkVPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UA/UNvXwmLrhSEAhg7lPYmOjNAVVkUkN9pybSImmVxT+0lHuWrCcaZDmCSoYrvjyf
	 YhhI8bWGwgB+/99XZjtcruhpCWdBrpxn6MzuLWby7GqJRFG8rl8Cp+0RQ1VUqQk3jF
	 mEoMvMZpzs2YDyofEWA2JeQE+79wztJn67eSs7aVEPegNN3LeoWHQEXUhIZblTGeku
	 CuQQZAb6wJZuVe6I1lmEZcIgOQSfklhXfzmvPyJ2w9ky5Jtg3bfDWdjkqgDwrb5fbq
	 HkwvaKBtm+RCRcUr1M0AFhFV57+Nb9oY7HsEgtMxvTIkF/G+3ZTn+MWUggMWo2BOeq
	 9NRqhAAGGxXfw==
Date: Fri, 18 Aug 2023 19:46:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Message-ID: <20230818194658.369da77a@kernel.org>
In-Reply-To: 
 <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
	<5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: MA6ICREJRLTAOTY4A2YDUDOCQTYVD5C4
X-Message-ID-Hash: MA6ICREJRLTAOTY4A2YDUDOCQTYVD5C4
X-MailFrom: kuba@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MA6ICREJRLTAOTY4A2YDUDOCQTYVD5C4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 18 Aug 2023 18:39:15 +0200 Christophe Leroy wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.

Okay, progress is being made, now it builds patch by patch.
Still some kdoc warnings remain (W=1 build only catches
kdoc warnings in sources, you gotta run ./scripts/kernel-doc -none
explicitly on the headers):

include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_E1' not described in enum 'framer_iface'
include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_T1' not described in enum 'framer_iface'
include/linux/framer/framer.h:35: warning: expecting prototype for enum framer_clock_mode. Prototype was for enum framer_clock_type instead
include/linux/framer/framer.h:47: warning: expecting prototype for struct framer_configuration. Prototype was for struct framer_config instead
include/linux/framer/framer.h:60: warning: cannot understand function prototype: 'enum framer_event '
include/linux/framer/framer.h:89: warning: Function parameter or member 'notify_status_work' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'notifier_list' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'polling_work' not described in 'framer'
-- 
pw-bot: cr
