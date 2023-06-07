Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF08C7EE25
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 14:57:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB721823;
	Wed,  7 Jun 2023 16:56:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB721823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686149858;
	bh=Y4B2gt5Cz2eVciMlide3N5nDQk5IkCzkT76wS3UwG9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Jt5TIfOiskgHTNVz72Y34/Qt793aCHIsKQliM8PeBinuOpzR/jXoBAVIHOyWLmIaS
	 pENo/TG1DeJndkYpk5z7NuWO5AkeFDfKQF5HyLSXp8U4GIuVMpe+QUrF2oewWcqGnM
	 LNoOCFkhylHot4HHWDnunXm0VR/a23Y6BdtnNET0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A73CF80527; Wed,  7 Jun 2023 16:56:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E62DF80199;
	Wed,  7 Jun 2023 16:56:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA03FF80199; Wed,  7 Jun 2023 16:56:15 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 835A6F80130
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 16:56:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 835A6F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=Nus40yw6
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686149766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7gbXd0RpYvnzNDsTkINk8jfZlfPM/h26L3sVpQBEA0=;
	b=Nus40yw6Ykq619bNhbiuMgDNNxhkNfmD14Z5vbLwgY6hhW6sGzQVXPz6yezJQAuibm3fVO
	USQ6p9kQVGiMdTwif/CdYD2GjvVboIox6YRehy8tDI61HntMDikWkce1PcJVgdIMcHsoj1
	SUfk2tN6yjS8jCngvcOnWfEygLeQk1nahPZvS7J0mI9gTi+53l/wpCZK7XxIQiIDL85pfH
	+Txfnc17HzzcMLgvfWxK/1bTwiA3qJ/q7eAYbsmvXXk/PizhuPbi/BAbIqXSLBGPG9uv/k
	afYTjjGKV7DIoUeGnHd7fHO+vkAjz7HKlDvvbQB6UYBOvwYmXKScsQntRRXYdA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC4CEE000C;
	Wed,  7 Jun 2023 14:56:01 +0000 (UTC)
Date: Wed, 7 Jun 2023 16:56:00 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230607165600.535c8530@bootlin.com>
In-Reply-To: 
 <CAHp75Vd00N8z7kgTb=WTZHJW3XhsKbLfhTTKPjnCvKUSfL+xDQ@mail.gmail.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
	<20230523151223.109551-8-herve.codina@bootlin.com>
	<ZHuFywIrTnEFpX6e@surfacebook>
	<20230606155404.28ada064@bootlin.com>
	<CAHp75Vd00N8z7kgTb=WTZHJW3XhsKbLfhTTKPjnCvKUSfL+xDQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UKIAFN2YFM7CZ6MUBWN3P252JVHNH43E
X-Message-ID-Hash: UKIAFN2YFM7CZ6MUBWN3P252JVHNH43E
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UKIAFN2YFM7CZ6MUBWN3P252JVHNH43E/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andy,

On Tue, 6 Jun 2023 17:34:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > >
> > > Btw, can you avoid using OF APIs? It's better to have device property/fwnode
> > > API to be used from day 1.  
> >
> > Hum, this comment was raised in the previous iteration
> >   https://lore.kernel.org/linux-kernel/20230501162456.3448c494@jic23-huawei/
> >
> > I didn't find any equivalent to of_property_read_u32_index() in the
> > device_property_read_*() function family.
> > I mean I did find anything available to get a value from an array using an index.  
> 
> This is done by reading the entire array at once and then parsing as
> you wish in the code, device_property_read_u32_array() is for that.
> 
> > In the previous iteration it was concluded that keeping OF APIs in this series
> > seemed "reasonable".  
> 
> Maybe, but consider the above.

I see.
Will switch to device_property_*() family in the next iteration.

Thanks,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
