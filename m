Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823C9C636CC
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Feb 2023 12:39:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B3B5829;
	Wed,  8 Feb 2023 13:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B3B5829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675859962;
	bh=PtUGvcL546L0v/loGFSmFEqt88gZUHeSRWmtYZVhJbA=;
	h=Subject:From:To:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iXCn8eo2dhq6J/zBKY4P+6hw66/paMLK11mFHB+qXhneY3myAx15xPmSglQL+KNJp
	 XWYg4m0DXdq2vdacVV2XBAtkiMLmOOmDfvl6H6WDNqNt0oU84EjTCGQychks272RFO
	 KCZ+QxUDvWt+1XOXXt5w7MAPRwpCLDEBQTPLR/Xg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFE96F80152;
	Wed,  8 Feb 2023 13:38:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEFDFF80152; Wed,  8 Feb 2023 13:38:03 +0100 (CET)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CDD59F80095
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2023 13:37:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDD59F80095
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pPjhm-002HdN-3f; Wed, 08 Feb 2023 13:37:42 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100]
 helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pPjhl-000IqT-Oa; Wed, 08 Feb 2023 13:37:42 +0100
Message-ID: 
 <91be7f6b52d8ed74798e86270d59bc5cddefe130.camel@physik.fu-berlin.de>
Subject: Re: remove arch/sh
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 08 Feb 2023 13:37:40 +0100
In-Reply-To: 
 <CAAhV-H57bV855SMr6iBqoQzdak5QSnaRLjQ9oAbOtYZnik5SoQ@mail.gmail.com>
References: <20230113062339.1909087-1-hch@lst.de>
	 <11e2e0a8-eabe-2d8c-d612-9cdd4bcc3648@physik.fu-berlin.de>
	 <20230116071306.GA15848@lst.de>
	 <40dc1bc1-d9cd-d9be-188e-5167ebae235c@physik.fu-berlin.de>
	 <20230203071423.GA24833@lst.de>
	 <60ed320c8f5286e8dbbf71be29b760339fd25069.camel@physik.fu-berlin.de>
	 <0e26bf17-864e-eb22-0d07-5b91af4fde92@infradead.org>
	 <f6317e9073362b13b10df57de23e63945becea32.camel@physik.fu-berlin.de>
	 <CAAhV-H57bV855SMr6iBqoQzdak5QSnaRLjQ9oAbOtYZnik5SoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
Message-ID-Hash: UTUIZKBE654GYEXBPMM5LMUMCMSOC55D
X-Message-ID-Hash: UTUIZKBE654GYEXBPMM5LMUMCMSOC55D
X-MailFrom: glaubitz@zedat.fu-berlin.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arch@vger.kernel.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sh@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTUIZKBE654GYEXBPMM5LMUMCMSOC55D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Huacei!

On Wed, 2023-02-08 at 20:24 +0800, Huacai Chen wrote:
> Emm, maybe this patch has its chance to be merged now. :)
>=20
> https://lore.kernel.org/linux-sh/CAAhV-H6siOtVkZpkS4aABejgZCqTwp3TihA0+0H=
GZ1+mU3XAVA@mail.gmail.com/T/#u

Yes, that's the plan. We're collecting the various patches people have sent
in for arch/sh, review and test them and apply them.

My test board is running the latest kernel now, so I can test new patches, =
too.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
