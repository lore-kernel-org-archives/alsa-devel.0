Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBD2C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 08:49:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8CAA1F0B;
	Wed,  2 Mar 2022 09:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8CAA1F0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646210986;
	bh=xNZESzUMzSuk4pAAHRceX1seRWJe9glE5ZOBVSMu+ss=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dChpPYscQE4DkklN7B4/cwAbS2HEnhAuRzEYoZx91nbJjlQ8Shoys9AJnq7Nr+Xap
	 KFtgMj6IlnNsR1LARBH7UtZAApxECKzZ5gi+mWif+qNLai36ggk2ws7bcCNQr5Wb8C
	 qKyTSG5yGYd6aDBx3Q5JaF33aDaycKOADd+Q4L3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 987E0F80678;
	Wed,  2 Mar 2022 09:34:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DC37F8013C; Mon, 28 Feb 2022 22:45:49 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BBBAF800F8
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 22:45:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BBBAF800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kJsao+0j"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B445B81680;
 Mon, 28 Feb 2022 21:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9C7C340EE;
 Mon, 28 Feb 2022 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646084744;
 bh=xNZESzUMzSuk4pAAHRceX1seRWJe9glE5ZOBVSMu+ss=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kJsao+0jIAu7AXGo4SmZExZXCVdAMoRdI6X/QYb0Jwx69nV5AXxk1KuFrkvkDoBZ8
 wynJf7Ejzi16ZoB5fMgRDwbiZpcd+/EAx5d25F81iwujuU137kggTAu/Ouyhd6mslo
 qE1lWNqd/NvyYxD/oyrvBcmlF7sWhF0wdtNX9KoO9XakbyKPyrNllh+oB1O7BVNSpF
 dyjcppCe9nJobXDjDDRHaOnC4Y5GBT+Wrmd/cpxS8p7+CGMPMv3PCmgoM8Ae/0ptaI
 3jM8TnpXM4NyIeR9REsX9YfQPND5nJKX1ATaS1f6IV2RiEh5xRTMvwe/eiEwfX2qu8
 OnaqJZkVhHwKA==
Date: Mon, 28 Feb 2022 22:45:34 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Another pass removing cases of 'allOf'
 containing a '$ref'
Message-ID: <20220228224534.073ca78a@thinkpad>
In-Reply-To: <20220228213802.1639658-1-robh@kernel.org>
References: <20220228213802.1639658-1-robh@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Mar 2022 09:33:34 +0100
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sebastian Reichel <sre@kernel.org>, linux-phy@lists.infradead.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guenter Roeck <groeck@chromium.org>, Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Richard Weinberger <richard@nod.at>, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-input@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 28 Feb 2022 15:38:02 -0600
Rob Herring <robh@kernel.org> wrote:

> Another pass at removing unnecessary use of 'allOf' with a '$ref'.
>=20
> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed
> in the 2019-09 json-schema spec and '$ref' can be mixed with other
> keywords.

For Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml

Acked-by: Marek Beh=C3=BAn <kabel@kernel.org>
