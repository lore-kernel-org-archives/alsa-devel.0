Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63609C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:44:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB2064E07
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB2064E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62B3416B0;
	Sat,  6 Feb 2021 21:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62B3416B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612644283;
	bh=T1jLO24sF0pYkT3lQr2onlwV1fj0AbfnrcXXdUAochg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vm1Q1a52Ioz8yBdcTrJD99tZFN7gBuNDOx3S/Gg2e1LGslANMjG4xSWVTMPVxe/bL
	 Z7yEClqiPvWVr963fGeqrVaOCADGTpwvf9NX5CqLgz8VCOS1CXz0Wy9ykivQ1XQ9Pr
	 SjSB6WHHPGqbyNJoXqUDsINmmTbt2GBu1sS9N+h8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E667BF804EC;
	Sat,  6 Feb 2021 21:39:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F3B0F8021D; Fri,  5 Feb 2021 15:04:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E397F8015A
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 15:04:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E397F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="BZOBBDws"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E5C64FC9;
 Fri,  5 Feb 2021 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612533851;
 bh=T1jLO24sF0pYkT3lQr2onlwV1fj0AbfnrcXXdUAochg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BZOBBDws+/yhmPTxNLP4zonarclKLQMtK4MPPXtDYExmUzHRLjxXcJnfGq14VQa4L
 yZhVB9oNHiU0DzaVx6si8j0aXHMHTj1MM3VS8xDsEeLmU5/b+5mHQBkgW7cT1CQKhX
 bLMDr8tZSM1SipNLwaZFpx+i2Ki4uOTJ99+ziw0o=
Date: Fri, 5 Feb 2021 15:04:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] coresight: etm4x: Fix merge resolution for amba rework
Message-ID: <YB1QWFWPennQZmjw@kroah.com>
References: <20210205130848.20009-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210205130848.20009-1-uwe@kleine-koenig.org>
X-Mailman-Approved-At: Sat, 06 Feb 2021 21:39:08 +0100
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Eric Anholt <eric@anholt.net>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig.org@pengutronix.de>,
 linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Mike Leach <mike.leach@linaro.org>, linux-watchdog@vger.kernel.org,
 alsa-devel@alsa-project.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 coresight@lists.linaro.org, Vladimir Zapolskiy <vz@mleia.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Mark Brown <broonie@kernel.org>,
 Matt Mackall <mpm@selenic.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, Alessandro Zummo <a.zummo@towertech.it>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Leo Yan <leo.yan@linaro.org>, dmaengine@vger.kernel.org
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

On Fri, Feb 05, 2021 at 02:08:47PM +0100, Uwe Kleine-König wrote:
> This was non-trivial to get right because commits
> c23bc382ef0e ("coresight: etm4x: Refactor probing routine") and
> 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
> changed the code flow considerably. With this change the driver can be
> built again.
> 
> Fixes: 0573d3fa4864 ("Merge branch 'devel-stable' of git://git.armlinux.org.uk/~rmk/linux-arm into char-misc-next")
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Now queued up, thanks!

greg k-h
