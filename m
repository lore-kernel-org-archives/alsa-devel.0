Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7CAEB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 07:51:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B03D384A;
	Wed, 14 Jun 2023 09:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B03D384A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686729102;
	bh=7e+7ZksAfL4pOgUmmUpF/ZpeR7gAdjp6+TumaVqnWzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aJmFY1/4+P/tHgP4lbm07SlRoMJo9+JzjPhbkS27lXAk9sBqzi+JqMtvGeMfoYqO5
	 xATfD0UPTxdrxcvrCHAIJA4zzAIWFx/x4x9oOSR823eABn5W/sfFF16rAn3m9Dui8a
	 GrpgqqrO/GyyPAGWaSJ8RPhS6XTQVFkwUTBU+1xQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5040EF80587; Wed, 14 Jun 2023 09:49:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67325F80588;
	Wed, 14 Jun 2023 09:49:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BB16F80552; Wed, 14 Jun 2023 09:49:38 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50E7DF80149
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 09:49:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50E7DF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=COfOgeF0
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686728973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfYOy7L85MdtcQ88k+lfhIIjhcOaxuYtKNcPHMwEQsI=;
	b=COfOgeF0jmouxFkryE8iefc+Fl8Wp8TIdgAO4vwJpICa78tA/Ib57dXScd7eizuu6/Xsoz
	RWcB2hbJ0X4ME0OmEXQDd0BzMCwocyiVhSTB9mVSAaNoMYutDxpQPnT3UKuH4t9tVShhF5
	OjRqDhsC2K5Bq2p6ns3KCRbwkaQRkl6VfJ8y0j/piQVPhGmvwRVwU9q0Hz9Mfx+D+HkD6X
	ryL+PjEjO8vxV91FRHa8wklRps4rT8AyJzeD5teZQKi9z2bvifA0gEL/4T6SPuKuYclIjf
	GaEgm+RJlFXteoSl+IAmz0LBuzLCqEH++JclgnoHwmN7bbVfoA6aSxprEVj/Xw==
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
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 65C0C1C0015;
	Wed, 14 Jun 2023 07:49:30 +0000 (UTC)
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 03/13] iio: inkern: Check error explicitly in
 iio_channel_read_max()
Date: Wed, 14 Jun 2023 09:48:54 +0200
Message-Id: <20230614074904.29085-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YBX44TSF36XTTTSIO5VM5ZC5BFLJQZOL
X-Message-ID-Hash: YBX44TSF36XTTTSIO5VM5ZC5BFLJQZOL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YBX44TSF36XTTTSIO5VM5ZC5BFLJQZOL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The current implementation returns the error code as part of the
default switch case.
This can lead to returning an incorrect positive value in case of
iio_avail_type enum entries evolution.

In order to avoid this case, be more strict in error checking.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..f738db9a0c04 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		val2 = &unused;
 
 	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	if (ret < 0)
+		return ret;
+
 	switch (ret) {
 	case IIO_AVAIL_RANGE:
 		switch (*type) {
@@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		return 0;
 
 	default:
-		return ret;
+		return -EINVAL;
 	}
 }
 
-- 
2.40.1

