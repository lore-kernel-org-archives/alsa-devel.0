Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97128C00140
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Aug 2022 20:43:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED6FC827;
	Mon,  8 Aug 2022 22:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED6FC827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659991398;
	bh=t++XgnhLpv27KJOpbODDaqF5DAh0hBGx64LosYqpeuo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4G8eVkuyFfyfwZSntTqUi7TG7Qxtr+AUpr0l409H+dOZQKNuoOQMWrXVgF25vdBJ
	 CT0ZtHS/GO1ZstYyaqnQZr1v9yjcn0NApuzpCYOF86qFMx9tLzPphgoC8iI8ITWRtn
	 NHQ3BtQNA330IIJhx6sBTCJraxLfFBiFt5CBaEh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76955F8012B;
	Mon,  8 Aug 2022 22:42:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58404F8049C; Mon,  8 Aug 2022 22:42:25 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4342EF8012B
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2022 22:42:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4342EF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.b="Pfpag1Q+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=ZgX1+MCfF/NQe7YV4mbEzfn++YyLm+UWvyG7V14DLis=; b=Pfpag1Q+1mAb5ZtJYQawOMXgQn
 OZvFLMYkavguq+1zGabZnEWkneHoBQqVWWji7PZvNWv+BItB0EceSVLsNHS+hpPDDWmHKeaZ7rIaT
 q8JaLhyby8v1vHiyXONUKSr2NVY9gZxB9xxWkt9jvn81d+w4Oj1pAORjRrL7HKZin3eE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1oL9Yv-00ClV1-To; Mon, 08 Aug 2022 22:41:21 +0200
Date: Mon, 8 Aug 2022 22:41:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 5/5] dt-bindings: Drop Dan Murphy
Message-ID: <YvF08ft7GiXr6Hd2@lunn.ch>
References: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
 <20220808104712.54315-6-krzysztof.kozlowski@linaro.org>
 <43b3c497-97fd-29aa-a07b-bcd6413802c4@linaro.org>
 <6ae15e00-36a4-09a8-112e-553ed8c5f4da@ti.com>
 <YvFtJRJHToDrfpkN@lunn.ch>
 <8b577a8e-26e3-c9db-dae1-7d74fc3334ad@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b577a8e-26e3-c9db-dae1-7d74fc3334ad@ti.com>
Cc: linux-fbdev@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-pm@vger.kernel.org,
 Tim Harvey <tharvey@gateworks.com>, Mark Brown <broonie@kernel.org>,
 linux-hwmon@vger.kernel.org, Robert Jones <rjones@gateworks.com>,
 netdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
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

> I'm not seeing his name in the latest MAINTAINERS, seem they all got
> dropped in 57a9006240b2.

Ah, great.

And there does not appear to be a MAINTAINERS entry for any of the TI
PHYs, so giving the correct impression they are without a Maintainer.

	Andrew
