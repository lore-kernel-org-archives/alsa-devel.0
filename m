Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93057C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:40:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF6564E52
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF6564E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90B871693;
	Sat,  6 Feb 2021 21:40:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90B871693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612644053;
	bh=05Tu6gC1988yql3jwqZ8bSalZpjvaviDpH2tuIfYvRM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0xMbHBQ7U5TRRctGb8ShUEUQDyc7oz/diriTSZxfCh2gIe5Zd7mEdqqvkupQzol4
	 6Tnu2sZ8Iju2qAKhZnPcw4h8BEf4ZsECplU2N6zUbdFqsUzGRAZ4AIfWGI1urLaW2O
	 qHvYPua8FvPfy6m+chYj73r3BpALOy+eKTg9sgqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6918BF800B8;
	Sat,  6 Feb 2021 21:39:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A421F80152; Thu,  4 Feb 2021 17:57:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80FBFF80152
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 17:56:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80FBFF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="V/2phKRB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3066164F47;
 Thu,  4 Feb 2021 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612457813;
 bh=05Tu6gC1988yql3jwqZ8bSalZpjvaviDpH2tuIfYvRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V/2phKRBrdShTJynlnGGMW3l9x/SW1hWhKF8xex4OBeo3mDEeK0o2kKM2vS0bAe4F
 Wdi0g4ASLrOIJhcENuzivXIyn+HAG/m8sXtb1YJRFkCDu6LHLMMfsvATC2CS2VT9DI
 IeA8zLWPa9FQgRD8cqb7Rt1bnqdVVBXlJNczgsbo=
Date: Thu, 4 Feb 2021 17:56:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [GIT PULL] immutable branch for amba changes targeting v5.12-rc1
Message-ID: <YBwnUrQqlAz2LDPI@kroah.com>
References: <20210126165835.687514-1-u.kleine-koenig@pengutronix.de>
 <20210202135350.36nj3dmcoq3t7gcf@pengutronix.de>
 <YBlcTXlxemmC2lgr@kroah.com>
 <20210204165224.GA1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204165224.GA1463@shell.armlinux.org.uk>
X-Mailman-Approved-At: Sat, 06 Feb 2021 21:39:03 +0100
Cc: linux-fbdev@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 kvm@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig.org@pengutronix.de>,
 linux-i2c@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 David Airlie <airlied@linux.ie>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Mike Leach <mike.leach@linaro.org>, linux-watchdog@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 coresight@lists.linaro.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Vladimir Zapolskiy <vz@mleia.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Mark Brown <broonie@kernel.org>,
 Matt Mackall <mpm@selenic.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
 kernel@pengutronix.de, Leo Yan <leo.yan@linaro.org>, dmaengine@vger.kernel.org
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

On Thu, Feb 04, 2021 at 04:52:24PM +0000, Russell King - ARM Linux admin wrote:
> On Tue, Feb 02, 2021 at 03:06:05PM +0100, Greg Kroah-Hartman wrote:
> > I'm glad to take this through my char/misc tree, as that's where the
> > other coresight changes flow through.  So if no one else objects, I will
> > do so...
> 
> Greg, did you end up pulling this after all? If not, Uwe produced a v2.
> I haven't merged v2 yet as I don't know what you've done.

I thought you merged this?

Did you take v1?

I am totally lost here...

thanks,

greg k-h
