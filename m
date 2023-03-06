Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715B3C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 17:49:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AF63118C;
	Mon,  6 Mar 2023 18:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AF63118C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678124966;
	bh=gS13Pi8NIZfYbbwqKoWFz+JaetXsKjXOR4Yv4pYVBmE=;
	h=Date:From:To:Subject:In-Reply-To:References:CC:Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i6x4UffyS0LNkvvVCyfpRHwsGl0USjoaFVcpGv5LeuHnxesD/U8dZfbqZNaKd1TLK
	 wm9lqYLwaqHp3fkdwIs6WKIN2CLdxGOXDUfGCp8SD+WRSHW+o+yVcxfzTLVy1HNjve
	 P7T6XyFGjXZoUMlJ2Vw7GzVq4leOHpg1fFqF/qX0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54CF0F8058C;
	Mon,  6 Mar 2023 18:42:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73492F8042F; Mon,  6 Mar 2023 09:17:12 +0100 (CET)
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9615EF8007E
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 09:16:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9615EF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=protonic.nl header.i=@protonic.nl header.a=rsa-sha256
 header.s=202111 header.b=oDYibHiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=message-id:references:in-reply-to:reply-to:subject:cc:to:from:date:
	 content-transfer-encoding:content-type:mime-version:from;
	bh=iGJBerep9CUnwc0kKc070FLg5wgjahdY5flMGzZYQMs=;
	b=oDYibHiF3QQbdSnLfVFRXWqS6z3NQmb6kugL8YV+AzvXesLHyr5JzoQv36TlUtoc6W5KCotN1l9wN
	 9LSOB4Bu9Yfgb0XpMplMCVfXibebalo7a5aESxI1lFy0L3DA6RZo6UFgR79W8gl98jQrxQ/tLvd2T2
	 0xEQnuRgzH1ORWF+wpRq+raboR/TqFqi3nosbBYytoNMkARO5GE2FASMRvbgozacXT968pNevzID08
	 kd2Bb6hh7pzuv819gTpRFHFjwmhc4+RnlmqnZW8aNjXY3z24ty79Y1uQG7spYocRbf484LhNNLEwf4
	 6CAVA7hl0v6jQA7FXN1mdH2h85/uHYw==
X-MSG-ID: 412d5329-bbf7-11ed-829c-0050569d2c73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 06 Mar 2023 09:16:54 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix SPI and I2C bus node names in examples
Organization: Protonic Holland
Mail-Reply-To: robin@protonic.nl
In-Reply-To: 
 <CANiq72mm9qX8uuS2y_vvtcza2hAgG3zFEy24koQTfSEOWkKDYQ@mail.gmail.com>
References: <20230228215433.3944508-1-robh@kernel.org>
 <CANiq72mm9qX8uuS2y_vvtcza2hAgG3zFEy24koQTfSEOWkKDYQ@mail.gmail.com>
Message-ID: <61190cb766083d73ef3b1455dcf3ff61@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.1 
X-MailFrom: robin@protonic.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JDJSELDVLT2HBOOG3LAWEO33WL4DSI24
X-Message-ID-Hash: JDJSELDVLT2HBOOG3LAWEO33WL4DSI24
X-Mailman-Approved-At: Mon, 06 Mar 2023 17:42:40 +0000
CC: devicetree@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
Reply-To: robin@protonic.nl
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JDJSELDVLT2HBOOG3LAWEO33WL4DSI24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> From: Rob Herring <robh@kernel.org>
> Date: Tue, Feb 28, 2023 at 10:54 PM
> Subject: [PATCH] dt-bindings: Fix SPI and I2C bus node names in 
> examples
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
> Benson Leung <bleung@chromium.org>, Guenter Roeck
> <groeck@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda
> <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
> Robert Foss <rfoss@kernel.org>, Thierry Reding
> <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, MyungJoo
> Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
> Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
> <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>, Lee Jones
> <lee@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, David S.
> Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
> Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
> Wolfgang Grandegger <wg@grandegger.com>, Kalle Valo
> <kvalo@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown
> <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
> <linux-gpio@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
> <linux-leds@vger.kernel.org>, <linux-media@vger.kernel.org>,
> <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
> <linux-wireless@vger.kernel.org>, <linux-pm@vger.kernel.org>,
> <alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>
> 
> 
> SPI and I2C bus node names are expected to be "spi" or "i2c",
> respectively, with nothing else, a unit-address, or a '-N' index. A
> pattern of 'spi0' or 'i2c0' or similar has crept in. Fix all these
> cases. Mostly scripted with the following commands:
> 
> git grep -l '\si2c[0-9] {' Documentation/devicetree/ | xargs sed -i -e
> 's/i2c[0-9] {/i2c {/'
> git grep -l '\sspi[0-9] {' Documentation/devicetree/ | xargs sed -i -e
> 's/spi[0-9] {/spi {/'
> 
> With this, a few errors in examples were exposed and fixed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-can@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> ---
>  .../bindings/auxdisplay/holtek,ht16k33.yaml       |  2 +-

....

>  86 files changed, 110 insertions(+), 103 deletions(-)
> 
> diff --git 
> a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> index fc4873deb76f..286e726cd052 100644
> --- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> +++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> @@ -72,7 +72,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/input/input.h>
>      #include <dt-bindings/leds/common.h>
> -    i2c1 {
> +    i2c {
>              #address-cells = <1>;
>              #size-cells = <0>;

Acked-by: Robin van der Gracht <robin@protonic.nl>
