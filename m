Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EF7C77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 14:13:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68E6E823;
	Mon,  5 Jun 2023 16:12:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68E6E823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685974378;
	bh=mib4yiYnr4jTZMXaF3M70gmrEEloIuUKXdysYJr30cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mn27IMztYiM0rI50PXQ2nAvBF6z5r/mzLqeK28wLib94OCbQCdXG/GcPfvCZR29mo
	 Zta4nutRtQr4Cuj1h8p3TMRTc9mL6nXi2Z6arUnEg10N9xndES5RjWHsWuPCYf90L2
	 wNll9fCnDjf+NsO+bGtiUZkQkcowujp0d1eztuBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D4FFF8016C; Mon,  5 Jun 2023 16:11:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92F69F80290;
	Mon,  5 Jun 2023 16:11:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E30DF80199; Mon,  5 Jun 2023 16:11:37 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8540BF800ED
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 16:11:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8540BF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=I2dvsEv0
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1685974292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHfp+IyYPxqhLvbm8OYS3Lo9uaz8M1hK/LpKpngruro=;
	b=I2dvsEv0zE3yipuHlMDg7UA6Ckx9wEa+H7t4VCmIJcET1px6TWlt7rNFPhb/SO9IEr87xN
	wBDLyJFUk2WuVLIjnpLpNczEg7ezgRrWzNXcHfM72l4s1aK3/1FBXifJpSNNg7ovgpqdnU
	sEbgtIJ38z5zNlZtLiHlgEiq1hUq9FBgXbrBSv7ldAgs719ePTGOKJszV3E6vSlhEkmwO6
	3Y8BW+LvafTVtnj1GhZ43dI/oLHQTUVjlzbkrqkGemXrN7lKXZWEQbi28a5jY0iiatAb96
	D7cll8e4nHqA9hc6bkHvRmCcrDjnK9xkByDt3YyE/qSkEUNvWMff9ZOfwZSYKw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32278C0003;
	Mon,  5 Jun 2023 14:11:30 +0000 (UTC)
Date: Mon, 5 Jun 2023 16:11:29 +0200
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
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <20230605161129.4ac3231b@bootlin.com>
In-Reply-To: 
 <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
	<20230523151223.109551-6-herve.codina@bootlin.com>
	<ZHtIdTZbULl6t4RT@surfacebook>
	<20230605094637.7615b689@bootlin.com>
	<CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7NKYV6ZPQ5NJLIFYRH7G6IFS4M3KTZ53
X-Message-ID-Hash: 7NKYV6ZPQ5NJLIFYRH7G6IFS4M3KTZ53
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7NKYV6ZPQ5NJLIFYRH7G6IFS4M3KTZ53/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andy,

On Mon, 5 Jun 2023 12:45:24 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 5, 2023 at 10:46 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Sat, 3 Jun 2023 17:04:37 +0300
> > andy.shevchenko@gmail.com wrote:  
> > > Tue, May 23, 2023 at 05:12:19PM +0200, Herve Codina kirjoitti:  
> 
> ...
> 
> > > > +           case IIO_VAL_INT:
> > > > +                   *val = vals[--length];  
> > >  
> > > > +                   while (length) {  
> > >
> > >                       while (length--) {
> > >
> > > will do the job and at the same time...
> > >  
> > > > +                           if (vals[--length] < *val)
> > > > +                                   *val = vals[length];  
> > >
> > > ...this construction becomes less confusing (easier to parse).  
> >
> > Indeed, I will change in the next iteration.  
> 
> And looking into above line, this whole construction I would prefer to
> have a macro in minmax.h like
> 
> #define min_array(array, len) \
> {( \
>   typeof(len) __len = (len); \
>   typeof(*(array)) __element = (array)[--__len]; \
>   while (__len--) \
>     __element = min(__element, (array)[__len]); \
>   __element; \
> )}
> 
> (it might need more work, but you got the idea)

I will also introduce max_array() and update both iio_channel_read_max()
and iio_channel_read_min() to use these macros.

Will be available in the next series iteration.

Thanks,
Hervé

> 
> > > > +                   }
> > > > +                   break;  
> 
> ...
> 
> > > > +           default:
> > > > +                   /* FIXME: learn about min for other iio values */  
> > >
> > > I believe in a final version this comment won't be here.  
> >
> > We have the same FIXME comment in the iio_channel_read_max() function I
> > copied to create this iio_channel_read_min() and, to be honest, I
> > don't really know how to handle these other cases.
> >
> > In this series, I would prefer to keep this FIXME.  
> 
> I see, Jonathan needs to be involved here then.
> 
> > > > +                   return -EINVAL;  
> 
