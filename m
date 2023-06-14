Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C162EB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 09:43:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68258826;
	Wed, 14 Jun 2023 11:42:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68258826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686735828;
	bh=4wYxJDnczpqWweCwm7N5UwSTIEqKoNFxrJGzUXmMgZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UB0yHGjF/s8Q91L2emrIj4NRhp5VrT1G7SlCmTvkTR64y6UpLX0+fzKbXe46qqKMC
	 WO+2XbZ9kVrPt3v5Wmj34as/aYKEwrPxUh9cEGYuOXoqQKhyFUf92Q0bfqQHKNOOyl
	 sCK/PtvIhUvraWrFkT4P/2NaHNV0t+teYXAhk0ao=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7B7BF8052E; Wed, 14 Jun 2023 11:42:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09368F80149;
	Wed, 14 Jun 2023 11:42:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB086F80149; Wed, 14 Jun 2023 11:42:25 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B62CF80093
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 11:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B62CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=d+AXI1g8
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686735738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+REmpcLHUL4BTOxA1dlLHsmBL+e+FBYJaTaqB02G6NY=;
	b=d+AXI1g8Y06cHn5FQ9HHfYpUkbPNIKBON81J0yuXI5c9++a6TK2xsCzbdQ8XJXKjFG0Ks2
	IlS6uGDcORffGChF4976ahuklePO8PU76h62Q9MZtlVuydhY/lUSXXJIrMvanEK0VvcCIS
	K7bdwjIGwjy/ZcYCKTMQSyJLmycpDiEgwWvrzcoPoEtqVH0QyxVrTlSD0rpZ2JL8KtuiqD
	wqEZQiJlji6q9zYJBnNnorhUyaGiJcnkwZA375KbgVR26OSg2D0hrHNBQUHCzhd55ZePmM
	OTYg0eqK2ss1oCOt/DkCC2gsZZALpLj+rNIViYo2eFFQrNDSZtshDR9MMEM/EA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6813C60004;
	Wed, 14 Jun 2023 09:42:15 +0000 (UTC)
Date: Wed, 14 Jun 2023 11:42:14 +0200
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
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
Message-ID: <20230614114214.1371485e@bootlin.com>
In-Reply-To: 
 <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
	<20230614074904.29085-8-herve.codina@bootlin.com>
	<CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: A7SXWDR6EJV3NYJ5O55ANHQWVCRJT3DF
X-Message-ID-Hash: A7SXWDR6EJV3NYJ5O55ANHQWVCRJT3DF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A7SXWDR6EJV3NYJ5O55ANHQWVCRJT3DF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andy,

On Wed, 14 Jun 2023 12:02:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 14, 2023 at 10:49 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Introduce min_array() (resp max_array()) in order to get the
> > minimal (resp maximum) of values present in an array.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> See a remark below.
> 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  include/linux/minmax.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index 396df1121bff..2cd0d34ce921 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -133,6 +133,42 @@
> >   */
> >  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
> >
> > +/*
> > + * Do not check the array parameter using __must_be_array().
> > + * In the following legit use-case where the "array" passed is a simple pointer,
> > + * __must_be_array() will return a failure.
> > + * --- 8< ---
> > + * int *buff
> > + * ...
> > + * min = min_array(buff, nb_items);
> > + * --- 8< ---
> > + */
> > +#define __minmax_array(op, array, len) ({                      \
> > +       typeof(array) __array = (array);                        \
> > +       typeof(len) __len = (len);                              \
> > +       typeof(__array[0] + 0) __element = __array[--__len];    \  
> 
> Do we need the ' + 0' part?

Yes.

__array can be an array of const items and it is legitimate to get the
minimum value from const items.

typeof(__array[0]) keeps the const qualifier but we need to assign __element
in the loop.
One way to drop the const qualifier is to get the type from a rvalue computed
from __array[0]. This rvalue has to have the exact same type with only the const
dropped.
'__array[0] + 0' was a perfect canditate.

Regards,
Hervé

> 
> > +       while (__len--)                                         \
> > +               __element = op(__element, __array[__len]);      \
> > +       __element; })
> > +
> > +/**
> > + * min_array - return minimum of values present in an array
> > + * @array: array
> > + * @len: array length
> > + *
> > + * Note that @len must not be zero (empty array).
> > + */
> > +#define min_array(array, len) __minmax_array(min, array, len)
> > +
> > +/**
> > + * max_array - return maximum of values present in an array
> > + * @array: array
> > + * @len: array length
> > + *
> > + * Note that @len must not be zero (empty array).
> > + */
> > +#define max_array(array, len) __minmax_array(max, array, len)
> > +
> >  /**
> >   * clamp_t - return a value clamped to a given range using a given type
> >   * @type: the type of variable to use
> > --
> > 2.40.1
> >  
> 
> 
